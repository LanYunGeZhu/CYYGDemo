//
//  PartWillOrderVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PartWillOrderVC.h"
#import "PartWillOrderInfoVC.h"
#import "PartWillOrderCell.h"
#import "PartWillOrderModel.h"
#import "LatestNavMenusView.h"
@interface PartWillOrderVC ()
@property (assign, nonatomic) NSInteger paytype;
@end

@implementation PartWillOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addMjRefresh];
    [self loadRequsetData];
    
    LatestNavMenusView *menusView = [LatestNavMenusView initBaseView];
    [menusView.segmentedControl setTitle:@"全部订单" forSegmentAtIndex:0];
    [menusView.segmentedControl setTitle:@"现金支付" forSegmentAtIndex:1];

    [menusView.segmentedControl setTitle:@"积分换购" forSegmentAtIndex:2];

    menusView.frame = CGRectMake(40, 0, Screen_wide - 80, 44);
    [menusView.segmentedControl addTarget:self action:@selector(nacMenusClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = menusView;

}

- (void)nacMenusClick:(UISegmentedControl *)segmented{
    self.paytype =segmented.selectedSegmentIndex;
    [self base_RefreshHeaderFooter:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_shopersjorders parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size),@"paytype":@(self.paytype)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[PartWillOrderModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"PartWillOrderCell"];
    self.base_CellHeight = 139;
    self.title = @"会员订单";
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PartWillOrderCell *cell = (PartWillOrderCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PartWillOrderInfoVC *partWill = [PartWillOrderInfoVC new];
    partWill.model =self.datasMutabArray[indexPath.section];
    [self.navigationController pushViewController:partWill animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01;
}


@end
