//
//  KSBaseRefreshViewController.h
//  BigWinner
//
//  Created by kangshibiao on 2017/3/15.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ErrorView.h"
#import "PageView.h"
@interface KSBaseRefreshViewController : KSBaseViewController
/** */
@property (weak, nonatomic,nullable) IBOutlet UITableView *myTableView;
/** 页数*/
@property (assign, nonatomic) NSInteger page;
/** 条数 默认 15*/
@property (assign, nonatomic) NSInteger size;

/**cell高度*/
@property (assign, nonatomic) CGFloat base_CellHeight;

/** 是否可以删除*/
@property (assign, nonatomic) BOOL base_table_deleteEdit;

/** 站位View*/
@property (strong, nonatomic,nullable) ErrorView *errorView;

/** */
@property (strong, nonatomic,nullable) PageView *pageView;


/** 配置Cell*/
- (void)initTableView;

/** 在TableView上添加一个 没有View  imageName 图片名字*/
- (void)addNoDataViewImageName:(nullable NSString * )imageName;

/** 添加区头 轮播图*/
-(void)addHeaderViewPageView:(CGRect)frame;

/** 添加刷新*/
- (void)addMjRefresh;

/** 下拉刷新 isHeader  加载更多 !isHeader*/
- (void)base_RefreshHeaderFooter:(BOOL)isHeader NS_REQUIRES_SUPER;

/** 结束刷新*/
- (void)endRefresh;

- (void)registerTableVieCell:(nullable NSString *)cell;

//- (void)registerCell:(nullable UITableView *)tableView TableVieCell:(nullable NSString *)cell;
- (NSInteger)tableView:(nullable UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
/** 默认Cell*/
- (nullable UITableViewCell *)tableView:(nullable UITableView *)tableView cellForRowAtIndexPath:(nullable NSIndexPath *)indexPath;

/** 刷新某个区*/
- (void)reloadSection:(NSInteger)section;

/** 刷新某个cell不带动画*/
- (void)reloadRow:(NSInteger)row section:(NSInteger)section;

/** 刷新Cell带动画*/
- (void)reloadRow:(NSInteger)row section:(NSInteger)section animation:(UITableViewRowAnimation)animation;

/** 注册多个cell*/
- (void)registerTableVieCellsArray:(nullable NSArray <NSString *>*)cell;

/** */
@property (nullable, copy, nonatomic) NSString *cellId;

@end
