//
//  ComplainMenusView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComplainMenusView : KSBaseXIBView

/** */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray <UIButton *>*senders;



/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_view_L;

@end
