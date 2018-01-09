//
//  RefundsInfoCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefundsListModel.h"

@interface RefundsInfoCell : UITableViewCell
//描述
@property (nonatomic,strong) UILabel *describeLab ;

@property (nonatomic,strong) RefundsListModel *model ;
@end
