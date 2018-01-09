//
//  QRCodeResultView.m
//  GenSilverTesco
//
//  Created by MrSong on 17/8/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "QRCodeResultView.h"
#import "PrderPaymentVC.h"

@implementation QRCodeResultView

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.startGathering.layer setCornerRadius:8];
    [self.startGathering.layer setMasksToBounds:YES];
    [self.bgView.layer setCornerRadius:4];
    [self.bgView.layer setMasksToBounds:YES];
    self.priceField.delegate = self;
    
    
    
}
- (void)drawRect:(CGRect)rect{
    NSArray *arr = [self.data componentsSeparatedByString:@" "];
    if (arr.count > 0) {
        self.storeName.text = arr[6];
        if ([arr[3] isEqualToString:@"未填写"]) {
            self.goodsNameField.userInteractionEnabled = YES;
        }else{
            self.goodsNameField.userInteractionEnabled = NO;
            self.goodsNameField.text = arr[3];
        }
        self.bili1.text = [NSString stringWithFormat:@"%@%%",arr[4]] ;
        self.bili2.text = [NSString stringWithFormat:@"%@%%",arr[5]] ;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        textField.placeholder = @"请输入收款金额";
    }else{
        _integral.text = [NSString stringWithFormat:@"%.0f",[textField.text floatValue]*10] ;
    }
}

- (IBAction)base_ButtonsClick:(UIButton *)sender{
    switch (sender.tag) {
        case 1://确定支付按钮
        {
            if (_priceField.text.length == 0) {
                [MBProgressHUD showSuccessMessage:@"请输入消费金额"];
                return;
            }
            if (_goodsNameField.text.length == 0) {
                [MBProgressHUD showSuccessMessage:@"请输入商品名称"];
                return;
            }
            
            //跳转到支付页面
            NSString *newData = [NSString stringWithFormat:@"%@ %@ %@",self.data,_priceField.text,_integral.text];
            PrderPaymentVC * prode = [PrderPaymentVC new];
            prode.data = newData;
            prode.mark = 1;
            [[KSTabBarController gitNavigationController ] pushViewController:prode animated:YES];
            
            
            [self baseXIB_removeSubView];
        }
            break;
        case 2:
        {
            //取消
            [self baseXIB_removeSubView];
        }
            
            break;
      
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.priceField resignFirstResponder];
    [self.goodsNameField resignFirstResponder];
}

@end
