//
//  LYMyPurseVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/25.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "LYMyPurseVC.h"
#import "LYMyPurseCell.h"
#import "LYMyPurseModel.h"

@interface LYMyPurseVC ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger _page;
@property (nonatomic,strong) NSMutableArray *dataArray ;

@end

@implementation LYMyPurseVC

#pragma mark 懒加载

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad{
    [super viewDidLoad];
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
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"LYMyPurseCell" bundle:nil] forCellReuseIdentifier:@"LYMyPurseCell"];
    
    
    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{
    
    [KSRequestManager postRequestWithUrlString:URL_myPurse parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":[NSString stringWithFormat:@"%ld",(long)__page],@"ptype":_mark} success:^(id responseObject) {
        
        
        NSString *btntittle = [NSString stringWithFormat:@"%@",responseObject[@"tintegral"]] ;
        [_hasCode setTitle:btntittle forState:(UIControlStateNormal)];
        
        if (_hasCode.titleLabel.text.length == 0) {
            [_hasCode setTitle:@"0" forState:(UIControlStateNormal)];
        }
        
        NSMutableArray*listArr = [[NSMutableArray alloc]initWithArray:responseObject[@"lists"]];
        for (NSDictionary *dic in listArr) {
            LYMyPurseModel *model = [[LYMyPurseModel alloc]initWithDictionary:dic];
            
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    LYMyPurseCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"LYMyPurseCell"];
    
    if (!cell) {
        cell = [[LYMyPurseCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"LYMyPurseCell"];
    }
    
    cell.model = self.dataArray[indexPath.row];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Screen_heigth/667*50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8.0;
}

#pragma mark 点击事件
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}
- (IBAction)titleBtn:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"消费赠送");
        _mark = @"0";
        __page = 1;
        [self.dataArray removeAllObjects];
        [self gitRequestData];
    }else{
        NSLog(@"购买积分");
        _mark = @"6";
        __page = 1;
        [self.dataArray removeAllObjects];
        [self gitRequestData];
    }
    
}

#pragma mark 工具方法



@end
