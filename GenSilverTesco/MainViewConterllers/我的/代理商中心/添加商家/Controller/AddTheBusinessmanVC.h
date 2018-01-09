//
//  AddTheBusinessmanVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesManagementModel.h"
@interface AddTheBusinessmanVC : KSBaseViewController
/** */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** */
@property (weak, nonatomic) IBOutlet UITextField *phone_name;
/** */
@property (strong, nonatomic) SalesManagementModel *model;


@end
