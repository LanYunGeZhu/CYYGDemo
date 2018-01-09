//
//  RegisteredVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseLoginRegisteredVC.h"
@interface RegisteredVC : BaseLoginRegisteredVC

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *bgViews;

/** */
@property (weak, nonatomic) IBOutlet UITextField *phone;
/** */
@property (weak, nonatomic) IBOutlet UITextField *code;
/** */
@property (weak, nonatomic) IBOutlet UITextField *password;

@end
