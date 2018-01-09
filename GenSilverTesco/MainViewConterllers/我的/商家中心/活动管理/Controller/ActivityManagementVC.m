//
//  ActivityManagementVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ActivityManagementVC.h"
#import "ActivityManagementCell.h"
#import "ReleaseNewActivitiesVC.h"
#import "EventDetailsVC.h"
#import "ActivityManagementModel.h"

@interface ActivityManagementVC ()

@end

@implementation ActivityManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    [self setRightWithString:@"发布" action:@selector(releaseNewActivities)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upDataList) name:@"ActivityManagementVC" object:nil];
}

- (void)upDataList{
    [self base_RefreshHeaderFooter:YES];
}


- (void)releaseNewActivities{
    
    ReleaseNewActivitiesVC *activitiesVC = [[UIStoryboard storyboardWithName:@"ReleaseNewActivitiesVC" bundle:nil] instantiateViewControllerWithIdentifier:@"ReleaseNewActivitiesVC"];
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    
    [KSRequestManager postRequestWithUrlString:URL_shoper_activity parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[ActivityManagementModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"活动管理";
    [self registerTableVieCell:@"ActivityManagementCell"];
    self.base_CellHeight = 100;
    self.base_table_deleteEdit = YES;
    [super initTableView];

}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ActivityManagementCell *cell = (ActivityManagementCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 
    EventDetailsVC *eventVC = [EventDetailsVC new];
    eventVC.model = self.datasMutabArray[indexPath.section];
    [self.navigationController pushViewController:eventVC animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [KSTool alertViewWithController:self title:@"温馨提示" message:@"您确定要删除吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
            if (indx == 1) {
                ActivityManagementModel *model =self.datasMutabArray[indexPath.section];
                [KSRequestManager postRequestWithUrlString:URL_activity_del parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":model.iD} success:^(id responseObject) {
                    [self.datasMutabArray removeObjectAtIndex:indexPath.section];
                    [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
                } failure:^(id error) {
                    
                }];
            }
        }];
    
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"ActivityManagementVC" object:nil];
}



@end
