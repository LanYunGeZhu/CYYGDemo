//
//  MyPerformanceCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/31.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyPerformanceModel.h"
#import "RegionalPerformanceCell.h"
@interface MyPerformanceCell : RegionalPerformanceCell

/** */
@property (strong, nonatomic) MyPerformanceModel *my_model;
/** */
@property (weak, nonatomic) IBOutlet UIButton *arerButton;

@end
