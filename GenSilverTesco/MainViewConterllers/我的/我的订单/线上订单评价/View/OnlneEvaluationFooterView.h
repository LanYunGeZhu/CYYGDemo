//
//  OnlneEvaluationFooterView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/8.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderOnlineModel.h"
@interface OnlneEvaluationFooterView : KSBaseXIBView
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;

/** 剩余字数*/
@property (weak, nonatomic) IBOutlet UILabel *theRemainingWords;

/** */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton *> *mensuButton;

/** */
@property (weak, nonatomic) IBOutlet UIButton *commitCilick;
/**<#name#>*/
@property (assign, nonatomic) NSInteger index;

/** */
@property (strong, nonatomic) OrderOnlineGoods *model;


@end
