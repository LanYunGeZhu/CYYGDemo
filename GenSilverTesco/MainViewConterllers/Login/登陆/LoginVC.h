//
//  LoginVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainLoginVC.h"
@interface LoginVC : KSBaseViewController
/** */
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *bgViews;

/** */
@property (strong, nonatomic) MainLoginVC *loginMain;

/** */
@property (weak, nonatomic) IBOutlet UITextField *phone;
/** */
@property (weak, nonatomic) IBOutlet UITextField *password;


- (void)loginInUSerName:(NSString *)userName passWord:(NSString *)passWord;
@end
