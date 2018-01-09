//
//  ShoppingCartVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ShoppingCartVC.h"
#import "ShoppingCartCell.h"
#import "SettlementConfirmationVC.h"
#import "ShoppingCartModel.h"
@interface ShoppingCartVC ()<UITextFieldDelegate>

//@property (assign, nonatomic) isFuture;

@end

@implementation ShoppingCartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    [self loadRequsetData];
}

- (void)initTableView{
    self.base_CellHeight = 100;
    [self registerTableVieCell:@"ShoppingCartCell"];
    self.base_table_deleteEdit = YES;
    self.title = @"我的购物车";
    [super initTableView];
    /**
     *
     */
}


- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_usermy_cart parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[ShoppingCartModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ShoppingCartCell *cell = (ShoppingCartCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.addNum addTarget:self action:@selector(addNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteNum addTarget:self action:@selector(deleteNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.selectButton addTarget:self action:@selector(selectButtonClikc:) forControlEvents:UIControlEventTouchUpInside];
    cell.model = self.datasMutabArray[indexPath.row];
    cell.textField.delegate = self;
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ShoppingCartModel *model = self.datasMutabArray[indexPath.row];
        [KSRequestManager postRequestWithUrlString:URL_delete_cart_goods parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"rec_id":model.rec_id} success:^(id responseObject) {
            [self.datasMutabArray removeObjectAtIndex:indexPath.row];
            [self.myTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        } failure:^(id error) {
            
        }];
    }
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
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
        if ([KSDIC(error, @"msg") isEqualToString:@"库存不足"]) {
            return ;
        }
    }];

}

#pragma mark -- 是否选中
- (void)selectButtonClikc:(UIButton *)sender{
    sender.selected = !sender.selected;
    ShoppingCartModel *model= self.datasMutabArray[[self gitIndexPathThroughView:sender].row ];
    model.isChoose = sender.selected ? 1 : 0;
    [self settlementNumsAndPrice];
}

- (NSIndexPath *)gitIndexPathThroughView:(UIView *)view{
    ShoppingCartCell *cell = (ShoppingCartCell *)view.superview.superview;
    return  [self.myTableView indexPathForCell:cell];
}

#pragma mark -- 全选
- (IBAction)FutureGenerations:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.datasMutabArray enumerateObjectsUsingBlock:^(ShoppingCartModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.isChoose = sender.selected ?1 : 0;
        
    }];
    [self.myTableView reloadData];
    [self settlementNumsAndPrice];
}


#pragma mark -- 结算
- (IBAction)settlementIs:(id)sender{
    [ShoppingCartModel orderShoppingCartrNum:self.datasMutabArray numPrice:^(NSInteger num, float price) {
        if (num == 0) {
            [MBProgressHUD showTipMessageInWindow:@"请选择商品"];
        }else{
            WeakSelf
            SettlementConfirmationVC *settement= [SettlementConfirmationVC new];
            settement.datasMutabArray = [[self getIsSelectGoods] mutableCopy];
            settement.upDataNum = ^{
                [weakSelf.myTableView reloadData];
            };
            [self.navigationController pushViewController:settement animated:YES];
        }
    }];
  
}

- (NSArray *)getIsSelectGoods{
    NSMutableArray *array = [NSMutableArray array];
    [self.datasMutabArray enumerateObjectsUsingBlock:^(ShoppingCartModel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.isChoose == 1) {
            [array addObject:obj];
        }
    }];
    return array;
}

/** 计算总价*/
- (void)settlementNumsAndPrice{
    
    [ShoppingCartModel orderShoppingCartrNum:self.datasMutabArray numPrice:^(NSInteger num, float price) {
   
        self.totalPrice.text = [NSString stringWithFormat:@"%.2f",price];
        [self.isSelectButton setTitle:[NSString stringWithFormat:@"结算(%ld)",num] forState:UIControlStateNormal];
    }];
}

@end
