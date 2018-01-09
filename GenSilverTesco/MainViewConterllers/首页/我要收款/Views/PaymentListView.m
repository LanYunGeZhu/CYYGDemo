//
//  PaymentListView.m
//  GenSilverTesco
//
//  Created by MrSong on 17/9/9.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PaymentListView.h"
#import "IWantMenuView.h"
#import "UIImage+Add.h"
#import "MyOrderListVC.h"

@implementation PaymentListView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.startGathering.layer setCornerRadius:8];
    [self.startGathering.layer setMasksToBounds:YES];
    [self.bgView.layer setCornerRadius:4];
    [self.bgView.layer setMasksToBounds:YES];
    self.bgCodeView.hidden = YES;
    self.priceField.delegate = self;
    
    
}


- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        textField.placeholder = @"请输入收款金额";
    }else{
        _integral.text = [NSString stringWithFormat:@"%.0f",[textField.text floatValue]*10] ;
    }
}

- (NSMutableArray *)listArr{
    if (!_listArr) {
        _listArr = [[NSMutableArray alloc]init];
    }
    return _listArr;
}

- (IWantMenuView *)menuView{
    if (_menuView == nil) {
        _menuView = [IWantMenuView initBaseView];
    }
    return _menuView;
}

- (IBAction)base_ButtonsClick:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
        {
            
        }
            break;
        case 1:
        {
            
        }
            break;
        case 2:
        {
            WeakSelf
            
            weakSelf.pswView = [WPswView initBaseView];
            weakSelf.pswView.frame = self.bounds;
            
            [weakSelf addSubview:weakSelf.pswView];
            weakSelf.pswView.base_BlockIdx = ^(NSInteger index){
                
                weakSelf.pay_password = weakSelf.pswView.WPswtext.text;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    [weakSelf commintURL:weakSelf.pay_password];//提交订单接口
                    
                });
            };
            
            
        }
            break;
        case 3:
        {
            //取消
            [self baseXIB_removeSubView];
        }
            
            break;
        case 4:
        {
            //付款吗返回
            self.bgCodeView.hidden = YES;
        }
            
            break;
        default:
            break;
    }
}


- (void)commintURL:(NSString *)pw{
    
    [KSRequestManager postRequestWithUrlString:@"api/user.php?act=offline_pay" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"shoper_id":_store_id,@"pay_integral":_integral.text,@"shop_id":_shoper_id,@"rlbl":@"16",@"goods_name":_goodsNameField.text,@"price":_priceField.text,@"pay_password":pw} success:^(id responseObject) {
        
        [self.pswView removeFrom];
        [self baseXIB_removeSubView];
        
        [MBProgressHUD showSuccessMessage:@"支付成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //积分支付
            MyOrderListVC *myOder= [MyOrderListVC new];
            myOder.isFlog = YES;
            [_vc.navigationController pushViewController:myOder animated:YES];
        });
        
        
    } failure:^(id error) {
        
    }];
    
}
@end
