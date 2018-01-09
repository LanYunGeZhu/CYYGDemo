//
//  RefundsListCell.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefundsListModel.h"

@interface RefundsListCell : UITableViewCell

/** */
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_price;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_num;
/** */
@property (weak, nonatomic) IBOutlet UILabel *goods_property;
/** */
@property (strong, nonatomic) RefundsListModel *model;

@end
