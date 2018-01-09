//
//  SalesListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SalesListModel.h"
@interface SalesListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *storeName;
/** */
@property (weak, nonatomic) IBOutlet UILabel *name_phone;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;

/** */
@property (strong, nonatomic) SalesListModel *model;


@end
