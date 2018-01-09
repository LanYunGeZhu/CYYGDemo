//
//  RegionalMemberVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegionalMemberVC : KSBaseRefreshViewController
/** 新增人数*/
@property (weak, nonatomic) IBOutlet UILabel *theNewNumber;
/** 总会员量 */
@property (weak, nonatomic) IBOutlet UILabel *alwaysPartQuantity;
@end
