//
//  QRCodeResultView.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseXIBView.h"

@interface QRCodeResultView : KSBaseXIBView<UITextFieldDelegate>

/** */
@property (weak, nonatomic) IBOutlet UIView *bgView;

/** 商家名称*/
@property (weak, nonatomic) IBOutlet UILabel *storeName;
@property (nonatomic,strong) NSString *name ;
/** 商品名称*/
@property (weak, nonatomic) IBOutlet UITextField *goodsNameField;
@property (nonatomic,strong) NSString *goodsname ;
/** 应付积分*/
@property (weak, nonatomic) IBOutlet UILabel *integral;
/** 消费金额*/
@property (weak, nonatomic) IBOutlet UITextField *priceField;
/** 积分让利比例*/
@property (weak, nonatomic) IBOutlet UILabel *bili1;
/** 现金让利比例*/
@property (weak, nonatomic) IBOutlet UILabel *bili2;
/** */

/** 开始付款*/
@property (weak, nonatomic) IBOutlet UIButton *startGathering;

@end
