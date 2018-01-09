//
//  BusinessActivityManagementVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "BusinessActivityManagementVC.h"
#import "BusinessActivityManagementCell.h"
#import "BusinessActivityManagementModel.h"
@interface BusinessActivityManagementVC ()
@property (assign, nonatomic) NSInteger order_sataus;
@property (assign, nonatomic) BOOL isFlog;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_bottom_height;

@end

@implementation BusinessActivityManagementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
       self.order_sataus = -1;
    [self addMjRefresh];
    [self loadRequsetData];
    
    [self setRightWithString:@"管理" action:@selector(managerClick)];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_agentActivity parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size),@"status":@(self.order_sataus)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[BusinessActivityManagementModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)managerClick{
    self.order_sataus = 0;
    self.isFlog = YES;
    [self setRightWithString:@"全选" action:@selector(futureGenerations)];
    [self setLeftWithString:@"取消" action:@selector(canlClick)];
    self.table_bottom_height.constant = 40;
    [self base_RefreshHeaderFooter:YES];
}

- (void)canlClick{
    self.order_sataus = -1;
    self.isFlog = NO;
    [self setLeftDefultWithNav];
    [self setRightWithString:@"管理" action:@selector(managerClick)];
    self.table_bottom_height.constant = 0;
    [self base_RefreshHeaderFooter:YES];
}

- (void)futureGenerations{
    [self.datasMutabArray enumerateObjectsUsingBlock:^(BusinessActivityManagementModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isSelected = 1;
    }];
    [self.myTableView reloadData];
}

- (IBAction)bottomMenus:(UIButton *)sender{
    
    if ([[self isSelectedOrderId] isEqualToString:@""]) {
        
        [MBProgressHUD showTipMessageInWindow:@"至少选择一个"];
        return;
    }
    
    
    [KSTool alertViewWithController:self title:@"温馨提示" message:sender.tag == 1 ?@"确定批量审核通过？":@"确定批量驳回？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
        if (indx ==1) {
            [MBProgressHUD showActivityMessageInWindow:isSubmitted];
            NSDictionary *dic = @{@"ids":[self isSelectedOrderId],@"user_id":[UserInfoManager sharedManager].user_id,@"status":@(sender.tag +1)};
            [KSRequestManager postRequestWithUrlString:URL_activity_audit parameter:dic success:^(id responseObject) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showTipMessageInWindow:submittedSuccessfully];
                [self base_RefreshHeaderFooter:YES];
            } failure:^(id error) {
                
            }];
        }
    }];
}

- (NSString *)isSelectedOrderId{
    __block NSString * ids = @"" ;
    [self.datasMutabArray enumerateObjectsUsingBlock:^(BusinessActivityManagementModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isSelected == 1 && [obj.status integerValue] == 0) {
            if (![ids isEqualToString:@""]) {
                ids = [NSString stringWithFormat:@"%@,%@",ids,obj.iD];
            }else{
                ids = obj.iD;
            }
        }
    }];
    return ids;
}

- (void)initTableView{
    self.title = @"商家活动管理";
    [self registerTableVieCell:@"BusinessActivityManagementCell"];
    self.base_CellHeight = 164;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessActivityManagementCell *cell = (BusinessActivityManagementCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.isFLog = _isFlog;
    cell.model  = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasMutabArray.count == 0||self.isFlog ==NO) {
        return;
    }
    BusinessActivityManagementModel *model= self.datasMutabArray[indexPath.section];
    BusinessActivityManagementCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectButton.selected = !cell.selectButton.selected;
    model.isSelected = !model.isSelected;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}



@end
