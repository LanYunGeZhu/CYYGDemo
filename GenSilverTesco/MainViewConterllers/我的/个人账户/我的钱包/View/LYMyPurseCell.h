//
//  LYMyPurseCell.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LYMyPurseModel.h"

@interface LYMyPurseCell : UITableViewCell

@property (nonatomic,strong) LYMyPurseModel *model ;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *getCode;

@end
