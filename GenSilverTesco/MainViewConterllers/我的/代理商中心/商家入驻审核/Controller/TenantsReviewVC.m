//
//  TenantsReviewVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/27.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "TenantsReviewVC.h"
#import "TenantsReviewCell.h"
#import "TenantsReviewModel.h"
@interface TenantsReviewVC ()
@property (assign, nonatomic) BOOL isFlog;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *table_bottom_height;
@property (assign, nonatomic) NSInteger order_sataus;
@end

@implementation TenantsReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.order_sataus = -1;
    [self addMjRefresh];
    [self loadRequsetData];
    
    [self setRightWithString:@"管理" action:@selector(managerClick)];
    self.table_bottom_height.constant = 0;
    [self getTheAgentInformation];
}

/**
 代理商基本信息：api/agent.php?act=agent_info
	上传参数：用户ID：user_id
	返回参数：代理商姓名：real_name
 代理区域：agent_area
 本月业绩：monthStat
 总业绩：totalStat
 */

- (void)getTheAgentInformation{
    [KSRequestManager postRequestWithUrlString:URL_agent_info parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.address setTitle:[NSString stringWithFormat:@" %@",KSDIC(responseObject, @"agent_area")] forState:UIControlStateNormal];
    } failure:^(id error) {
        
    }];
}

- (void)managerClick{
    self.order_sataus = 0;
    [self base_RefreshHeaderFooter:YES];
    self.isFlog = YES;
    [self setRightWithString:@"全选" action:@selector(futureGenerations)];
    [self setLeftWithString:@"取消" action:@selector(canlClick)];
    self.table_bottom_height.constant = 40;
    [self.myTableView reloadData];
}

- (void)canlClick{
    self.order_sataus = -1;
    [self base_RefreshHeaderFooter:YES];
    self.isFlog = NO;
    [self setLeftDefultWithNav];
    [self setRightWithString:@"管理" action:@selector(managerClick)];
    self.table_bottom_height.constant = 0;
    [self.myTableView reloadData];
}

- (void)futureGenerations{
//    [self.datasMutabArray enumerateObjectsUsingBlock:^(RegionalOrderApprovaModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.isSelected = 1;
//    }];
//    [self.myTableView reloadData];
}


- (void)base_RefreshHeaderFooter:(BOOL)isHeader
{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_agentshops parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"status":@(self.order_sataus),@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[TenantsReviewModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self headerNum:[KSDIC(responseObject, @"total0") integerValue]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)headerNum:(NSInteger)num{

    NSString *numString  = [NSString stringWithFormat:@"%ld",num];
    NSMutableAttributedString * mutableAttributed = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"未审核 %@ 家",numString]];
    [mutableAttributed setAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(4, numString.length)];
    self.num.attributedText = mutableAttributed;
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
            [KSRequestManager postRequestWithUrlString:URL_audit_shops parameter:dic success:^(id responseObject) {
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
    [self.datasMutabArray enumerateObjectsUsingBlock:^(TenantsReviewModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
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
    [self registerTableVieCell:@"TenantsReviewCell"];
    self.base_CellHeight = 150;
    self.title = @"商家入驻审核";
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TenantsReviewCell *cell = (TenantsReviewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.isFlog = _isFlog;
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasMutabArray.count == 0||self.isFlog ==NO) {
        return;
    }
    TenantsReviewModel *model= self.datasMutabArray[indexPath.section];
    TenantsReviewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
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
