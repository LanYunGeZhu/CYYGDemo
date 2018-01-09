//
//  KSRequestManager.m
//  HSH
//
//  Created by kangshibiao on 16/6/14.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "KSRequestManager.h"
#import <AFNetworkActivityIndicatorManager.h>
@implementation KSRequestManager

+ (void)postRequestWithUrlString:(NSString *)url
                       parameter:(id)parameter
                         success:(void (^)(id responseObject))success
                         failure:(void (^) (id error))failure{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:15];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    [manager POST:[NSString stringWithFormat:@"%@%@",URL_MANURL,url] parameters:parameter progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([KSDIC(responseObject, @"status") intValue] == 1) {
            success(KSDIC(responseObject, @"data"));
        }else{
            [MBProgressHUD hideHUD];
            [MBProgressHUD showErrorMessage:KSDIC(responseObject, @"msg")];
            failure (responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [MBProgressHUD showErrorMessage:noNetwork];

    }];
}

/**
 * @param get 请求
 *
 * @param url       请求地址的url
 * @param parameter 请求参数
 * @return success   请求成功
 * @return failure   失败
 */
+ (void)gitRequestWithUrlString:(NSString *)url
                      parameter:(id)parameter
                        success:(void (^)(id responseObject))success
                        failure:(void (^) (id error))failure{
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:5];
    NSLog(@"------%@",[NSString stringWithFormat:@"%@%@",URL_MANURL,url]);
    NSLog(@"------%@",parameter);
    [manager GET:[NSString stringWithFormat:@"%@%@",URL_MANURL,url] parameters:parameter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([responseObject isKindOfClass:[NSArray class]]) {
            success(responseObject);
            return ;
        }
        if ([KSDIC(responseObject, @"status") isEqualToString:@"success"]) {
            if (![[responseObject allKeys] containsObject:@"result"]) {
                success(responseObject);
                return;
            }
            success (KSDIC(responseObject, @"result"));

        }else{
            if ([KSDIC(responseObject, @"result") isEqualToString:@"请先登录"]) {
                [[UserInfoManager sharedManager] removeUserInfoData];
                UIWindow * winodw = [[UIApplication sharedApplication].delegate window];
                KSTabBarController *tabBar = (KSTabBarController *)winodw.rootViewController;
                tabBar.selectedIndex = 0;
                return;
            }
            [MBProgressHUD showErrorMessage:KSDIC(responseObject, @"result")];
            failure(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
        [MBProgressHUD showErrorMessage:noNetwork];

    }];
    
}

/**
 * @param images 请求上传图片
 *
 * @param url       请求地址的url
 * @param parameter 请求参数
 * @param success   请求成功
 * @param failure   失败
 */
+ (void)WUpLodImageRequestWithUrlString:(NSString *)url
                             parameter:(id)parameter
                             withfile:(NSString*)filename
                                images:(NSArray *)images
                               success:(void (^)(id responseObject))success
                               failure:(void (^) (NSError *error))failure{
    
    NSMutableArray * imageArray = [NSMutableArray array];
    NSMutableArray * urlArray =  [NSMutableArray array];
    // 编辑
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            [imageArray addObject:obj];
        }else{
            NSString * newUrl = [[obj componentsSeparatedByString:URL_MANURL] lastObject];
            [urlArray addObject:@{@"imags":newUrl}];
        }
    }];
    
    if (imageArray.count == 0) {
        success(urlArray);
        return;
    }
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    [manager POST:[NSString stringWithFormat:@"%@%@",URL_MANURL,url] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(obj, .2) name:filename fileName:StringWithStr(filename, @".jpeg") mimeType:@"image/jpeg"];
            
        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([KSDIC(responseObject, @"status") intValue] == 1) {
            success(KSDIC(responseObject, @"data"));
        }else{
            [MBProgressHUD showErrorMessage:KSDIC(responseObject, @"msg")];
            failure (responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
    
    
}

/**
 * @param images 请求上传图片
 *
 * @param url       请求地址的url
 * @param parameter 请求参数
 * @param success   请求成功
 * @param failure   失败
 */
+ (void)upLodImageRequestWithUrlString:(NSString *)url
                             parameter:(id)parameter
                                images:(NSArray *)images
                               success:(void (^)(id responseObject))success
                               failure:(void (^) (NSError *error))failure{
    
    NSMutableArray * imageArray = [NSMutableArray array];
    NSMutableArray * urlArray =  [NSMutableArray array];
    // 编辑
    [images enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UIImage class]]) {
            [imageArray addObject:obj];
        }else{
            NSString * newUrl = [[obj componentsSeparatedByString:URL_MANURL] lastObject];
            [urlArray addObject:@{@"imgs":newUrl}];
        }
    }];
    
    if (imageArray.count == 0) {
        success(urlArray[0]);
        return;
    }

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];
    [manager POST:[NSString stringWithFormat:@"%@%@",URL_MANURL,url] parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [images enumerateObjectsUsingBlock:^(id  obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [formData appendPartWithFileData:UIImageJPEGRepresentation(obj, .2) name:@"name" fileName:@"name.jpeg" mimeType:@"image/jpeg"];

        }];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        if ([KSDIC(responseObject, @"status") intValue] == 1) {
            success(KSDIC(responseObject, @"data"));
        }else{
//            [MBProgressHUD showErrorMessage:KSDIC(responseObject, @"msg")];
            failure (responseObject);
        }        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];

  
}

@end
