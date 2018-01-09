//
//  BaseNavSerachViewVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SearchNavView.h"

@interface BaseNavSerachViewVC : KSBaseRefreshViewController

/** 导航栏搜索*/
@property (strong, nonatomic) SearchNavView *searchView;

@property (copy, nonatomic) void(^serachStringBlock)(NSString *serachText);

/** 添加导航 搜索  response 是否 响应
 *               isAddress 是否显示地址
 */
- (void)addNavSerachView:(CGRect)frame isResponse:(BOOL)response addressTextIco:(BOOL)isAddress;

@end
