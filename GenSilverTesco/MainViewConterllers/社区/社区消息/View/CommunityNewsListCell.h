//
//  CommunityNewsListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductEvaluationListCell.h"
#import "CommunityNewsModel.h"

@interface CommunityNewsListCell : ProductEvaluationListCell


// 其他 在声明 在父类 ProductEvaluationListCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *address;

/** */
@property (weak, nonatomic) IBOutlet UIView *redView;

/** */
@property (strong, nonatomic) CommunityNewsModel *model;


@end
