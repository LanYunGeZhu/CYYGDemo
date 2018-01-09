//
//  SettlementConfirmationVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SettlementConfirmationVC.h"
#import "OnlineAddressCell.h"
#import "ShoppingCartCell.h"
#import "MyAddressVC.h"
#import "MyAddressModel.h"
#import "PrderPaymentVC.h"
@interface SettlementConfirmationVC ()<UITextFieldDelegate>
@property (strong, nonatomic)MyAddressModel *model;
@property (copy, nonatomic) NSString *pay_id;
@end

@implementation SettlementConfirmationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self settlementNumsAndPrice];
    [[WHC_KeyboardManager share] addMonitorViewController:self];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_model == nil) {
        [self loadAddress];
    }

}

- (void)loadAddress{

    WeakSelf
    [KSRequestManager postRequestWithUrlString:URL_address_list parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSArray *array = KSDIC(responseObject, @"lists");
        if (array.count == 0) {
            
            [KSTool alertViewWithController:self title:@"温馨提示" message:@"您当前还没有添加收货地址" items:@[@"取消",@"去添加"] style:UIAlertControllerStyleAlert idx:^(NSInteger indx) {
                if (indx == 0) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else{
                    [weakSelf goAddressVC];
                    
                }
            }];
        }
        else{
            _model = [MyAddressModel whc_ModelWithJson:array[0]];
            [weakSelf getfreightAddress:_model.address_id];
        }
        [self reloadSection:0];
    } failure:^(id error) {
        
    }] ;
}

//获取地址
- (void)goAddressVC{
    WeakSelf
    MyAddressVC *myAddres = [MyAddressVC new];
    myAddres.selectListModel = ^(MyAddressModel *model){
        weakSelf.model = model;
        [weakSelf getfreightAddress:_model.address_id];
        [weakSelf reloadSection:0];
    };
    [self.navigationController pushViewController:myAddres animated:YES];
}

/*
 *
 84:获取运费:api/orders.php?act=get_shipping_fee
	上传数据：用户ID：user_id,
 ID：rec_id,（如果为空，表示购物车中全部，多个用逗号隔开）
 收货地址ID：address_id
 快递方式：pay_id
	返回数据：运费：shipping_fee
 */
- (void)getfreightAddress:(NSString *)address_id{
    NSDictionary *dic = @{@"address_id":address_id,@"user_id":[UserInfoManager sharedManager].user_id,@"rec_id": [self gitIdsOrder]};
    
    [KSRequestManager postRequestWithUrlString:URL_get_shipping_fee parameter:dic success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.theFreight.text = [NSString stringWithFormat:@"(含运费: ￥%@)",KSDIC(responseObject,@"shipping_fee")];
        if ([self.pay_id isKindOfClass:[NSString class]]) {
            
        }
        self.pay_id = KSDIC(responseObject, @"pay_id");

    } failure:^(id error) {
        
    }];
}

/** 计算总价*/
- (void)settlementNumsAndPrice{
    
    [ShoppingCartModel orderShoppingCartrNum:self.datasMutabArray numPrice:^(NSInteger num, float price) {
        
        self.totalPrice.text = [NSString stringWithFormat:@"%.2f",price];
        [self.isSelectButton setTitle:[NSString stringWithFormat:@"结算(%ld)",num] forState:UIControlStateNormal];
    }];
}

- (void)initTableView{
    self.title = @"结算确认";
    [self registerTableVieCellsArray:@[@"OnlineAddressCell",@"ShoppingCartCell"]];
}

- (void)goBack{
    [super goBack];
    if (_upDataNum) {
        _upDataNum();
    }
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
        return self.datasMutabArray.count;
    }
    
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        OnlineAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OnlineAddressCell" forIndexPath:indexPath];
        if (_model) {
            cell.model = _model;
        }
        return cell;
    }
    else{
        ShoppingCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingCartCell" forIndexPath:indexPath];
        cell.selectButton.hidden = YES;
        [cell.addNum addTarget:self action:@selector(addNumClick:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteNum addTarget:self action:@selector(deleteNumClick:) forControlEvents:UIControlEventTouchUpInside];
        cell.layou_icoIamge_leading.constant = - 30;
        cell.model = self.datasMutabArray[indexPath.row];
        cell.textField.delegate = self;

        return cell;
    }
}

//输入框修改价格
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    NSIndexPath *indexPath = [self gitIndexPathThroughView:textField];
    ShoppingCartModel *model = self.datasMutabArray[indexPath.row];
    NSInteger num = [textField.text integerValue];
    if ([textField.text integerValue] > [model.stock integerValue]) {
        [MBProgressHUD showTipMessageInWindow:@"库存不足"];
        num = [model.stock integerValue];
        
    }
    [self updateReuqsetData:num model:model success:^{
        textField.text = [NSString stringWithFormat:@"%ld",(long)num];
        model.goods_number = textField.text;

    } failure_num:^{
        textField.text = model.goods_number;
    }];
    return YES;
}


#pragma mark -- 添加
- (void)addNumClick:(UIButton *)sender{
    [self addAndDelete:YES indexPath:[self gitIndexPathThroughView:sender]];
    
}

#pragma mark -- 删除
- (void)deleteNumClick:(UIButton *)sender{
    [self addAndDelete:NO indexPath:[self gitIndexPathThroughView:sender]];
    
}

/** 添加或者删除公共方法*/
- (void)addAndDelete:(BOOL)flog indexPath:(NSIndexPath *)indexPath{
    
    ShoppingCartModel *model= self.datasMutabArray[indexPath.row];
    if (!flog &&[model.goods_number integerValue] -1 == 0) {
        return;
    }
    NSInteger num = flog ? [model.goods_number integerValue] + 1 : [model.goods_number integerValue] - 1;
    
    [self updateReuqsetData:num model:model success:^{
        ShoppingCartCell *cell = [self.myTableView cellForRowAtIndexPath:indexPath];
        cell.textField.text = [NSString stringWithFormat:@"%ld",(long)num];
    } failure_num:^{
        
    }];
}

- (void)updateReuqsetData:(NSInteger)num model:(ShoppingCartModel *)model success:(void(^)())success failure_num:(void(^)())failure_num{
    [KSRequestManager  postRequestWithUrlString:URL_change_number parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"goods_number":@(num),@"rec_id":model.rec_id} success:^(id responseObject) {
        model.goods_number = [NSString stringWithFormat:@"%ld",num];
        [self settlementNumsAndPrice];
        success();
    } failure:^(id error) {
        failure_num();
        if ([error isKindOfClass:[NSError class]]) {
            return ;
        }
        if ([KSDIC(error, @"msg") isEqualToString:@"库存不足"]) {
            return ;
        }
    }];
    
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
     
        [self goAddressVC];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 80;
    }else{
        return 100;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 16:0;
}

- (NSIndexPath *)gitIndexPathThroughView:(UIView *)view{
    ShoppingCartCell *cell = (ShoppingCartCell *)view.superview.superview;
    return  [self.myTableView indexPathForCell:cell];
}


#pragma mark -- 结算
- (IBAction)settlementIs:(id)sender{
    NSDictionary * dic = @{@"user_id":[UserInfoManager sharedManager].user_id
                           ,@"ids":[self gitIdsOrder]
                           ,@"address_id":_model.address_id
                           ,@"pay_id":self.pay_id};
    [KSRequestManager postRequestWithUrlString:URL_order_down parameter:dic success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        PrderPaymentVC *payMent = [PrderPaymentVC new];
        payMent.data = responseObject;
        [self.navigationController pushViewController:payMent animated:YES];
    } failure:^(id error) {
        
    }];
    

   
    
}

- (NSString *)gitIdsOrder{
    __block NSString *ids = @"";
    [self.datasMutabArray enumerateObjectsUsingBlock:^(ShoppingCartModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([ids isEqualToString:@""]) {
            ids = obj.rec_id;
        }else{
            ids = [NSString stringWithFormat:@"%@,%@",ids,obj.rec_id];
        }
    }];
    return ids;
}


@end
