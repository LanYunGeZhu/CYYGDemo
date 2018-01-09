//
//  KSCLLocationManager.m
//  HSH
//
//  Created by kangshibiao on 16/7/12.
//  Copyright © 2016年 mc. All rights reserved.
//

#import "KSCLLocationManager.h"

@implementation KSCLLocationManager

+ (KSCLLocationManager *)shareManager{
    static KSCLLocationManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
    });
    return manager;
}

- (CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)start{
    
    if ([self whetherLoction])
    {
        [self addAlert];
        
        return;
    }
    _loctionManager =[[CLLocationManager alloc]init];
    _loctionManager.delegate = self;
    // 移动多少米定位一次,启动位置更新
    self.loctionManager.distanceFilter = 1000.0f;
    // 定位精度达到多少米的要求
    self.loctionManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    // 设置定位服务的访问方式
    [self.loctionManager requestWhenInUseAuthorization];
    [_loctionManager startUpdatingLocation];

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
  
    CLLocation* location = [locations lastObject];
    if (_isCity) {
        [self startReverseGeocoding:location];
    }else{
        if (_locationBlock) {
            _locationBlock (location,@"");
        }
    }
    [self.loctionManager stopUpdatingLocation];

}

- (void)startReverseGeocoding:(CLLocation *)loction{
    WeakSelf
//    self.locationManager = [[AMapLocationManager alloc] init];
//
//    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
//
//    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
//    {
//        if (error != nil && error.code == AMapLocationErrorLocateFailed)
//        {
//            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
//            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.localizedDescription);
//            return;
//        }
//        else if (error != nil
//                 && (error.code == AMapLocationErrorReGeocodeFailed
//                     || error.code == AMapLocationErrorTimeOut
//                     || error.code == AMapLocationErrorCannotFindHost
//                     || error.code == AMapLocationErrorBadURL
//                     || error.code == AMapLocationErrorNotConnectedToInternet
//                     || error.code == AMapLocationErrorCannotConnectToHost))
//        {
//            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
//            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.localizedDescription);
//        }
//        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
//        {
//            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
//            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.localizedDescription);
//            return;
//        }
//        else
//        {
//            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
//        }
//        
//        //修改label显示内容
//        if (regeocode)
//        {
//            if (weakSelf.locationBlock) {
//                weakSelf.locationBlock (location,regeocode);
//    
//            }
////            [weakSelf.displayLabel setText:[NSString stringWithFormat:@"%@ \n %@-%@-%.2fm", regeocode.formattedAddress,regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
//        }
//        else
//        {
////            [weakSelf.displayLabel setText:[NSString stringWithFormat:@"lat:%f;lon:%f \n accuracy:%.2fm", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy]];
//            NSLog(@"----%@",[NSString stringWithFormat:@"lat:%f;lon:%f \n accuracy:%.2fm", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy]);
//        }
//    };

    [self.geocoder reverseGeocodeLocation:loction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (error || placemarks.count == 0) {
        }else{
            CLPlacemark *current = [placemarks firstObject];

//            NSLog(@"---%@---%@--%@--%@--%@--%@",current.name,current.region,current.locality,current.administrativeArea,current.subAdministrativeArea,current.description);
//            NSDictionary *currentPlace = [[placemarks firstObject] addressDictionary];
//            NSLog(@"---%@",currentPlace);
//            NSDictionary *addressDic = current.addressDictionary;
////
//            
//            NSString *state=KSDIC(addressDic, @"State");
//            
//            NSString *city= KSDIC(addressDic, @"City");
//            NSString *subLocality=KSDIC(addressDic, @"SubLocality");
            if (weakSelf.locationBlock) {
                weakSelf.locationBlock(loction,[current addressDictionary]);
            }
        }
    }];
}

- (BOOL)whetherLoction{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status)
    {
        return YES;
    }
    return NO;
}

- (void)addAlert{
    UIAlertView *alertView =[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"您当前没有开启定位！请到设置里面开启" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1){
        [self setLcotion];
    }
}

- (void)setLcotion{
//    NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];

//    if ([[UIApplication sharedApplication] canOpenURL:url])
//    {
//        [[UIApplication sharedApplication] openURL:url];
//    }
    NSLog(@"没有开定位");
}

@end
