//
//  UIView+Kiwi.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^CallBack) (UIView *wView);

@interface UIView (Kiwi)

/*
 
 添加事件
 
 */

- (void)addCallBack:(CallBack)block;

@end
