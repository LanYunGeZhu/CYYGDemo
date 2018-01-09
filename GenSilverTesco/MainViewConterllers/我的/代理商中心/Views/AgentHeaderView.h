//
//  AgentHeaderView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AgentHeaderView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

/** */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

/** 数量的BgView*/
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *numBgViews;

/** 浏览数*/
@property (weak, nonatomic) IBOutlet UILabel *browseTheNumber;
/**订单金额 */
@property (weak, nonatomic) IBOutlet UILabel *theOrderAmount;

/** */
@property (weak, nonatomic) IBOutlet UILabel *orderNumber;

- (void)hiddenNum;



@end
