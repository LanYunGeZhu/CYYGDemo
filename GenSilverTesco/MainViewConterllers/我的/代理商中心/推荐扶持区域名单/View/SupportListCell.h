//
//  SupportListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SupportListModel.h"
@interface SupportListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *agentName;
/** */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** */
@property (weak, nonatomic) IBOutlet UIButton *area;
/** */
@property (strong, nonatomic) SupportListModel *model;


@end
