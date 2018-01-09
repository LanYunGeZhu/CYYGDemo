//
//  MyAddressCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressModel.h"
@interface MyAddressCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *phone;
/** */
@property (weak, nonatomic) IBOutlet UILabel *address;

/** */
@property (strong, nonatomic) MyAddressModel *model;


@end
