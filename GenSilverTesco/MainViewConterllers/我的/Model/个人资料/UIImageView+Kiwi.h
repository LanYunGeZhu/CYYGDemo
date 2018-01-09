//
//  UIImageView+Kiwi.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WCallBack)(UIImageView *wImageView);

@interface UIImageView (Kiwi)


/**
 *  imageView添加事件
 *
 *  @param block 回调
 */
- (void)addClickMethod:(WCallBack)block;



@end
