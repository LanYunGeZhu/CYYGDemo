//
//  UIImage+Add.h
//  Merchant
//
//  Created by ibendi on 16/3/31.
//  Copyright © 2016年 ibendi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Add)

+ (UIImage *)getQrImageString:(NSString *)string Size:(CGFloat)size withRed:(CGFloat)red Green:(CGFloat)green Blue:(CGFloat)blue;

@end
