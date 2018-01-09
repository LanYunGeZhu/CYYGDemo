//
//  NewLatestInformationCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewLatestModel.h"
@interface NewLatestInformationCell : KSBaseTableViewCell
/** 标题*/
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 内容*/
@property (weak, nonatomic) IBOutlet UILabel *context;
/** 时间*/
@property (weak, nonatomic) IBOutlet UILabel *timer;

/** */
@property (strong, nonatomic) NewLatestModel *model;
/**n*/
@property (assign, nonatomic) NSInteger newLatesType;


@end
