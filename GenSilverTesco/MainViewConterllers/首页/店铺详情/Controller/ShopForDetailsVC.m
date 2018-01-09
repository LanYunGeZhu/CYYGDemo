//
//  ShopForDetailsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShopForDetailsVC.h"
#import "ShopForListCell.h"
#import "ShopIntroduceCell.h"
#import "ShopForDetailsModel.h"
#import "PageModel.h"
#import <MapKit/MapKit.h>
@interface ShopForDetailsVC ()

@property (strong, nonatomic) NSArray *datasArray;

@property (strong, nonatomic) ShopForDetailsModel *model;
@end

@implementation ShopForDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadRequsetData];
    
}

- (void)loadRequsetData{
    
    [KSRequestManager postRequestWithUrlString:URL_shopsdetail parameter:@{@"id":_storeId} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        _model = [ShopForDetailsModel whc_ModelWithJson:responseObject keyPath:@"shop"];
        
        self.datasArray = @[@{@"title":@"店长",@"context":_model.linkman}
                            ,@{@"title":@"联系电话",@"context":_model.mobile}
                           /** ,@{@"title":@"行业分类",@"context":_model.industry}*/
                            ,@{@"title":@"业务分类",@"context":_model.industry}
                            ,@{@"title":@""}
                            ,@{@"title":@"店铺地址",@"context":[NSString stringWithFormat:@"%@%@",_model.anames,_model.address]}];
        NSMutableArray *array  =[NSMutableArray array];
        PageModel *pageModel = [PageModel new];
        pageModel.ad_img = _model.shop_img;
        [array addObject:pageModel];

        [_model.imgs enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PageModel *pageModel1 = [PageModel new];
            pageModel1.ad_img = KSDIC(obj, @"imgs");
            [array addObject:pageModel1];

        }];
        self.pageView.isWebImage = YES;
        self.pageView.imageArray = array;

        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"店铺详情";
    [self addHeaderViewPageView:CGRectMake(0, 0, Screen_wide, Screen_wide *251/375)];
    [self registerTableVieCellsArray:@[@"ShopForListCell",@"ShopIntroduceCell"]];
    

}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.datasArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 3) {
        ShopIntroduceCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopIntroduceCell class]) forIndexPath:indexPath];
        cell.context.text = [_model.content isEqualToString:@""] ?  @"暂无介绍":_model.content;
        return cell;
    }else{
        ShopForListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ShopForListCell class]) forIndexPath:indexPath];
        cell.base_IndexPath = indexPath;
        if (_model) {
            cell.data = self.datasArray;

        }
        
        return cell;
    }
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        [self base_callPhone:_model.mobile];
    }else if (indexPath.row ==4){
        NSLog(@"导航");
        [KSTool alertViewWithController:self title:@"请选择" message:nil items:@[@"苹果自带地图",@"百度地图"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
            if (indx == 0) {
                [self systemMapView:[NSString stringWithFormat:@"%@%@",_model.anames,_model.address]];

            }else
            {
                [self baiDuMapView:[NSString stringWithFormat:@"%@%@",_model.anames,_model.address]];
            }
        }];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 3) {
        CGSize size = [KSTool sizeWithTexte:_model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 30, MAXFLOAT)];
        
        return ceil(size.height) + 37 + 15;
        
    }else{
        if (indexPath.row ==4) {
            CGSize size = [KSTool sizeWithTexte:[NSString stringWithFormat:@"%@%@",_model.anames,_model.address] font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 81-43, MAXFLOAT)];
            
            return ceil(size.height) +27;
        }
        return 44;
    }
}

- (void)baiDuMapView:(NSString *)address{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        CLGeocoder *geocder = [[CLGeocoder alloc] init];
        
        [geocder geocodeAddressString:address completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
            
            [placemarks enumerateObjectsUsingBlock:^(CLPlacemark * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CLLocationCoordinate2D coordinate = obj.location.coordinate;
                NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",coordinate.latitude, coordinate.longitude] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];            }];
        }];
    }
}

/** 系统地图*/
- (void)systemMapView:(NSString *)addess{
    MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
    CLGeocoder *geocder = [[CLGeocoder alloc] init];
    [geocder geocodeAddressString:addess completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        CLPlacemark *endPlacemark = placemarks.lastObject;
        MKPlacemark *endMKPlacemark = [[MKPlacemark alloc]initWithPlacemark:endPlacemark];
        
        MKMapItem *endMapItem = [[MKMapItem alloc]initWithPlacemark:endMKPlacemark];
        
        [MKMapItem openMapsWithItems:@[currentLocation,endMapItem] launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey : [NSNumber numberWithBool:YES] }];
    }];
}



@end
