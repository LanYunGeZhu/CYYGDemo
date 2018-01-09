//
//  WPswView.h
//  GenSilverTesco
//
//  Created by LWW on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WPswView : KSBaseXIBView<UITextFieldDelegate>

@property (nonatomic,weak)IBOutlet UITextField *WPswtext;
@property (nonatomic,weak)IBOutlet UIView *WPswView;
@property (nonatomic,weak)IBOutlet UIButton*Btn;
- (void)removeFrom;
@end
