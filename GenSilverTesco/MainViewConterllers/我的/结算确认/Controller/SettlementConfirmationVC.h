//
//  SettlementConfirmationVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShoppingCartModel.h"
@interface SettlementConfirmationVC : KSBaseRefreshViewController

/**  总价*/
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
/** 运费*/
@property (weak, nonatomic) IBOutlet UILabel *theFreight;
/** 选中的数量*/
@property (weak, nonatomic) IBOutlet UIButton *isSelectButton;
/** */
//@property (strong, nonatomic) NSArray *datasArray;

/** 有更改数量 更新下*/
@property (copy, nonatomic) void(^upDataNum)();


/** */
@property (strong, nonatomic) NSString *price;




@end
