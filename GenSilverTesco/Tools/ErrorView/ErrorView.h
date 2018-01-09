//
//  ErrorView.h
//  BigWinner
//
//  Created by kangshibiao on 2017/3/2.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ErrorView : KSBaseXIBView

@property (copy, nonatomic) void(^loadButton)();
/** */
@property (weak, nonatomic) IBOutlet UIButton *menus_button;

@end
