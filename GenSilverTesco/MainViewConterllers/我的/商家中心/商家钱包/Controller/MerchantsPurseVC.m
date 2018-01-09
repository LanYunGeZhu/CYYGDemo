//
//  MerchantsPurseVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MerchantsPurseVC.h"
#import "PurseHeaderView.h"
#import "PurseListCell.h"
#import "MerchantsPurseModel.h"
@interface MerchantsPurseVC ()

@property (strong, nonatomic) PurseHeaderView *headerView;
@end


@implementation MerchantsPurseVC

- (PurseHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [PurseHeaderView initBaseView];
        _headerView.frame = CGRectMake(0, 0, Screen_wide, Screen_wide *219/375);
    }
    return _headerView;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self setNavStatusBarRedColor:[UIColor redColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self setNavStatusBarRedColor:[UIColor clearColor]];

}

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
//    [super loadRequsetData];
    [KSRequestManager postRequestWithUrlString:URL_appmoneyrecord parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":@(self.page),@"size":@(self.size),@"ptype":@"7"} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[MerchantsPurseModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        self.headerView.tintegral.text = [NSString stringWithFormat:@"%@",KSDIC(responseObject, @"tintegral")];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    
    [self registerTableVieCell:@"PurseListCell"];
    self.myTableView.tableHeaderView = self.headerView;
    self.base_CellHeight = 100;
    WeakSelf
    self.headerView.base_BlockIdx = ^(NSInteger index){
        [weakSelf goBack];
    };
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PurseListCell *cell = (PurseListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
//    NSString * numString = @"214234";
//   
//    cell.rebatePoints.attributedText = [KSTool setAttributedString:[NSString stringWithFormat:@"返还积分 : %@",numString] color: [UIColor redColor] startNum:7 length:numString.length];
    cell.model = self.datasMutabArray[indexPath.section];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01;
}




@end
