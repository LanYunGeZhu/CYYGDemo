//
//  MemberOfTheManagementCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberOfTheManagementModel.h"
@interface MemberOfTheManagementCell : KSBaseTableViewCell

/** */
@property (weak, nonatomic) IBOutlet UILabel *merchantsMember;
/** */
@property (weak, nonatomic) IBOutlet UILabel *benefit;
/** */
@property (weak, nonatomic) IBOutlet UILabel *name_phone;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** */
@property (strong, nonatomic) MemberOfTheManagementModel *model;


@end
