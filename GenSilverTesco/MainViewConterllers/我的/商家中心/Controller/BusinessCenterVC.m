//
//  BusinessCenterVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "BusinessCenterVC.h"
#import "AgentHeaderView.h"
#import "AmountCell.h"
#import "AgentListCell.h"
#import "WWithDrawVC.h"
@interface BusinessCenterVC ()

@property (strong, nonatomic) AgentHeaderView *headerView;

@property (strong, nonatomic) id data;
@end

@implementation BusinessCenterVC

- (AgentHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [AgentHeaderView initBaseView];
        _headerView.frame = CGRectMake(0, 0, Screen_wide, Screen_wide *251/375);
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadRequsetData];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_my_index parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        self.data = responseObject[@"shop"];
        self.headerView.data =  self.data;
        [self reloadSection:0];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"商家中心";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.myTableView.tableHeaderView = self.headerView;
    });
    [self registerTableVieCellsArray:@[@"AmountCell",@"AgentListCell"]];
    
    self.datasMutabArray = [@[@[@""]
                              ,@[@{@"name":@"充值中心",@"image":@"充值中心"},@{@"name":@"商家钱包",@"image":@"商家钱包"},@{@"name":@"店铺管理",@"image":@"店铺管理"}]
                              ,@[@{@"name":@"商家做单",@"image":@"商家做单"},@{@"name":@"会员订单",@"image":@"会员订单"},@{@"name":@"业绩明细",@"image":@"业绩明细"}]
                              ,@[@{@"name":@"活动管理",@"image":@"活动管理"},@{@"name":@"积分换购管理",@"image":@"图标11"},@{@"name":@"推荐会员管理",@"image":@"推荐会员管理"}]]mutableCopy];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datasMutabArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WeakSelf
        AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmountCell" forIndexPath:indexPath];
        [cell.addMerchants setTitle:@"       提  现       " forState:UIControlStateNormal];
        [cell.addMerchants setImage:nil forState:UIControlStateNormal];
        [cell setViewCornerRadiusViews:@[cell.addMerchants] floatCoriner:8];
        [cell.addMerchants.layer setBorderColor:[UIColor redColor].CGColor];
        [cell.addMerchants.layer setBorderWidth:1];
        cell.title1.text = @"可提现让利金/积分";
        cell.title2.text = @"可提现货款/积分";
        if (_data) {
            cell.monthOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"bz_points")];
            cell.yearsOnGold.text = [NSString stringWithFormat:@"%@", KSDIC(_data, @"hk_points")];
        }
       
        cell.baseCell_buttonIndex = ^(NSInteger index){
            // 区域业绩  上传商家
//            index == 0 ? [weakSelf regionalPerformance] : [weakSelf addMerchts] ;
            WWithDrawVC *with = [WWithDrawVC new];
            [weakSelf.navigationController pushViewController:with animated:YES];
        };
        return cell;
    }else{
        AgentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentListCell" forIndexPath:indexPath];
        id data = self.datasMutabArray[indexPath.section];
        cell.name.text = data[indexPath.row][@"name"];
        cell.icoImageView.image = [UIImage imageNamed:data[indexPath.row][@"image"]];
        
        return cell;
    }
    return nil;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *viewConterollers = @[@[@"WRechargeVC",@"MerchantsPurseVC",@"StoreManagementVC"],@[@"WMakeOrderVC",@"PartWillOrderVC",@"PerformanceOfSubsidiaryVC"],@[@"ActivityManagementVC",@"IntegralManagementVC",@"MemberOfTheManagementVC"]];
    
    UIViewController *viewController = [NSClassFromString(viewConterollers[indexPath.section -1][indexPath.row]) new];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section ==0 ? 95 : 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01f;
}

//#pragma mark -- 区域业绩
//- (void)regionalPerformance{
//    RegionalPerformanceVC * regional = [RegionalPerformanceVC new];
//    [self.navigationController pushViewController:regional animated:YES];
//}
//
//#pragma mark -- 添加商家
//- (void)addMerchts{
//    
//    UploadTheMerchantsVC *upload = [UploadTheMerchantsVC new];
//    [self.navigationController pushViewController:upload animated:YES];
//}
//


@end
