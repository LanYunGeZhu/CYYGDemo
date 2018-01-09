//
//  StoreImageViewCell.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSImageView.h"
@interface StoreImageViewCell : KSBaseTableViewCell

/** */
@property (weak, nonatomic)IBOutlet KSImageView *imageViews;

/** 协议*/
@property (weak, nonatomic) IBOutlet UIButton *agreement;
/** */
@property (weak, nonatomic) IBOutlet UIButton *isSelectAgreement;
@end
