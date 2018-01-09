//
//  WShareView.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WShareView : KSBaseXIBView

@property (nonatomic,weak)IBOutlet UIImageView *IconImage;

@property (nonatomic,weak)IBOutlet UIView *TopView;

@property (nonatomic,weak)IBOutletCollection(UIButton) NSArray*BtnS;

@property (nonatomic,weak)IBOutlet UIView *TView;
@property (nonatomic,copy)NSString *headUrl;
@property (nonatomic,assign)UIViewController *delegate;

@end
