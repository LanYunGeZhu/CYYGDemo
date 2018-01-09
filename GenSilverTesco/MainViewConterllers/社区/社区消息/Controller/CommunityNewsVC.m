//
//  CommunityNewsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "CommunityNewsVC.h"
#import "CommunityNewsListCell.h"
#import "AReplyMessage.h"
#import "CommunityNewsModel.h"
@interface CommunityNewsVC ()

@end

@implementation CommunityNewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightWithString:@"清空" action:@selector(empty)];
    [self addMjRefresh];
    [self loadRequsetData];
}

#pragma mark -- 清空
- (void)empty{
    NSLog(@"---empty");
    [KSRequestManager postRequestWithUrlString:URL_bbs_clear_new_msg parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
//        [self base_RefreshHeaderFooter:YES];
        [self.datasMutabArray removeAllObjects];
        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    if (isHeader == NO) {
        [self endRefresh];
        return;
    }
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    
    [KSRequestManager postRequestWithUrlString:URL_bbs_new_msg_lists parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[CommunityNewsModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self  endRefresh];
        [self.myTableView reloadData];
    } failure:^(id error) {
        [self endRefresh];
    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"CommunityNewsListCell"];
    self.base_CellHeight  = 60;
    self.title  = @"社区消息";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunityNewsListCell *cell = (CommunityNewsListCell *) [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AReplyMessage *arep = [AReplyMessage new];
    arep.model = self.datasMutabArray[indexPath.row];
    [self.navigationController pushViewController:arep animated:YES];
}


@end
