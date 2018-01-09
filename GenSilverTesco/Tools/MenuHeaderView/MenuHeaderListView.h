//
//  MenuHeaderListView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/2.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    tableView_Num1,
    tableView_Num2,
} TableView_Num;

@interface MenuHeaderListView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_tab_width;
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *left_tab_height;

/** */
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

/** */
@property (strong, nonatomic) NSArray *leftDatasArray;
/** */
@property (strong, nonatomic) NSArray *rightDatasArray;


/**<#name#>*/
@property (assign, nonatomic) NSInteger indexPath_row;

@property (assign, nonatomic) TableView_Num tableNum;

/** 两个TableView 回调*/
@property (copy, nonatomic) void(^table_index)(NSInteger leftIndex,NSInteger rightindex);


@end
