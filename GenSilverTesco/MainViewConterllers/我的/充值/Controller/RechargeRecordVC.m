//
//  RechargeRecordVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RechargeRecordVC.h"
#import "WRecordCell.h"
#import <MJRefresh.h>
#import "WRecordModel.h"
static NSString *kCellID = @"cellID";


@interface RechargeRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
}

@end

@implementation RechargeRecordVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self initData];
    
    [self WaddRefresh];

}

- (void)initData
{
    [self.RecoredTab registerNib:[UINib nibWithNibName:@"WRecordCell" bundle:nil] forCellReuseIdentifier:kCellID];
    
    
    self.title = @"充值记录";
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    if (self.datasMutabArray.count > 0) {
        WRecordModel *model = self.datasMutabArray[indexPath.row];
        cell.typeLa.text = model.payment;
        cell.timeLa.text = model.add_time;
        cell.moneyLa.text = model.amount;
    }
    
    
    return cell;
}

- (void)WaddRefresh
{
    self.RecoredTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.datasMutabArray removeAllObjects];
        [self.myTableView reloadData];
        page = 1;
        [self WLoadRequest:page];
    }];
    
    self.RecoredTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self WLoadRequest:page];
    }];
    [self WLoadRequest:page];

}


////////////////////
- (void)WLoadRequest:(NSInteger)index
{
    
    [KSRequestManager postRequestWithUrlString:URL_appcharge parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":[NSString stringWithFormat:@"%ld",index],@"process_type":@"0",@"size":@"20"} success:^(id responseObject) {
        
        [self.datasMutabArray addObjectsFromArray:[WRecordModel whc_ModelWithJson:responseObject keyPath:@"lists"]];

        [self.RecoredTab reloadData];
        
        if (self.datasMutabArray.count == 0)
        {
            [MBProgressHUD showErrorMessage:noMoreData];
        }
        [self endRefresh];
        
    } failure:^(id error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)endRefresh{
    [self.RecoredTab.mj_header endRefreshing];
    [self.RecoredTab.mj_footer endRefreshing];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
