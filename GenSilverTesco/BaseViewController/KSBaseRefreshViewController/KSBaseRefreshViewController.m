//
//  KSBaseRefreshViewController.m
//  BigWinner
//
//  Created by kangshibiao on 2017/3/15.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseRefreshViewController.h"
#import "KSBaseTableViewCell.h"
@interface KSBaseRefreshViewController ()

@end

@implementation KSBaseRefreshViewController

- (ErrorView *)errorView{
    if (_errorView == nil) {
        _errorView = [ErrorView initBaseView];
    }
    return _errorView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableView];
    
 
}

- (void)initTableView{
    if (_base_table_deleteEdit) {
        [[NSNotificationCenter defaultCenter] postNotificationName:interactivePopGesture object:nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:shoppingCartHidden object:nil];
    }
}

- (void)addNoDataViewImageName:(NSString *)imageName
{
    if (self.datasMutabArray.count == 0) {
        [self.errorView.menus_button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        self.errorView.frame = self.myTableView.frame;
        if (![self.myTableView.subviews containsObject:self.errorView
             ])
        {
            [self.myTableView addSubview:self.errorView];
        }
    }else{
        if ([self.myTableView.subviews containsObject:self.errorView]) {
            [self.errorView removeFromSuperview];
        }
    }
}

-(void)addHeaderViewPageView:(CGRect)frame{
    self.pageView = [[PageView alloc]initPageViewFrame:frame];
//    self.pageView.isWebImage = NO;
//    self.pageView.imageArray = @[@"shangpinxiangqing",@"shangpinxiangqing",@"shangpinxiangqing"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.myTableView.tableHeaderView = _pageView;
        
    });
}

- (void)addMjRefresh{
    self.page = 1;
    self.size = 20;
    WeakSelf
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf base_RefreshHeaderFooter:YES];
    }];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [weakSelf base_RefreshHeaderFooter:NO];
    }];
}



- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    if (isHeader) {
        [self.datasMutabArray removeAllObjects];
        self.page = 1;
    }else{
          self.page ++;
    }
    
}

- (void)registerTableVieCell:(NSString *)cell{
    
    [self registerTableVieCellsArray:@[cell]];
    self.cellId = cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _base_CellHeight;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasMutabArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    KSBaseTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellId forIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return _base_table_deleteEdit;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}

/** 刷新某个区 */
- (void)reloadSection:(NSInteger)section{
    [self.myTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
}

/* 刷新单个cell*/
- (void)reloadRow:(NSInteger)row section:(NSInteger)section{
    [self.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationNone];
}

/** 刷新Cell带动画*/
- (void)reloadRow:(NSInteger)row section:(NSInteger)section animation:(UITableViewRowAnimation)animation{
    [self.myTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:animation];
}

/** 注册多个cell*/
- (void)registerTableVieCellsArray:(NSArray <NSString *>*)cell{
    [cell enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.myTableView registerNib:[UINib nibWithNibName:obj bundle:nil] forCellReuseIdentifier:obj];
    }];
}

- (void)endRefresh{
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
}

-  (void)dealloc{

}



@end
