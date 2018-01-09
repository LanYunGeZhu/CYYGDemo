//
//  RegionalInformationCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionalReleaseModel.h"
@interface RegionalInformationCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *iocImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel *state;
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;

/** */
@property (copy, nonatomic) RegionalReleaseModel *model;

/** */
@property (copy, nonatomic) void(^longTap)(RegionalInformationCell *cell);




@end
