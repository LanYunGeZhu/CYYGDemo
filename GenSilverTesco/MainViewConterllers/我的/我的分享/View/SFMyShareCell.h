//
//  SFMyShareCell.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMyShareModel.h"

@interface SFMyShareCell : UITableViewCell

@property (nonatomic,strong) SFMyShareModel *model ;

@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *getCode;

@end
