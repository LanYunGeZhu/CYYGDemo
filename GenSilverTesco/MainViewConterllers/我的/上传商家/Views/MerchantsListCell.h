//
//  MerchantsListCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MerchantsListCell : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** */
@property (weak, nonatomic) IBOutlet UITextField *contextField;
/** */
@property (weak, nonatomic) IBOutlet UILabel *statr;
@end
