//
//  AddAddressVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressModel.h"
@interface AddAddressVC : KSBaseViewController
/** */
@property (weak, nonatomic) IBOutlet UITextField *nameField;
/** */
@property (weak, nonatomic) IBOutlet UITextField *phoneField;
/** */
@property (weak, nonatomic) IBOutlet UIButton *address;
/** */
@property (weak, nonatomic) IBOutlet UITextField *addressInfo;

/** */
@property (strong, nonatomic) MyAddressModel *model;

/** */
@property (copy, nonatomic) void(^updataAddress)();


/**  1 编辑*/
@property (assign, nonatomic) NSInteger  edit;

@end
