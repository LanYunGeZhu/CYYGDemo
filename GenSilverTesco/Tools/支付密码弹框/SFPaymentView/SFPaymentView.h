//
//  SFPaymentView.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/7.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SFPaymentView : UIView

@property (nonatomic, copy) NSString *title, *detail;
@property (nonatomic, assign) CGFloat amount;

@property (nonatomic,copy) void (^completeHandle)(NSString *inputPwd,UITextField *pwTF);

- (void)show;
- (void)dismiss;

@end
