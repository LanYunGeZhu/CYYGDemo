//
//  SFWeatherVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/8/11.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFWeatherVC.h"
#import "KSCLLocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <MapKit/MapKit.h>
#import "SFWeatherCell.h"

@interface SFWeatherVC ()<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSString *address ;
@property (strong,nonatomic) CLLocationManager* locationManager;
@property (nonatomic,strong) NSMutableArray *dataArray ;

@property (nonatomic,assign) CGFloat latf ;
@property (nonatomic,assign) CGFloat lonf ;
@end

@implementation SFWeatherVC
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    
    //开启定位
    [self openLocation];

}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"天气预报";
    
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    [self.myTableView registerNib:[UINib nibWithNibName:@"SFWeatherCell" bundle:nil] forCellReuseIdentifier:@"SFWeatherCell"];
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    
    [self startLocation];
    
}

//开始定位
-(void)startLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    if ([[[UIDevice currentDevice]systemVersion]doubleValue] >8.0){
        [self.locationManager requestWhenInUseAuthorization];
    }
    [self.locationManager startUpdatingLocation];
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    
    
    
    CLLocation *newLocation = locations[0];
    
    CLLocationCoordinate2D aaa = newLocation.coordinate;
    
    [manager stopUpdatingLocation];
    
    _lonf = aaa.longitude;
    _latf = aaa.latitude;
//根据经纬度获取天气
    [self getWeatherMessage:_lonf latitudevalue:_latf];
    
}

//根据经纬度获取天气
- (void)getWeatherMessage:(CGFloat)lon latitudevalue:(CGFloat)lat{
    
    
    NSString *appcode = @"98d2dec98c7b46589a6078deca2ee05c";
    NSString *host = @"http://aliv2.data.moji.com";
    NSString *path = @"/whapi/json/aliweather/briefforecast3days";
    NSString *method = @"POST";
    NSString *querys = @"";
    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    NSString *bodys = [NSString stringWithFormat:@"lat=%f8&lon=%f&token=443847fa1ffd4e69d929807d42c2db1b",lat,lon];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval: 20];
    request.HTTPMethod  =  method;
    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    [request addValue: @"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField: @"Content-Type"];
    NSData *data = [bodys dataUsingEncoding: NSUTF8StringEncoding];
    [request setHTTPBody: data];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            
            if (!body) {
                [MBProgressHUD showErrorMessage:@"查询天气失败"];
                return ;
            }
            
            NSDictionary *jsonDict = [[NSDictionary alloc]initWithDictionary:[NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingMutableLeaves error:nil]];
            
            //打印应答中的body
            NSLog(@"%@",jsonDict);
            
            _cityLab.text = jsonDict[@"data"][@"city"][@"name"];
            
            _dataArray = [[NSMutableArray alloc]initWithArray:jsonDict[@"data"][@"forecast"]];
            if (_dataArray.count > 0) {
                _weatherLab.text = _dataArray[0][@"conditionDay"];
            }
            
            _temperatureLab.text = [NSString stringWithFormat:@" %@°",_dataArray[0][@"tempDay"]] ;
            
            [self.myTableView reloadData];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [_refreshBtn.layer removeAllAnimations];
                [MBProgressHUD showSuccessMessage:@"刷新成功"];
                
            });
        });
        
        
        
    }];
    
    [task resume];
}



- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}
//刷新天气
- (IBAction)updateBtn:(id)sender {
    if (!_lonf || !_latf) {
        [MBProgressHUD showErrorMessage:@"定位失败,请刷新重试"];
        [self loadRequsetData];
        return;
    }
    
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //默认是顺时针效果，若将fromValue和toValue的值互换，则为逆时针效果
    animation.fromValue = [NSNumber numberWithFloat:0.f];
    animation.toValue =  [NSNumber numberWithFloat: M_PI *2];
    animation.duration = .5;
    animation.autoreverses = NO;
    animation.fillMode =kCAFillModeForwards;
    animation.repeatCount = MAXFLOAT; //如果这里想设置成一直自旋转，可以设置为MAXFLOAT，否则设置具体的数值则代表执行多少次
    [_refreshBtn.layer addAnimation:animation forKey:nil];
    
    //根据经纬度获取天气
    [self getWeatherMessage:_lonf latitudevalue:_latf];
}
#pragma mark 代理方法回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    SFWeatherCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"SFWeatherCell"];
    
    if (!cell) {
        cell = [[SFWeatherCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SFWeatherCell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    
    if (_dataArray.count > 0) {
        
        NSDictionary *dic = _dataArray[indexPath.row];
        cell.lab1.text = dic[@"predictDate"];
        cell.lab3.text = [NSString stringWithFormat:@"%@~%@",dic[@"tempDay"],dic[@"tempNight"]] ;
        [cell.btn2 setTitle:dic[@"conditionDay"] forState:(UIControlStateNormal)];
    }
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Screen_heigth/667*44;
    
}


- (void)openLocation{
    //请开启定位服务
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"定位未开启,请到设置->隐私->定位服务中开启【创盈易购】定位服务,已便获取天气信息!" preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            [MBProgressHUD showErrorMessage:@"获取天气失败,请先开启定位"];
        }];
        UIAlertAction *maketure = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }];
        [alert addAction:cancle];
        [alert addAction:maketure];
        [self.navigationController presentViewController:alert animated:YES completion:nil];
        


    }
}

@end
