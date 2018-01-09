//
//  WTouchTabDelegate.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WTouchTabDelegate.h"
//重写touch事件
@implementation WTouchTabDelegate

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    
    if ([_toucDelegate conformsToProtocol:@protocol(TouchDelegate)] &&
        [_toucDelegate respondsToSelector:@selector(tableView:touchesBegan:withEvent:)])
    {
        [_toucDelegate tableView:self touchesBegan:touches withEvent:event];
    }
}


@end
