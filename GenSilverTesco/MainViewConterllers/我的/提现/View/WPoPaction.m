//
//  WPoPaction.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WPoPaction.h"
@interface WPoPaction ()

@property (nonatomic, strong, readwrite) UIImage *image; ///< 图标
@property (nonatomic, copy, readwrite) NSString *title; ///< 标题
@property (nonatomic, copy, readwrite) void(^handler)(WPoPaction *action); ///< 选择回调

@end

@implementation WPoPaction

+ (instancetype)actionWithTitle:(NSString *)title withTag:(NSInteger)tag handler:(void (^)(WPoPaction *action))handler {
    return [self actionWithImage:nil withTag:tag title:title handler:handler];
}

+ (instancetype)actionWithImage:(UIImage *)image withTag:(NSInteger)tag title:(NSString *)title handler:(void (^)(WPoPaction *action))handler {
    WPoPaction *action = [[self alloc] init];
    action.image = image;
    action.title = title ? : @"";
    action.handler = handler ? : NULL;
    action.tag = tag;
    
    return action;
}
@end
