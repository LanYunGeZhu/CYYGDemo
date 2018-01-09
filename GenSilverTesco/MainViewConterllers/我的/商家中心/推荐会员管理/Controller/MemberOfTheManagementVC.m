//
//  MemberOfTheManagementVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MemberOfTheManagementVC.h"
#import "MemberOfTheManagementCell.h"
#import "MemberOfTheManagementModel.h"
@interface MemberOfTheManagementVC ()

@end

@implementation MemberOfTheManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMjRefresh];
    [self loadRequsetData];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_shoper_subs parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"-%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[MemberOfTheManagementModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView  reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"推荐会员管理";
    [self registerTableVieCell:@"MemberOfTheManagementCell"];
    self.base_CellHeight = 100.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

#pragma mark -- UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MemberOfTheManagementCell *cell = (MemberOfTheManagementCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


@end
