//
//  SearchNavView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchNavView : KSBaseXIBView<UITextFieldDelegate>
/** */
@property (weak, nonatomic) IBOutlet UIView * bgView;
/** 🔍 搜索 button*/
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
/** */
@property (weak, nonatomic) IBOutlet UITextField *serachTextField;

/*是否 响应 */
@property (assign, nonatomic) BOOL isResponse;

/** 定位图片 */
@property (weak, nonatomic) IBOutlet UIImageView *iocAddress;
/** 定位文字 */
@property (weak, nonatomic) IBOutlet UILabel * textAddress;

/** */
@property (copy, nonatomic) void(^serachTextBlock)(NSString *serachText);


/** 距离View*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * view_layou;
/** 距离定位文字*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *text_layou;

//@property(nonatomic, assign) CGSize intrinsicContentSize;

@end
