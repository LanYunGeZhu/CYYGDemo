//
//  PayTypeList.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayTypeList : KSBaseTableViewCell
/** */
@property (weak, nonatomic) IBOutlet UILabel *title;
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;
/** */
@property (weak, nonatomic) IBOutlet UIImageView *iocImageView;
/** */
@property (weak, nonatomic) IBOutlet UIButton *seleced_button;

/** */
@property (weak, nonatomic) IBOutlet UILabel *title1;
@end
