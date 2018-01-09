//
//  RefundsListVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RefundsListVC.h"
#import "OrderOnlineListCell.h"
#import "RefundsListHeadeView.h"
#import "RefundsListInfoVC.h"
#import "RefundsListModel.h"
#import "RefundsListCell.h"
#import "EaseMessageViewController.h"

@interface RefundsListVC ()

@property (nonatomic,strong) NSMutableArray *dicArr ;
@end

@implementation RefundsListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.】

    [self addMjRefresh];
    [self loadRequsetData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(shuaxin) name:@"shuaxin" object:nil];
    
}
- (void)shuaxin{
    [self loadRequsetData];
}

- (void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    
    [KSRequestManager postRequestWithUrlString:URL_reback_list parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        
        [self.datasMutabArray removeAllObjects];
        
        self.dicArr = [NSMutableArray new];
        
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *dic in responseObject[@"lists"]) {
            
            [arr addObject:[RefundsListModel whc_ModelWithJson:dic keyPath:@"goods"]];
            [self.datasMutabArray addObject:[RefundsListModel whc_ModelWithJson:dic keyPath:@"goods"]];
            [self.dicArr addObject:dic];
        }
        
        [self.myTableView reloadData];
        [self endRefresh];
        
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"退货/退款";
    [self registerTableVieCell:@"RefundsListCell"];
    self.base_CellHeight = 91;
    self.base_table_deleteEdit = NO;
    [super initTableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [[NSArray alloc]initWithArray:self.datasMutabArray[section]];
    return arr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RefundsListCell *cell = (RefundsListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.datasMutabArray[indexPath.section][indexPath.row];
      return cell;
}


- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
//    RefundsListModel *model = self.datasMutabArray[section];
    
    RefundsListHeadeView *headeView=  [RefundsListHeadeView initBaseView];
    headeView.nameLable.hidden = YES;
    headeView.timer.hidden = YES;
    headeView.data = self.dicArr[section][@"status_back"];
    
    headeView.contactTheSeller.tag = section;
    [headeView.contactTheSeller addTarget:self action:@selector(contactBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    

    return headeView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RefundsListInfoVC *infoVC= [RefundsListInfoVC new];
    infoVC.back_id = self.dicArr[indexPath.section][@"back_id"];
    infoVC.status = self.dicArr[indexPath.section][@"status_back"];
    infoVC.receiveArr = [[NSArray alloc]initWithArray:self.datasMutabArray[indexPath.section]];
    [self.navigationController pushViewController:infoVC animated:YES];
}

////点击删除
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//        [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=delete_orders_reback" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"back_id":self.dicArr[indexPath.section][@"back_id"]} success:^(id responseObject) {
//            
//            [self.datasMutabArray removeObjectAtIndex:indexPath.section];
//            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationLeft)];
//            
//        } failure:^(id error) {
//            
//        }];
//    }
//    
//}



- (void)contactBtn:(UIButton *)btn{
    
    if ([self.dicArr[btn.tag][@"status_back"] integerValue] == 6) {//申请被拒绝
        
        //联系卖家
        EaseMessageViewController * chatController = [[EaseMessageViewController alloc]initWithConversationChatter:@"ljjxiaomi20170327" conversationType:EMConversationTypeChat];
        chatController.title = @"App客服" ;
        
        [self.navigationController pushViewController:chatController animated:YES];
        
    }else{
        
        if (self.dicArr.count == 0) {
            [MBProgressHUD showInfoMessage:@"请求失败，请刷新后重试"];
            return;
        }
        
        //取消退款
        [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=cancel_orders_reback" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"back_id":KSDIC(self.dicArr[btn.tag], @"back_id")} success:^(id responseObject) {
            
            [MBProgressHUD showSuccessMessage:@"取消成功"];
            [self base_RefreshHeaderFooter:YES];
            
        } failure:^(id error) {
            
        }];
        
    }
}
@end
