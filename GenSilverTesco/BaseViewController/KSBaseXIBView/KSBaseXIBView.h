//
//  KSBaseXIBView.h
//  TwinkleTwinkle
//
//  Created by kangshibiao on 16/9/28.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSBaseXIBView : UIView

//- (instancetype) init NS_UNAVAILABLE;

+ (instancetype)initBaseView ;

/** */
@property (strong, nonatomic) id data;

/** 一个butoon */
@property (weak, nonatomic) IBOutlet UIButton *base_button;

/** 添加一个背景View alpha透明度 color == nil lightGrayColor*/
- (void)baseXIB_showAlpha:(CGFloat)alpha color:(UIColor *)color;

/** 移除视图 */
- (void)baseXIB_removeSubView;

/** 公共button绑定方法 根据Tag 区分*/
- (IBAction)base_ButtonsClick:(UIButton *)sender;


/** button Blick 回调
 *  @prarm idx tag 值
 */
@property (copy, nonatomic) void (^base_BlockIdx)(NSInteger idx);

/** 设置 圆角*/
- (void)setViewCornerRadiusViews:(NSArray <UIView *>*)view floatCoriner:(float)floatCoriner;

/**<#name#>*/
@property (assign, nonatomic) CGSize intrinsicContentSize;


@end
