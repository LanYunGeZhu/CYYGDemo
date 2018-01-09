//
//  ShopIntroducedVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopIntroducedVC : KSBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;
/** */
@property (copy, nonatomic) void(^contextBlock)(NSString *context);


@end
