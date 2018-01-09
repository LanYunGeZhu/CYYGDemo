//
//  MainLoginVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainLoginVC : KSBaseViewController

/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layou_imageView_leading;
/** */
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray<UIButton*> *menusButton;

/** */
@property (weak, nonatomic) IBOutlet UIScrollView *myScrollView;


@end
