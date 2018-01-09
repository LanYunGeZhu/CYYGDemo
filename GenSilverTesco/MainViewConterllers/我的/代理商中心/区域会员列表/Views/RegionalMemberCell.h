//
//  RegionalMemberCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionalOrderApprovalCell.h"
#import "RegionalMemberModel.h"
@interface RegionalMemberCell : RegionalOrderApprovalCell
// suuper
/** 会员姓名*/
@property (weak, nonatomic) IBOutlet UILabel *memberName;

/** */
@property (strong, nonatomic) RegionalMemberModel *modelMember;


@end
