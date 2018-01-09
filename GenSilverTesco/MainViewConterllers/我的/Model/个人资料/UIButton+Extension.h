//
//  UIButton+Extension.h
//
//
//  Created by LWW on 16/4/8.
//  Copyright © 2016年 . All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void (^CallBackBlock)(UIButton *btn);

@interface UIButton (Extension)


/**
 *  button添加事件
 *
 *  @param block 回调
 */
- (void)addClickMethod:(CallBackBlock)block;
/**
 *  button添加事件 -> 可指定触发形式
 *
 *  @param block         回调
 *  @param controlEvents 触发形式
 */
- (void)addClickMethod:(CallBackBlock)block forControlEvents:(UIControlEvents)controlEvents;


@end
