//
//  IntegralManagementVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "IntegralManagementVC.h"
#import "IntegralManagementCell.h"
#import "PointsForDetailsVC.h"
#import "PartWillOrderModel.h"
@interface IntegralManagementVC ()

@end

@implementation IntegralManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    //    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_shopersjorders parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size),@"paytype":@"2"} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[PartWillOrderModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}
- (void)initTableView{
    self.title = @"积分换购管理";
    [self registerTableVieCell:@"IntegralManagementCell"];
    self.base_CellHeight = 90;
}

#pragma mark -- UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    IntegralManagementCell *cell = (IntegralManagementCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model =self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WeakSelf
    PointsForDetailsVC *posints = [PointsForDetailsVC new];
    posints.upDataSuccess =  ^{
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    posints.model =self.datasMutabArray[indexPath.section];
    [self.navigationController pushViewController:posints animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


@end
