//
//  AmountCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AmountCell : KSBaseTableViewCell
/**年让利金 */
@property (weak, nonatomic) IBOutlet UILabel *yearsOnGold;
/** 月让利金*/
@property (weak, nonatomic) IBOutlet UILabel *monthOnGold;
/** 添加 背景*/
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** */
@property (weak, nonatomic) IBOutlet UIButton *addMerchants;

/** */
@property (weak, nonatomic) IBOutlet UILabel *title1;
/** */
@property (weak, nonatomic) IBOutlet UILabel *title2;
@end
