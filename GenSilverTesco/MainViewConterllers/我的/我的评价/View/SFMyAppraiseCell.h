//
//  SFMyAppraiseCell.h
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFMyAppraiseModel.h"
#import "TggStarEvaluationView.h"

@interface SFMyAppraiseCell : UITableViewCell

@property (nonatomic,strong) SFMyAppraiseModel *model ;

//时间
@property (nonatomic,strong) UILabel *timeLab ;
//标题
@property (nonatomic,strong) UILabel *titleLab ;
//内容
@property (nonatomic,strong) UILabel *contentLab;
//商品图片
@property (nonatomic,strong) UIImageView *imgView ;
//商品描述
@property (nonatomic,strong) UILabel *describe ;
//商品名称
@property (nonatomic,strong) UILabel *shopName ;
//商品价格
@property (nonatomic,strong) UILabel *price ;


//背景View
@property (nonatomic,strong) UIView *backView ;

//星星评价
@property (nonatomic,strong) TggStarEvaluationView *starView ;

@end
