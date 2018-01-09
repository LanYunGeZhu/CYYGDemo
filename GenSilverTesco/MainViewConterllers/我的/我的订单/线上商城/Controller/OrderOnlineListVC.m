//
//  OrderOnlineListVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OrderOnlineListVC.h"
#import "OrderOnlineListCell.h"
#import "OnlineHeaderView.h"
#import "OnlineFooterView.h"
#import "OrderOnlineInfoVC.h"
#import "OrderOnlineModel.h"
#import "OnlineOrderEvaluationVC.h"
#import "ApplyForARefundVC.h" //申请退货
#import "PrderPaymentVC.h"
#import "EaseMessageViewController.h"
#import "GoodsDetailsVC.h"
#import "MyViewControllerVC.h"
@interface OrderOnlineListVC ()

@end

@implementation OrderOnlineListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addMjRefresh];
    [self loadRequsetData];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        ApplyForARefundVC *applyFor = [ApplyForARefundVC new];
//        [[KSTabBarController gitNavigationController ] pushViewController:applyFor animated:YES];
//
//    });
}

- (void)goBack{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)loadRequsetData{
    /**
     *
     全部 pay_status=-1  shipping_status=-1,
     待付款 pay_status=0,shipping_status=0,
     待发货pay_status=2,shipping_status=0,
     待收货pay_status=2,shipping_status=1,
     待评价pay_status=2,shipping_status2
     */
    NSArray *statusArray = @[@{@"pay_status":@"-1",@"shipping_status":@"-1"}
                             ,@{@"pay_status":@"0",@"shipping_status":@"0"}
                             ,@{@"pay_status":@"2",@"shipping_status":@"0"}
                             ,@{@"pay_status":@"2",@"shipping_status":@"1",}
                             ,@{@"pay_status":@"2",@"shipping_status":@"2",@"iscomment":@"0"}];
    NSMutableDictionary * mutableDictionary =[@{@"user_id":[UserInfoManager sharedManager].user_id
                                                ,@"page":@(self.page)
                                                ,@"size":@(self.size)
                                                }mutableCopy];
    [mutableDictionary addEntriesFromDictionary:statusArray[_index]];
    [KSRequestManager postRequestWithUrlString:URL_ordersList parameter:mutableDictionary success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[OrderOnlineModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
 
}

- (void)initTableView{
    [self registerTableVieCell:@"OrderOnlineListCell"];
    self.base_CellHeight = 91;
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    OrderOnlineModel *model = self.datasMutabArray[section];
    return model.goods.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderOnlineListCell *cell = (OrderOnlineListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    OrderOnlineModel *model = self.datasMutabArray[indexPath.section];

    cell.model = model.goods[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeakSelf
    KSNavigationController *nav= [KSTabBarController gitNavigationController ];
    OrderOnlineInfoVC *orderInfo = [OrderOnlineInfoVC new];
    OrderOnlineModel *model = self.datasMutabArray[indexPath.section];
    orderInfo.order_id = model.order_id;
    orderInfo.goBlckOrderInfo  = ^(orderStatus orderStatus){
        if (orderStatus == delete_Order_Success) {
            [weakSelf.datasMutabArray removeObjectAtIndex:indexPath.section];
            [weakSelf.myTableView reloadData];
        }else if (orderStatus == update_Order_evaluation){
            [weakSelf.datasMutabArray removeObjectAtIndex:indexPath.section];
            [weakSelf.myTableView reloadData];
        }
    };
    [nav pushViewController:orderInfo animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 44;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    WeakSelf
    OnlineHeaderView * header = [OnlineHeaderView initBaseView];
    header.model = self.datasMutabArray[section];
    header.base_BlockIdx = ^(NSInteger index){
        [weakSelf deleteOrder:section];
    };
    return header;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    WeakSelf
    OnlineFooterView *footer = [OnlineFooterView initBaseView];
    footer.model = self.datasMutabArray[section];
    footer.base_BlockIdx = ^(NSInteger index){
        [weakSelf footerMenusClick:section];
    };
    return footer;
}

/** 删除*/
- (void)deleteOrder:(NSInteger)section {
    OrderOnlineModel *model = self.datasMutabArray[section];

        if ([model.order_status integerValue]== 0) {
            //代付款
            [KSTool alertViewWithController:self title:@"温馨提示" message:nil items:@[@"删除"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
                [self deleteOrderDataReuqset:section];
            }];
        }else if ([model.order_status integerValue] ==1){
            [KSTool alertViewWithController:self title:@"温馨提示" message:nil items:@[@"申请退款"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
                
                ApplyForARefundVC *applyFor = [ApplyForARefundVC new];
                applyFor.receivemodel = model;
                [[KSTabBarController gitNavigationController ] pushViewController:applyFor animated:YES];

            }];
        }else if ([model.order_status integerValue] ==5){
            //交易关闭
            [KSTool alertViewWithController:self title:@"温馨提示" message:nil items:@[@"删除"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
                [self deleteOrderDataReuqset:section];
            }];
        }

}

- (void)deleteOrderDataReuqset:(NSInteger)section{
    
    OrderOnlineModel *model = self.datasMutabArray[section];

    [KSTool alertViewWithController:self title:@"温馨提示" message:@"您确定要删除此订单吗？" items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
        if (indx == 0) {
            return ;
        }
        [KSRequestManager postRequestWithUrlString:URL_order_delete parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"order_id":model.order_id} success:^(id responseObject) {
            [self.datasMutabArray removeObjectAtIndex:section];
            [self.myTableView reloadData];
        } failure:^(id error) {
        }];
        
    }];
}

/** 确认订单 取消 等操作*/
- (void)footerMenusClick:(NSInteger)section{

    OrderOnlineModel *model = self.datasMutabArray[section];
 
        if ([model.order_status integerValue] == 0) {
            //去付款
            PrderPaymentVC * prode = [PrderPaymentVC new];
            prode.data = @{@"order_id":model.order_id,@"order_amount":model.order_amount};
            [[KSTabBarController gitNavigationController ] pushViewController:prode animated:YES];
        }else if ([model.order_status integerValue]  ==1){
            //联系卖家
            EaseMessageViewController * chatController = [[EaseMessageViewController alloc]initWithConversationChatter:@"ljjxiaomi20170327" conversationType:EMConversationTypeChat];
            chatController.title = @"App客服" ;
            [[KSTabBarController gitNavigationController ] pushViewController:chatController animated:YES];
            
        }else if ([model.order_status integerValue]  ==2){
            [self confirmTheGoods:model];
        }else if ([model.order_status integerValue]  ==3){
            WeakSelf
            // 去评价
            OnlineOrderEvaluationVC *evaluation = [OnlineOrderEvaluationVC new];
            evaluation.upDataSccuss =^{
                [weakSelf base_RefreshHeaderFooter:YES];
            };
            evaluation.model = self.datasMutabArray[section];
            [[KSTabBarController gitNavigationController ] pushViewController:evaluation animated:YES];
        }else {
            //再次购买
            OrderOnlineModel *model = self.datasMutabArray[section];
            OrderOnlineGoods *goodsModel=  model.goods[0];
            GoodsDetailsVC *goodsDetaols = [GoodsDetailsVC new];
            goodsDetaols.goods_id = goodsModel.goods_id;
            [[KSTabBarController gitNavigationController ] pushViewController:goodsDetaols animated:YES];
        }
}

- (void)confirmTheGoods:(OrderOnlineModel *)model{
    
    [KSRequestManager postRequestWithUrlString:URL_order_shipped parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"order_id":model.order_id} success:^(id responseObject) {
        [MBProgressHUD showTipMessageInWindow:@"确认收货成功"];
        [self base_RefreshHeaderFooter:YES];
    } failure:^(id error) {
        
    }];
}

@end
