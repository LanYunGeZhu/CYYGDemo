//
//  WPoPaction.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, PopoverViewStyle) {
    PopoverViewStyleDefault = 0, // 默认风格, 白色
    PopoverViewStyleDark, // 黑色风格
};

@interface WPoPaction : NSObject

@property (nonatomic, strong, readonly) UIImage *image; ///< 图标 (建议使用 60pix*60pix 的图片)
@property (nonatomic, copy, readonly) NSString *title; ///< 标题
@property (nonatomic, copy, readonly) void(^handler)(WPoPaction *action); ///< 选择回调, 该Block不会导致内存泄露, Block内代码无需刻意去设置弱引用.
@property (nonatomic, assign) NSInteger tag; ///< tag值

+ (instancetype)actionWithTitle:(NSString *)title withTag:(NSInteger)tag handler:(void (^)(WPoPaction *action))handler;

+ (instancetype)actionWithImage:(UIImage *)image withTag:(NSInteger)tag title:(NSString *)title handler:(void (^)(WPoPaction *action))handler;
@end
