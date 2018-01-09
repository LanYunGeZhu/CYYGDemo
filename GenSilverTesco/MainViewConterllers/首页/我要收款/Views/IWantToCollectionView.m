//
//  IWantToCollectionView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "IWantToCollectionView.h"
#import "IWantMenuView.h"
#import "UIImage+Add.h"
@implementation IWantToCollectionView

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
            WeakSelf
            //选择店铺名称
            if (_menuView == nil) {
                [self.bgView addSubview:self.menuView];
            }
            self.menuView.frame = CGRectMake(self.storeName.frame.origin.x, CGRectGetMaxY(self.storeName.frame) +KS_H(44), CGRectGetWidth(self.storeName.frame), self.bgView.frame.size.height - CGRectGetMaxY(self.storeName.frame) -KS_H(44));
            self.menuView.flag = 1;
            self.menuView.listArr = [[NSMutableArray alloc]initWithArray:_listArr];
            [self.menuView.myTableView reloadData];
            self.menuView.base_BlockIdx = ^(NSInteger index){
                weakSelf.storeName.text = weakSelf.listArr[index][@"shop_name"];
                weakSelf.shoper_id = weakSelf.listArr[index][@"id"];
                [weakSelf.menuView removeFromSuperview];
                weakSelf.menuView = nil;
            };
            [self.menuView registerCell];
           
        }
            break;
        case 1:
        {
            WeakSelf
            if (_menuView == nil) {
                [self.bgView addSubview:self.menuView];
            }
            //选择返利比例
            self.menuView.frame = CGRectMake(self.integral.frame.origin.x, CGRectGetMaxY(self.integral.frame) +(KS_H(44) *4), CGRectGetWidth(self.integral.frame), 80);
            self.menuView.flag = 2;
            self.menuView.listArr = [[NSMutableArray alloc]initWithArray:@[@{@"bili":@"A模式-10%"},@{@"bili":@"B模式-20%"}]];
            [self.menuView.myTableView reloadData];
            self.menuView.base_BlockIdx = ^(NSInteger index){
                weakSelf.benefit.text = weakSelf.menuView.listArr[index][@"bili"];
                [weakSelf.menuView removeFromSuperview];
                weakSelf.menuView = nil;
            };
            [self.menuView registerCell];
          
        }
            break;
        case 2:
        {
            if (_priceField.text.length == 0) {
                [MBProgressHUD showSuccessMessage:@"请输入金额"];
                return;
            }
            if (_goodsNameField.text.length == 0) {
                [MBProgressHUD showSuccessMessage:@"请输入商品名"];
                return;
            }
            if (_storeName.text.length == 0) {
                [MBProgressHUD showSuccessMessage:@"请选择店铺"];
                return;
            }
            
            NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
            [uuu setObject:_goodsNameField.text forKey:@"homeGoodName"];
            
            //确定
            self.bgCodeView.hidden = NO;
            //二维码里面的内容:C1 店铺id 金额 商家id 商品名称 积分 店铺名称,(C1我要收款二维码 C2店铺制作二维码)
            NSString *sss = [NSString stringWithFormat:@"C1 %@ %@ %@ %@ %@ %@",_shoper_id,_priceField.text,[UserInfoManager sharedManager].user_id,_goodsNameField.text,_integral.text,_storeName.text];
            UIImage * newImage = [UIImage getQrImageString:sss  Size:162 withRed:0 Green:0 Blue:0];
            self.codeImageView.image  = newImage;
            
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


@end
