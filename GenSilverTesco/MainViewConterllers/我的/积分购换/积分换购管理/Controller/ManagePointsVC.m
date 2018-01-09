//
//  ManagePointsVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ManagePointsVC.h"
#import "ManagePointsCell.h"
#import "ManagePointsModel.h"

@interface ManagePointsVC ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger _page;
@property (nonatomic,strong) NSMutableArray *dataArray ;

@end

@implementation ManagePointsVC

#pragma mark 懒加载

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"积分换购管理";
    [self selfInitUI];
    [self AFManagerDragon_requestData];
}

#pragma mark 加载UI
/*! 布局UI */
- (void)selfInitUI{
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"ManagePointsCell" bundle:nil] forCellReuseIdentifier:@"ManagePointsCell"];
    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{
    NSArray *listArr= @[@ {
        @"name":@"1825719098",
        @"status":@"未审核",
        @"price":@"88",
        @"profits":@"88",
        @"time":@"2017-06-21",

    }];
    
    for (NSDictionary *dic in listArr) {
        ManagePointsModel *model = [[ManagePointsModel alloc]initWithDictionary:dic];
        
        [self.dataArray addObject:model];
    }
    
    [self.myTableView reloadData];
    [self endRefresh];
}
- (void)endRefresh{
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
}

/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    __page = 1;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArray removeAllObjects];
        [self.myTableView reloadData];
        __page = 1;
        [self gitRequestData];
    }];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        __page ++;
        [self gitRequestData];
    }];
    [self gitRequestData];
}

#pragma mark 代理方法回调

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ManagePointsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManagePointsCell"];
    
    
    cell.model = self.dataArray[indexPath.section];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Screen_heigth/667*134;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
#pragma mark 点击事件


#pragma mark 工具方法




@end
