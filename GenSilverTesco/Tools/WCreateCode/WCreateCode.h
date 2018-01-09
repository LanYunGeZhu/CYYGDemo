//
//  WCreateCode.h
//  GenSilverTesco
//
//  Created by LWW on 2017/8/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WCreateCode : NSObject
+ (UIImage *)qrImageForString:(NSString *)string imageSize:(CGFloat)size;

@end
