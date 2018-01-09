//
//  PaymentListView.h
//  GenSilverTesco
//
//  Created by MrSong on 17/9/9.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseXIBView.h"
#import "IWantMenuView.h"
#import "WPswView.h"

@interface PaymentListView : KSBaseXIBView <UITextFieldDelegate>
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
@property (nonatomic,strong) NSString *store_id ;//商家id
@property (nonatomic,strong) KSBaseViewController *vc ;


//支付弹框
@property (nonatomic,strong) WPswView *pswView;
@property (nonatomic,strong) NSString *pay_password ;
@end
