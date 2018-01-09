//
//  BaseLoginRegisteredVC.h
//  BigWinner
//
//  Created by kangshibiao on 2017/2/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseLoginRegisteredVC : KSBaseViewController

/** */
@property (copy, nonatomic) NSString *phoneText;

@property (strong, nonatomic) NSTimer *base_timer;
/** */
@property (weak, nonatomic) IBOutlet UIButton *sendCode;

/**
 * 设置富文本
 */
- (void)setDirectLoginTitle:(UIButton *)sender title:(NSString *)title;

/** 设置placeholder 颜色*/
- (void)setTextFieldPlaceholderColor:(NSArray <UITextField *>*)views;
/** 设置圆角*/
- (void)setViewCornerRadiusViews:(NSArray <UIView *>*)view;
- (IBAction)getCode:(UIButton *)sender;

#pragma 正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPassword:(NSString *)password;

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password responseObject:(id)responseObject;

@end
