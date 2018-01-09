//
//  UIButton+Extension.h
//
//
//  Created by LWW on 16/4/8.
//  Copyright © 2016年 . All rights reserved.
//

#import "UIButton+Extension.h"

#import <objc/runtime.h>


@implementation UIButton (Extension)

static char identifier;
- (void)addClickMethod:(CallBackBlock)block
{
    objc_setAssociatedObject(self, &identifier, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addClickMethod:(CallBackBlock)block forControlEvents:(UIControlEvents)controlEvents
{
    objc_setAssociatedObject(self, &identifier, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addTarget:self action:@selector(clickButton:) forControlEvents:controlEvents];
}
/**
 *  事件的响应方法
 *
 *  @param sender 按钮
 */
- (void)clickButton:(id)sender{
    CallBackBlock blockAction = objc_getAssociatedObject(self, &identifier);
    if (blockAction) {
        blockAction(self);
    }
}
@end
