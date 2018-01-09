//
//  SalesManagementVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SalesManagementVC.h"
#import "SalesManagementCell.h"
#import "AddTheSalesmanVC.h"
#import "SalesMenusView.h"
#import "AddTheBusinessmanVC.h"
#import "RegionalPerformanceVC.h"
#import "SalesManagementModel.h"
@interface SalesManagementVC ()

@end

@implementation SalesManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    [self setRightWithString:@"添加" action:@selector(addClick)];
}

- (void)addClick{
    
    AddTheSalesmanVC * addSales = [AddTheSalesmanVC new];
    [self.navigationController pushViewController:addSales animated:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_agentsalers parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[SalesManagementModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    
//    self.base_table_deleteEdit = YES;
    [self registerTableVieCell:@"SalesManagementCell"];
    self.base_CellHeight = 144;
    self.title = @"业务员管理";
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SalesManagementCell *cell = (SalesManagementCell *)[super tableView:tableView cellForRowAtIndexPath:  indexPath];
    [cell.moreAndMore addTarget:self action:@selector(moreAndMoreClick:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = self.datasMutabArray[indexPath.section];
    return  cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SalesManagementModel *model = self.datasMutabArray[indexPath.section];
    RegionalPerformanceVC *regisonal = [RegionalPerformanceVC new];
    regisonal.salesId =model.iD;
    [self.navigationController pushViewController:regisonal animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle  ==  UITableViewCellEditingStyleDelete) {
        // 删除；
           }
}

- (void)moreAndMoreClick:(UIButton *)sender{
    
    SalesManagementCell *cell = (SalesManagementCell *)sender.superview.superview.superview;
    CGRect rect = [cell.moreBgView convertRect:sender.frame toView:self.view];
    NSIndexPath * indexPath = [self.myTableView indexPathForCell:cell];
    SalesMenusView * menusView = [SalesMenusView initBaseView];
    menusView.datasArray = @[@"添加商家",@"编辑信息",@"取消业务员身份"];
    WeakSelf
    menusView.base_BlockIdx = ^(NSInteger index){
        [weakSelf menuClick:index indexPath:indexPath];
    };
    NSInteger isFlig = 0;
    if ((Screen_heigth - rect.origin.y - 132 - 64) <= 40) {
        isFlig = direction_bottom;
    }else{
        isFlig = direction_top;
    }
    [menusView showViewDirection:isFlig rect:rect];
    [menusView registrCell];
  
  
}

- (void)menuClick:(NSInteger)index indexPath:(NSIndexPath *)indexPath{
    if (index == 0) {
        AddTheBusinessmanVC *business = [AddTheBusinessmanVC new];
        business.model=  self.datasMutabArray[indexPath.section];
        [self.navigationController pushViewController:business animated:YES];
    }else if (index ==1){
        WeakSelf
        AddTheSalesmanVC * addSales = [AddTheSalesmanVC new];
        addSales.model=  self.datasMutabArray[indexPath.section];
        addSales.updateSuccess = ^{
            [weakSelf base_RefreshHeaderFooter:YES];
        };
        [self.navigationController pushViewController:addSales animated:YES];
    }else{
   
        [KSTool alertViewWithController:self title:@"温馨提示" message:@"您确定要取消业务员身份吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
            if (indx ==1) {
                SalesManagementModel * model = self.datasMutabArray[indexPath.section];
                [MBProgressHUD showActivityMessageInWindow:@"正在取消..."];
                [KSRequestManager postRequestWithUrlString:URL_salerdel parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":model.iD} success:^(id responseObject) {
                    [MBProgressHUD hideHUD];
                    [self.datasMutabArray removeObjectAtIndex:indexPath.section];
                    [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationRight];
                } failure:^(id error) {
                    
                }];
                

            }
        }];
       
    }
}


@end
