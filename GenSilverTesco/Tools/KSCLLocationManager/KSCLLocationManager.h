//
//  KSCLLocationManager.h
//  HSH
//
//  Created by kangshibiao on 16/7/12.
//  Copyright © 2016年 mc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>

@import CoreLocation;

typedef void(^logtiomBlock)(CLLocation *loction,id locality);
@interface KSCLLocationManager : NSObject <CLLocationManagerDelegate>
@property (strong, nonatomic)CLLocationManager *loctionManager;
/** */
@property (strong, nonatomic) CLGeocoder *geocoder;

/** 回传经纬度*/
@property (copy, nonatomic) logtiomBlock locationBlock;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

/** 是否需要逆地理编码 默认不需要*/
@property (assign, nonatomic) BOOL isCity;

+ (KSCLLocationManager *)shareManager;
/** 开始定位*/
- (void)start;
@end
