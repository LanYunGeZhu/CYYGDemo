//
//  PointsForDetailsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PointsForDetailsVC.h"
#import "PartInfoCell.h"
#import "EventContextCell.h"
#import "WPswView.h"
#import "KSPickView.h"
@interface PointsForDetailsVC ()
//驳回
@property (weak, nonatomic) IBOutlet UIButton *rejected;
//驳回
@property (weak, nonatomic) IBOutlet UIButton *through;
@property (weak, nonatomic) IBOutlet UIView *pswBgView;
@property (weak, nonatomic) IBOutlet UITextField *password;

@property (strong, nonatomic) NSArray *contextArray;

@end

@implementation PointsForDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    if ([_model.status integerValue] ==0) {
        self.rejected.hidden = NO;
        self.through.hidden = NO;
    }else{
        self.rejected.hidden = YES;
        self.through.hidden = YES;
        self.pswBgView.hidden = YES;
    }

}

/*
 *
 
 未审核的订单，显示两个审核按钮
 已审核的不显示审核按钮
 
 
 点击通过时，toast提示【已通过】同时返回上一页
 点击驳回，dialog提示如下图，点击确定后toast是【已驳回】同时返回上一页
 */
- (IBAction)mencClikc:(UIButton *)sender{
    if ([self.password.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入支付密码？"];
        return;
    }
    NSString *message = @"";
    if (sender.tag == 0) {
        //驳回
        message = @"您确定要驳回吗？";
        [self addLoadPoints:sender message:message rlbl:@""];

    }else{
        //通过
        message = @"您确定要通过审核吗？";
        [self queryGet_rlblList:^(NSArray *lsitArray) {
//            NSArray *datasArray = [self gitNameListArray:lsitArray];
//            [self base_showPickViewListDatasArray:@[datasArray] selectArray:^(NSArray *array) {
//                [self addLoadPoints:sender message:message rlbl:array[0][@"context"]];
//            }];
            [self addLoadPoints:sender message:message rlbl:@""];

        }];
    }
   
}

//
- (void)queryGet_rlblList:(void(^)(NSArray *lsitArray))listArray{
    [KSRequestManager postRequestWithUrlString:URL_get_rlbl parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        listArray(responseObject);
    } failure:^(id error) {
        
    }];
}

- (NSMutableArray *)gitNameListArray:(NSArray *)listArray{
    NSMutableArray *array = [NSMutableArray array];
    [listArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@ %@",KSDIC(obj, @"name"),KSDIC(obj, @"val")]];
    }];
    return array;
}

- (void)addLoadPoints:(UIButton *)sender message:(NSString *)message rlbl:(NSString *)rlbl{
    [KSTool alertViewWithController:self title:@"温馨提示" message:message items:@[@"取消",@"确定"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
        if (indx== 1) {
            NSDictionary *dic = @{@"user_id":[UserInfoManager sharedManager].user_id,@"ids":_model.iD,@"status":sender.tag == 0 ? @"2":@"1"
                                  ,@"rlbl":@"16"
                                  ,@"pay_password":self.password.text
                                  };
            
            [KSRequestManager postRequestWithUrlString:URL_audit_sjorder parameter:dic success:^(id responseObject) {
                [MBProgressHUD showTipMessageInWindow:@"操作成功"];
                if (_upDataSuccess) {
                    _upDataSuccess();
                    [self.navigationController popViewControllerAnimated:YES];
                }
            } failure:^(id error) {
                
            }];
        }
    }];

}


- (void)initTableView{
    [self registerTableVieCell:@"PartInfoCell"];
    self.title = @"订单信息";
    self.base_CellHeight = 44;
    self.datasMutabArray = @[@"订单编号",@"商品名称",@"消费金额",@"让利比例",@"让利金额"];
    self.contextArray = @[_model.orderid,_model.goods_name,_model.price,[NSString stringWithFormat:@"%@%%",@"C-模式16"],_model.rl_money,@""];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasMutabArray.count  ;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    PartInfoCell *cell = (PartInfoCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.nameLabel.text = self.datasMutabArray[indexPath.row];
    cell.context.text = self.contextArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}




@end
