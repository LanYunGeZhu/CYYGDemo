//
//  WWIthRecordVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WWIthRecordVC.h"
#import "WWinthDrawReCordCell.h"
#import "UILabel+Kiwi.h"
#import "WNavView.h"
#import "WPoPView.h"
#import "WRecordModel.h"
#import <MJRefresh.h>

static NSString *kCellID = @"cellID";


@interface WWIthRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger page;
    NSString *process_type;
}
@property (nonatomic,strong)WNavView *navView;

@end

@implementation WWIthRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    process_type = [NSString stringWithFormat:@"%ld",(long)-1];

    [self WaddRefresh];

}

- (void)initData
{
    
    _navView = [WNavView initBaseView];
    _navView.frame = CGRectMake(0, 0, 100, 30);
    self.navigationItem.titleView = _navView;
    
    [self.recordTab registerNib:[UINib nibWithNibName:@"WWinthDrawReCordCell" bundle:nil] forCellReuseIdentifier:kCellID];
    self.title = @"提现记录";
    
    
    __weak typeof(self) weakSelf = self;
    
    _navView.base_BlockIdx = ^(NSInteger index)
    {
        WPoPView *PoPOverView = [WPoPView popoverView];
        
        NSMutableArray *ActionArr = [NSMutableArray array];
        
        for (NSInteger i = 0 ; i <@[@"全部",@"提现让利金",@"提现贷款"].count; i++)
        {
            WPoPaction *action = [WPoPaction actionWithTitle:@[@"全部",@"提现让利金",@"提现贷款"][i] withTag:i  handler:^(WPoPaction *action) {
                [weakSelf.datasMutabArray removeAllObjects];
                [weakSelf.recordTab reloadData];
                NSLog(@"%ld",(long)action.tag);
                process_type = [NSString stringWithFormat:@"%ld",(long)i-1];
                [weakSelf WLoadRequest:i-1];
            }];
            
            [ActionArr addObject:action];
        }
        [PoPOverView showToView:weakSelf.navView withActions:ActionArr];

    };
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WWinthDrawReCordCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    
    if (self.datasMutabArray.count > 0)
    {
        WRecordModel *model = self.datasMutabArray[indexPath.row];
        
        cell.state = model.ptype;
        cell.tpyestate = model.fkstatus;
        cell.NetPotLa.text = StringWithStr(@"提现网点:",model.bank_addr);
        cell.dateLa.text = model.add_time;
        cell.peopletLa.text = StringWithStr(@"提现人:",model.buser);
        
        [cell.moneyLa WSetMutibleColorWith:StringWithStr(@"提现:",StringWithStr(model.amount, @"元"))];

    }
    
    return cell;
}
- (void)WaddRefresh
{
    self.recordTab.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.datasMutabArray removeAllObjects];
        [self.recordTab reloadData];
        page = 1;
        [self WLoadRequest:page];
    }];
    
    self.recordTab.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        page ++;
        [self WLoadRequest:page];
    }];
    [self WLoadRequest:page];
    
}

////////////////////
- (void)WLoadRequest:(NSInteger)index
{
    
    [KSRequestManager postRequestWithUrlString:URL_appcharge parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":[NSString stringWithFormat:@"%ld",index],@"ptype":process_type,@"size":@"20",@"process_type":@"1"} success:^(id responseObject) {
        
        
        [self.datasMutabArray addObjectsFromArray:[WRecordModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.recordTab reloadData];
        
        if (self.datasMutabArray.count == 0)
        {
            [MBProgressHUD showErrorMessage:noMoreData];
        }
        [self endRefresh];
        
    } failure:^(id error) {
        
    }];
}
- (void)endRefresh{
    [self.recordTab.mj_header endRefreshing];
    [self.recordTab.mj_footer endRefreshing];
}

@end
