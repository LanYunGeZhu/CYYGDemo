//
//  SetNewPasswordVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/31.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetNewPasswordVC : KSBaseViewController
/** */
@property (weak, nonatomic) IBOutlet UITextField *password1;
/** */
@property (weak, nonatomic) IBOutlet UITextField *password2;
/** */
@property (copy, nonatomic) NSString *phone;


@end
