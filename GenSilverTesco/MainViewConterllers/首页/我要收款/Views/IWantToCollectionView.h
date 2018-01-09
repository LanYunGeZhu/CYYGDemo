//
//  IWantToCollectionView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IWantMenuView.h"
@interface IWantToCollectionView : KSBaseXIBView <UITextFieldDelegate>
/** */
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** 店铺名称*/
@property (weak, nonatomic) IBOutlet UITextField *storeName;
/** 商品名称*/
@property (weak, nonatomic) IBOutlet UITextField *goodsNameField;
/** 积分*/
@property (weak, nonatomic) IBOutlet UILabel *integral;
/** 金额*/
@property (weak, nonatomic) IBOutlet UITextField *priceField;
/** 让利比例*/
@property (weak, nonatomic) IBOutlet UILabel *benefit;
/** */
@property (strong, nonatomic) IWantMenuView *menuView;

/** 开始付款*/
@property (weak, nonatomic) IBOutlet UIButton *startGathering;

/** 付款吗 背景View*/
@property (weak, nonatomic) IBOutlet UIView *bgCodeView;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *codeImageView;


@property (nonatomic,strong) NSMutableArray *listArr ;//店铺数组
@property (nonatomic,strong) NSString *shoper_id ;//店铺id
@end
