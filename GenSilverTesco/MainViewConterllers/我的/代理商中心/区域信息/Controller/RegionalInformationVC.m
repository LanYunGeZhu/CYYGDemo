//
//  RegionalInformationVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalInformationVC.h"
#import "RegionalReleaseVC.h"
#import "RegionalInformationCell.h"
@interface RegionalInformationVC ()

@end

@implementation RegionalInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addMjRefresh];
    [self loadRequsetData];
    [self setRightWithString:@"发布" action:@selector(releaseClick)];
}


- (void)releaseClick{
    [self goRegionalRelease:nil];
}

- (void)goRegionalRelease:(RegionalReleaseModel *)model{
    WeakSelf

    RegionalReleaseVC *regional = [RegionalReleaseVC new];
    regional.model = model;
    regional.upLoadSuccess=  ^{
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    [self.navigationController pushViewController:regional animated:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    
    [KSRequestManager postRequestWithUrlString:URL_agentnewsarea parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray  addObjectsFromArray:[RegionalReleaseModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self endRefresh];
        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"区域信息";
    [self registerTableVieCell:@"RegionalInformationCell"];
    self.base_CellHeight = 100;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RegionalInformationCell *cell = (RegionalInformationCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model =self.datasMutabArray[indexPath.section];
    WeakSelf
    cell.longTap = ^(RegionalInformationCell *cell){
        [weakSelf longTapClick:cell];
    };
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

- (void)longTapClick:(RegionalInformationCell *)cell{
 
    WeakSelf
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    RegionalReleaseModel *model =self.datasMutabArray [indexPath.section];
    if ([model.status integerValue] == 1) {
        [KSTool alertViewWithController:weakSelf title:@"温馨提示" message:@"您确定要删除吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
            if (indx == 1) {
                [weakSelf deleteNewsList:model indexPath:indexPath];
            }
        }];

    }else{
        [KSTool alertViewWithController:weakSelf title:nil message:nil items:@[@"编辑",@"删除",@"取消"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
            if (indx == 0) {
                NSLog(@"编辑");
                [weakSelf goRegionalRelease:model];
            }
            else if (indx == 1) {
                [self deleteNewsList:model indexPath:indexPath];
            }
        }];
    }
    
}

- (void)deleteNewsList:(RegionalReleaseModel *)model indexPath:(NSIndexPath *)indexPath{
    [KSRequestManager postRequestWithUrlString:URL_news_del parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":model.iD} success:^(id responseObject) {
        [self.datasMutabArray removeObjectAtIndex:indexPath.section];
        [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
    } failure:^(id error) {
        
    }];
}





@end
