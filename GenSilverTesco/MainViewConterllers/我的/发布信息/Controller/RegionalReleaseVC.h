//
//  RegionalReleaseVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegionalReleaseModel.h"
@interface RegionalReleaseVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;

/** */
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;
/** */
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

/** */
@property (weak, nonatomic) IBOutlet UIButton *imagesButton;

/** */
@property (copy, nonatomic) void(^upLoadSuccess)();

/** */
@property (strong, nonatomic) RegionalReleaseModel *model;



@end
