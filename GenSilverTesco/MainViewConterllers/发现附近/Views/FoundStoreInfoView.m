//
//  FoundStoreInfoView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "FoundStoreInfoView.h"
#import <MapKit/MapKit.h>

@implementation FoundStoreInfoView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setViewCornerRadiusViews:@[self.bgView] floatCoriner:5];
    [self setViewCornerRadiusViews:@[self.storeImageView] floatCoriner:35];
}

- (void)setFrame:(CGRect)frame{
    frame = [UIScreen mainScreen].bounds;
    [super setFrame:frame];
}

- (void)base_ButtonsClick:(UIButton *)sender{
    if (sender.tag == 0) {
        [self baseXIB_removeSubView];
    }else if (sender.tag == 1){//打电话
        [KSTool callPhone:self.phone.text];
    }else if (sender.tag == 2){//地图跳转
        [self setMapJump];
    }
    [super base_ButtonsClick:sender];
}

- (void)setData:(NSDictionary *)data{
    
    self.dataDic = [[NSDictionary alloc]initWithDictionary:data];
    
    CGSize size = [KSTool sizeWithTexte:data[@"address"] font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(260-72-8-8, MAXFLOAT)];
    
    self.layou_bgView_height.constant = 420 - 17 + ceil(size.height);
    self.address.text = data[@"address"];
    self.storeName.text = data[@"shop_name"];
    self.linkman.text = data[@"linkman"];
    self.phone.text = data[@"mobile"];
    self.distance.text = [NSString stringWithFormat:@"%@km",data[@"distance"]] ;;
    [self.storeImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,data[@"shop_img"]]] placeholderImage:KSPLAIMAGE];
    [self layoutIfNeeded];
}

- (void)setMapJump{
    [self baseXIB_removeSubView];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"跳转手机地图" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *map1 = [UIAlertAction actionWithTitle:@"苹果自带地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        [MKMapItem openMapsWithItems:@[] launchOptions:@{MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey:[NSNumber numberWithBool:YES]}];
        
    }];
    UIAlertAction *map2 = [UIAlertAction actionWithTitle:@"百度地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *urlString = [[NSString stringWithFormat:@"baidumap://map/direction?origin={{我的位置}}&destination=latlng:%f,%f|name=目的地&mode=driving&coord_type=gcj02",[self.dataDic[@"lat"] floatValue], [self.dataDic[@"lon"] floatValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
    }];
    UIAlertAction *map3 = [UIAlertAction actionWithTitle:@"高德地图" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        NSString *urlString = [[NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=%@&lat=%f&lon=%f&dev=0&style=2",@"创盈易购",@"com.GenSilverTesco.www",[self.dataDic[@"lat"] floatValue], [self.dataDic[@"lon"] floatValue]] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
        
    }];

    [alert addAction:cancle];
    [alert addAction:map1];
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]]) {
        
        [alert addAction:map2];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        
        [alert addAction:map3];
    }

    [self.vc.navigationController presentViewController:alert animated:YES completion:nil];
    
}
@end
