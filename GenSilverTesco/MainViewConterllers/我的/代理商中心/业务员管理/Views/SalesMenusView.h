//
//  SalesMenusView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    direction_top,
    direction_bottom,
} Direction;

@interface SalesMenusView : KSBaseXIBView
/** 顶部三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topView_layout_leading;
/** 顶部三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topview_layout_top;

/** 低部三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomView_layout_leading;
/** 底部三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomView_layout_top;

/** 居上下三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_topView_layout_traling;
/** 居上下三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_topView_layout_bottom;

/** 居上下三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_bottomView_layout_traling;
/** 居上下三角*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_bottomView_layout_bottom;

/** tableView 大小*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_layout_width;
/** tableView 大小*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_layout_height;

/** */
@property (weak, nonatomic) IBOutlet UITableView *myTableView;

/** */
@property (weak, nonatomic) IBOutlet UIView *topView;
/** */
@property (weak, nonatomic) IBOutlet UIView *bottomView;

/** */
@property (strong, nonatomic) NSArray  *datasArray;

- (void)showViewDirection:(Direction)direction rect:(CGRect)rect;
- (void)registrCell;
@end
