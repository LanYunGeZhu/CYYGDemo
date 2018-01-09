//
//  WWithDrawVC.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WTouchTabDelegate.h"

@interface WWithDrawVC : KSBaseViewController

@property (nonatomic,weak)IBOutlet UIView *LeftV;
@property (nonatomic,weak)IBOutlet UILabel *LBig;
@property (nonatomic,weak)IBOutlet UILabel *LSmall;

@property (nonatomic,weak)IBOutlet UIView *ReftV;
@property (nonatomic,weak)IBOutlet UILabel *RBig;
@property (nonatomic,weak)IBOutlet UILabel *RSmall;

@property (nonatomic,weak)IBOutlet UITextField *WithDraw;

@property (nonatomic,weak)IBOutlet WTouchTabDelegate *WithTab;

@end
