//
//  MerchantsCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WInfomationModel.h"
@interface MerchantsCell : KSBaseTableViewCell
/** */
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray <UILabel *> *labelArray;
/** */
@property (strong, nonatomic) WInfomationModel *model;



@end
