//
//  SFMyAppraiseVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFMyAppraiseVC.h"
#import "SFMyAppraiseModel.h"
#import "SFMyAppraiseCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "GoodsDetailsVC.h"

@interface SFMyAppraiseVC ()<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) NSInteger _page;
@property (nonatomic,strong) NSMutableArray *dataArray ;

@end

@implementation SFMyAppraiseVC

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
    self.title = @"我的评价";
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
    
    [self.myTableView registerClass:[SFMyAppraiseCell class] forCellReuseIdentifier:@"SFMyAppraiseCell"];
    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{
    
    [KSRequestManager postRequestWithUrlString:URL_myComment parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":[NSString stringWithFormat:@"%ld",(long)__page]} success:^(id responseObject) {
        
        if (__page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        NSMutableArray*listArr = [[NSMutableArray alloc]initWithArray:responseObject[@"lists"]];
        for (NSDictionary *dic in listArr) {
            SFMyAppraiseModel *model = [[SFMyAppraiseModel alloc]initWithDictionary:dic];
            
            [self.dataArray addObject:model];
        }
        
        [self.myTableView reloadData];
        [self endRefresh];
        
    } failure:^(id error) {
        [self endRefresh];
    }];
    

}
- (void)endRefresh{
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
}

/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    __page = 1;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{

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
    
    SFMyAppraiseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SFMyAppraiseCell"];
    
    
    cell.model = self.dataArray[indexPath.section];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SFMyAppraiseModel * model=  self.dataArray[indexPath.section];
    
    float flo = [self.myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SFMyAppraiseCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
    return flo;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsDetailsVC *goods =[GoodsDetailsVC new];
    SFMyAppraiseModel *model = self.dataArray[indexPath.section];
    goods.goods_id = model.goods_id;
    [self.navigationController pushViewController:goods animated:YES];
    
}
#pragma mark 点击事件


#pragma mark 工具方法



@end
