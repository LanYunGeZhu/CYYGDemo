//
//  ShopForListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopForListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** */
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_context_trailing;
@end
