//
//  ManagePointsCell.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ManagePointsModel.h"

@interface ManagePointsCell : UITableViewCell

@property (nonatomic,strong) ManagePointsModel *model ;

@property (weak, nonatomic) IBOutlet UILabel *nameLab;//会员
@property (weak, nonatomic) IBOutlet UILabel *statusLab;//状态
@property (weak, nonatomic) IBOutlet UILabel *priceLab;//价格
@property (weak, nonatomic) IBOutlet UILabel *profitsLab;//让利
@property (weak, nonatomic) IBOutlet UILabel *timeLab;//时间

@end
