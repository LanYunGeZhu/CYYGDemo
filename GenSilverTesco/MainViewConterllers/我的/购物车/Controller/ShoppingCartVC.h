//
//  ShoppingCartVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartVC : KSBaseRefreshViewController
/**  总价*/
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
/** 运费*/
@property (weak, nonatomic) IBOutlet UILabel *theFreight;
/** 选中的数量*/
@property (weak, nonatomic) IBOutlet UIButton *isSelectButton;
@end
