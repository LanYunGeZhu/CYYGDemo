//
//  RefundsListHeadeView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefundsListHeadeView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UIButton *statusButton;
/** */
@property (weak, nonatomic) IBOutlet UIButton *contactTheSeller;

/** */
@property (weak, nonatomic) IBOutlet UILabel *nameLable;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;
@end
