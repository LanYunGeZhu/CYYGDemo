//
//  KSBaseXIBView.m
//  TwinkleTwinkle
//
//  Created by kangshibiao on 16/9/28.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseXIBView.h"

static NSInteger tag = 134861719791;
@implementation KSBaseXIBView

+ (instancetype)initBaseView{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil]lastObject];
}

- (void)awakeFromNib{
    [super awakeFromNib];
    NSString *version = [UIDevice currentDevice].systemVersion;

    if ([version doubleValue] >=11) {
        self.intrinsicContentSize = self.frame.size;
    }
}

/** 添加一个背景View alpha透明度*/
- (void)baseXIB_showAlpha:(CGFloat)alpha color:(UIColor *)color{
    UIView *bgView= [[ UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_wide, Screen_heigth)];
    
    bgView.backgroundColor = color ?color : [UIColor lightGrayColor];
    bgView.alpha = alpha;
    bgView.tag = tag;
    UIWindow * wiondow = [[UIApplication sharedApplication].delegate window];
    [wiondow addSubview:bgView];
    [wiondow addSubview:self];

    [wiondow makeKeyWindow];
}

/** 移除视图 */
- (void)baseXIB_removeSubView{
    UIWindow * wiondow = [[UIApplication sharedApplication].delegate window];
    UIView *bgView = [wiondow  viewWithTag:tag];
    [bgView removeFromSuperview];
    [self removeFromSuperview];
}


- (IBAction)base_ButtonsClick:(UIButton *)sender{
    if (_base_BlockIdx) {
        _base_BlockIdx(sender.tag);
    }
}

/** 设置圆角*/
- (void)setViewCornerRadiusViews:(NSArray <UIView *>*)view floatCoriner:(float)floatCoriner;
{
    [view enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = floatCoriner;
        obj.layer.masksToBounds = YES;
    }];
}

@end
