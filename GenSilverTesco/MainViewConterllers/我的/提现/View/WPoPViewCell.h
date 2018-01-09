//
//  WPoPViewCell.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WPoPaction.h"

UIKIT_EXTERN float const PopoverViewCellHorizontalMargin; ///< 水平间距边距
UIKIT_EXTERN float const PopoverViewCellVerticalMargin; ///< 垂直边距
UIKIT_EXTERN float const PopoverViewCellTitleLeftEdge; ///< 标题左边边距

@interface WPoPViewCell : UITableViewCell

@property (nonatomic, assign) PopoverViewStyle style;

/*! @brief 标题字体
 */
+ (UIFont *)titleFont;

/*! @brief 底部线条颜色
 */
+ (UIColor *)bottomLineColorForStyle:(PopoverViewStyle)style;

- (void)setAction:(WPoPaction *)action;

- (void)showBottomLine:(BOOL)show;@end
