//
//  GoodsMenusCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
@interface GoodsMenusCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;
/** */
@property (strong, nonatomic) GoodsDetailsModel *model;


@end
