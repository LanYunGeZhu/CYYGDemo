//
//  PriceListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PriceListCell : KSBaseTableViewCell
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/**  右边 内容*/
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;
/** 中间内容*/
@property (weak, nonatomic) IBOutlet UILabel *centerContext;

/** */
@property (weak, nonatomic) IBOutlet UIButton *mensBtn;

@property (assign, nonatomic) BOOL isShowTitle;
@end
