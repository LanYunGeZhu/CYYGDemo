//
//  ShoppingCartCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
@interface ShoppingCartCell : KSBaseTableViewCell
/** 数量*/
@property (weak, nonatomic) IBOutlet UITextField *textField;
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_icoIamge_leading;
/** 加加*/
@property (weak, nonatomic) IBOutlet UIButton *addNum;
/** 减减*/
@property (weak, nonatomic) IBOutlet UIButton *deleteNum;
/**  图片*/
@property (weak, nonatomic) IBOutlet UIImageView *icoImageView;
/** 是否选中*/
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *name;
/** 属性 */
@property (weak, nonatomic) IBOutlet UILabel *attribute;
/** */
@property (weak, nonatomic) IBOutlet UILabel *price;
/** */
@property (strong, nonatomic) ShoppingCartModel *model;





@end
