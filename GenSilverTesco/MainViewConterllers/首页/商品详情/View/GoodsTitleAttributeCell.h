//
//  GoodsTitleAttributeCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsTitleAttributeCell : KSBaseTableViewCell

/** 商品名字*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 快递费*/
@property (weak, nonatomic) IBOutlet UILabel *courierFees;
/** 价格*/
@property (weak, nonatomic) IBOutlet UILabel *price;
/** 销量*/
@property (weak, nonatomic) IBOutlet UILabel *sales;

@end
