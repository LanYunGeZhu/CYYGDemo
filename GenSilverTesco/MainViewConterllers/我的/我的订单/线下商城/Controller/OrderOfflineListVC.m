//
//  OrderOfflineListVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OrderOfflineListVC.h"
#import "OfflineListCell.h"
#import "OrderOfflineModel.h"
#import "OrderOfflineInfoVC.h"
@interface OrderOfflineListVC ()

@end

@implementation OrderOfflineListVC

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
    [KSRequestManager postRequestWithUrlString:URL_sjorders parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"paytype":@(self.index -1),@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[OrderOfflineModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"OfflineListCell"];
    self.base_CellHeight = 151;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OfflineListCell *cell = (OfflineListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderOfflineModel *model = self.datasMutabArray[indexPath.section];
    OrderOfflineInfoVC *infoVC = [OrderOfflineInfoVC new];
    infoVC.goBackBlock = ^{
        
    };
    infoVC.order_Id = model.iD;
    [[KSTabBarController gitNavigationController] pushViewController:infoVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .001;
}


@end
