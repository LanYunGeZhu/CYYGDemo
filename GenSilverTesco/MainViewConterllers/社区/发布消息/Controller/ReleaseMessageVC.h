//
//  ReleaseMessageVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSImageView.h"
@interface ReleaseMessageVC : KSBaseViewController

/** */
/** */
@property (weak, nonatomic) IBOutlet KSImageView *imagesView;
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;

/** */
@property (copy, nonatomic) void (^addBBSSuccess)();



@end
