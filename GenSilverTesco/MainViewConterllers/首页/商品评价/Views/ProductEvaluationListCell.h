//
//  ProductEvaluationListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductEvaluationModel.h"
@interface ProductEvaluationListCell : KSBaseTableViewCell
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nickName;
/**  时间*/
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;

/** */
@property (weak, nonatomic) IBOutlet UIButton *imageView_button1;
/** */
@property (weak, nonatomic) IBOutlet UIButton *imageView_button2;
/** */
@property (weak, nonatomic) IBOutlet UIView *iamgeView_bgVIew;

/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_text_bottom;


/** */
@property (strong, nonatomic) ProductEvaluationModel *model;


@end
