//
//  FoundNearVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "FoundNearVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "CustomAnnotationView.h"
#import "FoundStoreInfoView.h"
#import "KSAddressView.h"

@interface FoundNearVC ()<MAMapViewDelegate>

@property (strong, nonatomic) MAMapView *mapView;

@property (nonatomic,strong) NSURLSessionTask *task ;

@end

@implementation FoundNearVC

- (void)viewWillAppear:(BOOL)animated{
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        [self addAlert];
    }
        
        
}
- (void)addAlert{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您当前没有开启定位！请到设置里面开启" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //f8e811c561a6e5b8a21a6769a7be29ab
    
    [self addMapView];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"当前位置" style:(UIBarButtonItemStylePlain) target:self action:@selector(rightBtn)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addData:(NSString *)addStr{
    
    [KSRequestManager postRequestWithUrlString:@"api/user.php?act=get_near_shops" parameter:@{@"address":addStr} success:^(id responseObject) {
        
        NSLog(@"---%@",responseObject);
        
        for (NSDictionary *dic in responseObject[@"lists"]) {
            
            [self.datasMutabDic addEntriesFromDictionary:@{dic[@"shop_name"]:dic}];
            
            CLLocationCoordinate2D ra = CLLocationCoordinate2DMake([dic[@"lat"] floatValue], [dic[@"lon"] floatValue]);
            
            MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
            annotation.coordinate = ra;
            annotation.title = dic[@"shop_name"];
            annotation.subtitle = dic[@"address"];
            [self.mapView addAnnotation:annotation];
            NSLog(@"1");
        }
        
    } failure:^(id error) {
        
    }];
}

//- (void)addAction
//{
//    
//    CLLocationCoordinate2D randomCoordinate = [self.mapView convertPoint:[self randomPoint] toCoordinateFromView:self.view];
//    
//    [self addAnnotationWithCooordinate:randomCoordinate];
//
//}
//
//- (CGPoint)randomPoint
//{
//    CGPoint randomPoint = CGPointZero;
//    
//    randomPoint.x = arc4random() % (int)(CGRectGetWidth(self.view.bounds));
//    randomPoint.y = arc4random() % (int)(CGRectGetHeight(self.view.bounds));
//    
//    return randomPoint;
//}
//
//-(void)addAnnotationWithCooordinate:(CLLocationCoordinate2D)coordinate
//{
//    MAPointAnnotation *annotation = [[MAPointAnnotation alloc] init];
//    annotation.coordinate = coordinate;
//    annotation.title    = @"AutoNavi";
//    annotation.subtitle = @"CustomAnnotationView";
//    
//    [self.mapView addAnnotation:annotation];
//}

- (void)addMapView{
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];

    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeNone;
    _mapView.distanceFilter = 1000;
    self.mapView.userLocation.title = @"您的位置在这里";
    _mapView.zoomLevel = 16;
    _mapView.delegate = self;
    ///把地图添加至view
    
    MAUserLocationRepresentation *represent = [[MAUserLocationRepresentation alloc] init];
    represent.showsAccuracyRing = YES;
    represent.showsHeadingIndicator = YES;
    represent.image = [UIImage imageNamed:@"gerendingwei"];
    [self.mapView updateUserLocationRepresentation:represent];

}

//- (void)buttonClick{
//    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//}


#pragma mark - mapview delegate
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if (updatingLocation)
    {
    
        static dispatch_once_t aaa;
        dispatch_once(&aaa, ^{
            
            [_mapView setCenterCoordinate:userLocation.coordinate animated:YES];
            //反向地理编码
            CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
            
            CLLocation *cl = [[CLLocation alloc] initWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
            
            [clGeoCoder reverseGeocodeLocation:cl completionHandler: ^(NSArray *placemarks,NSError *error) {
                
                if (placemarks.count > 0) {
                    
                    CLPlacemark *placeMark = placemarks[0];
                    
                    NSDictionary *addressDic = placeMark.addressDictionary;
                    
                    
                    
                    NSString *state=[addressDic objectForKey:@"State"];
                    
                    NSString *city=[addressDic objectForKey:@"City"];
                    
                    NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
                    
                    NSString *street=[addressDic objectForKey:@"Name"];
                    
                    NSString *address = [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
                    NSLog(@"所在城市====%@ %@ %@ %@", state, city, subLocality, street);
                    
                    //导航栏定位显示
                    [self selfINiTNavigationItem_rightIcon:@"addressb" itemTitle:subLocality];
                    if (address && address.length > 0) {
                        
                        //根据定位获取数据
                        [self addData:address];
                    }else{
                        [MBProgressHUD showErrorMessage:@"定位失败"];
                    }
                }
                
                
            }];
            
        });
    }
}

//定位失败
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    [MBProgressHUD showErrorMessage:@"定位失败"];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([NSStringFromClass([MAUserLocation class]) isEqualToString:NSStringFromClass([annotation class])]) {
        return nil;
    }
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *customReuseIndetifier = @"customReuseIndetifier";
        
        CustomAnnotationView *annotationView = (CustomAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            // must set to NO, so we can show the custom callout view.
            annotationView.canShowCallout = NO;
            annotationView.draggable = YES;
            annotationView.calloutOffset = CGPointMake(0, -5);
        }
        
        annotationView.name     = annotation.title;
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view
{
    if ([NSStringFromClass([MAUserLocation class]) isEqualToString:NSStringFromClass([view class])]) {
        return ;
    }

    if ([view isKindOfClass:[CustomAnnotationView class]])
    {
        NSString *sss = view.annotation.title;
        FoundStoreInfoView *infoView = [FoundStoreInfoView initBaseView];
        infoView.vc = self;
        infoView.data = self.datasMutabDic[sss];
        infoView.base_BlockIdx = ^(NSInteger index){
            [_mapView deselectAnnotation:view.annotation animated:NO];
        };
        
        [infoView baseXIB_showAlpha:.5 color:nil];
        
    }
}



- (void)selfINiTNavigationItem_rightIcon:(NSString *)iconName itemTitle:(NSString *)title
{
    
    UIFont *font = [UIFont systemFontOfSize:15];
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, 40) options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName : font} context:nil].size;
    CGFloat buttonW = size.width;
    _lefadd = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _lefadd.frame = CGRectMake(18, 0, buttonW, 40);
    [_lefadd setTitle:title forState:(UIControlStateNormal)];
    [_lefadd addTarget:self action:@selector(navButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    _lefadd.titleLabel.font = font;
    
    CGFloat imageW    = 14;
    CGFloat upPadding = (40 - 18)/2;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, upPadding, imageW, 18)];
    imageView.image = [UIImage imageNamed:iconName];
    
    UIView *rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, imageW+buttonW, 40)];
    [rightView addSubview:imageView];
    [rightView addSubview:_lefadd];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.leftBarButtonItem = rightItem;
    
    
}
- (void)navButtonClick:(UIButton *)btn{
    
    KSAddressView *addressView = [KSAddressView initBaseView];
    addressView.frame = [UIScreen mainScreen].bounds;
    addressView.addressPickViewBlock = ^(id province,id city,id arer){
        NSString *add = [NSString stringWithFormat:@"%@%@%@",KSDIC(province, @"region_name"),KSDIC(city, @"region_name"),KSDIC(arer, @"region_name")];
        [btn setTitle:KSDIC(arer, @"region_name") forState:(UIControlStateNormal)];
        //根据定位获取数据
        [self getLatLon:add];
        
    };
    [addressView baseXIB_showAlpha:.3 color:nil];
    
}

//获取经纬度
- (void)getLatLon:(NSString *)add{

    //创建编码对象
    CLGeocoder *geocoder=[[CLGeocoder alloc]init];
    //判断是否为空
    if (add.length ==0) {
        return;
    }
    [geocoder geocodeAddressString:add completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error!=nil || placemarks.count==0) {
            [MBProgressHUD showErrorMessage:@"查询失败请重试"];
            return ;
        }
        //创建placemark对象
        CLPlacemark *placemark=[placemarks firstObject];
        //赋值经度
        CGFloat loon = placemark.location.coordinate.longitude;
        //赋值纬度
        CGFloat laat = placemark.location.coordinate.latitude;
        [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(laat,loon) animated:YES];
        [self addData:add];
    }];

}

- (void)rightBtn{
    
    [_mapView setCenterCoordinate:self.mapView.userLocation.coordinate animated:YES];
    // 获取用户输入的经纬度
    double latitude = self.mapView.userLocation.coordinate.latitude;
    double longitude = self.mapView.userLocation.coordinate.longitude;
    
    CLLocation *location = [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    
    // 反地理编码(经纬度---地址)
    CLGeocoder*geoC = [[CLGeocoder alloc] init];
    [geoC reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error == nil)
        {
            CLPlacemark *pl = [placemarks firstObject];
            NSDictionary *addressDic = pl.addressDictionary;
            NSString *state=[addressDic objectForKey:@"State"];
            NSString *city=[addressDic objectForKey:@"City"];
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];
            NSString *street=[addressDic objectForKey:@"Name"];
            NSString *address = [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
            [self addData:address];
            
            [_lefadd setTitle:subLocality forState:(UIControlStateNormal)];
            
        }else
        {
            NSLog(@"错误");
        }
    }];
    
    
}



//// 调用获取中心点坐标代理方法
//- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
//    MACoordinateRegion region;
//    CLLocationCoordinate2D centerCoordinate = mapView.region.center;
//    region.center= centerCoordinate;
//
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    CLLocation *location = [[CLLocation alloc]initWithLatitude:centerCoordinate.latitude longitude:centerCoordinate.longitude];
//    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
//        for (CLPlacemark *place in placemarks) {
//            NSDictionary *location =[place addressDictionary];
//            NSLog(@"省：%@",[location objectForKey:@"State"]);
//            NSLog(@"市：%@",[location objectForKey:@"City"]);
//            NSLog(@"区：%@",[location objectForKey:@"SubLocality"]);
//            
//            
//            NSString *addd = [NSString stringWithFormat:@"%@%@%@",[location objectForKey:@"State"],[location objectForKey:@"City"],[location objectForKey:@"SubLocality"]] ;
//            //导航栏定位显示
//            [self selfINiTNavigationItem_rightIcon:@"addressb" itemTitle:[location objectForKey:@"SubLocality"]];
//            //根据定位获取数据
//            [self addData:addd];
//        }
//    }];
//    
//}

@end
