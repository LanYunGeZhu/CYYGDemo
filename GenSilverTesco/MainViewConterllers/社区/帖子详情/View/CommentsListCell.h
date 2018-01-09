//
//  CommentsListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsListModel.h"
@interface CommentsListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;


/** */
@property (strong, nonatomic) CommentsListModel *model;


@end
