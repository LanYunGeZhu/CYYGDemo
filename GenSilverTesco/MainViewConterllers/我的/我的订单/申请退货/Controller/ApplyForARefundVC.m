//
//  ApplyForARefundVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ApplyForARefundVC.h"
#import "OrderOnlineListCell.h"
#import "ApplyForARefundFooterView.h"
#import "RefundsListVC.h"
@interface ApplyForARefundVC ()

@property (strong, nonatomic) ApplyForARefundFooterView *footerView;
@end

@implementation ApplyForARefundVC

- (ApplyForARefundFooterView *)footerView{
    if (_footerView == nil) {
        _footerView = [ApplyForARefundFooterView initBaseView];
        _footerView.frame = CGRectMake(0, 0, Screen_wide, 120);
    }
    return _footerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setRightWithString:@"提交" action:@selector(subCommit)];
    
}

- (void)subCommit{
    if ([self.footerView.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入退款说明"];
        return;
    }
    
    [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=orders_reback" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"order_id":_receivemodel.order_id,@"ptype":@"4",@"back_reason":self.footerView.contextTextView.text} success:^(id responseObject) {
        
        NSLog(@"---%@",responseObject);
        [MBProgressHUD showSuccessMessage:@"提交成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
//            [self.navigationController popViewControllerAnimated:YES];
            RefundsListVC *renfuds  =[RefundsListVC new];
            [self.navigationController pushViewController:renfuds animated:YES];
        });
        
        
    } failure:^(id error) {
        
    }];
    
}

- (void)initTableView{
    self.title = @"申请退款";
    [self registerTableVieCell:@"OrderOnlineListCell"];
    self.base_CellHeight = 91;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.myTableView.tableFooterView = self.footerView;
    });
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _receivemodel.goods.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    OrderOnlineListCell *cell = (OrderOnlineListCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    
    cell.model = _receivemodel.goods[indexPath.row];
    
    return cell;

}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}


@end
