//
//  CommunityListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductEvaluationListCell.h"
#import "CommunityModel.h"
@interface CommunityListCell : ProductEvaluationListCell
/** 点赞*/
@property (weak, nonatomic) IBOutlet UIButton *praise;
/** 评论*/
@property (weak, nonatomic) IBOutlet UILabel *comments;


/** */
@property (strong, nonatomic) CommunityModel *communityModel;

/** */
@property (weak, nonatomic) IBOutlet UIButton *comments_buutton;

@end
