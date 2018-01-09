//
//  MyOrderCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyOrderCell : KSBaseTableViewCell

/** 背景*/
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray <UIView *> *numBgView;

/**  数量*/
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray <UILabel *> *numLabel;



@end
