//
//  TenantsReviewCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TenantsReviewModel.h"
@interface TenantsReviewCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_view_l_1;
@property (assign, nonatomic)  BOOL isFlog;
/** 是否选中 */
@property (weak, nonatomic) IBOutlet UIButton *selectButton;

/** */
@property (strong, nonatomic) TenantsReviewModel *model;

/** */
@property (weak, nonatomic) IBOutlet UILabel *shop_name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *linkman;
/** */
@property (weak, nonatomic) IBOutlet UILabel *mobile;
/** */
@property (weak, nonatomic) IBOutlet UILabel *parent_user;
/** */
@property (weak, nonatomic) IBOutlet UILabel *address;
/** */
@property (weak, nonatomic) IBOutlet UILabel *status;

@end
