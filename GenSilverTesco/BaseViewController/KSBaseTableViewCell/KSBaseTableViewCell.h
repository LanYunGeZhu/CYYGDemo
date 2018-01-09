//
//  KSBaseTableViewCell.h
//  FrameWork
//
//  Created by kangshibiao on 16/8/15.
//  Copyright © 2016年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KSBaseTableViewCell : UITableViewCell

//数据源
@property (strong, nonatomic) id data;

/** */
@property (copy, nonatomic) void(^baseCell_buttonIndex)(NSInteger index);


/** */
@property (strong, nonatomic) NSIndexPath *base_IndexPath;

/** 设置 圆角*/
- (void)setViewCornerRadiusViews:(NSArray <UIView *>*)view floatCoriner:(float)floatCoriner;

/**隐藏控件*/
- (void)viewHidden:(NSArray <UIView *>*)view;
/**显示控件*/
- (void)viewShow:(NSArray <UIView *>*)view;
/** 公共按钮方法 根据tag 区分*/
- (IBAction)baseCell_buttonClikc:(UIButton *)sender;
@end
