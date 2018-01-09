//
//  PointsRedemptionVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
// user_id 836 837 862 6423

#import "PointsRedemptionVC.h"
#import "ManagePointsVC.h"
#import <AFHTTPSessionManager.h>
#import "SFPaymentView.h"
#import "WPswView.h"
#import "IntegralManagementVC.h"


@interface PointsRedemptionVC ()<UITextFieldDelegate>
{
    __block SFPaymentView *payAlert;
    NSString *pay_password;
}
@property (nonatomic,strong) NSMutableArray *shopsArr ;
@property (nonatomic,strong) NSString *shop_id;

//支付弹框
@property (nonatomic,strong) WPswView *pswView;

@end

@implementation PointsRedemptionVC

#pragma mark 懒加载


#pragma mark 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"积分换购";
    [self selfInitUI];
    [self AFManagerDragon_requestData];
    _moneyTF.delegate = self;
}

#pragma mark 加载UI
/*! 布局UI */
- (void)selfInitUI{

    [[WHC_KeyboardManager share] addMonitorViewController:self];
    
    /** 由于键盘在wiond 上 需要单独处理*/
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
//    self.tableView.delegate = self;
//    self.tableView.dataSource = self;
//    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
//        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
//    }
//    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _canUseCode.titleLabel.adjustsFontSizeToFitWidth = YES;
    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{

}


/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    
    [KSRequestManager postRequestWithUrlString:URL_getCanUseCode parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        
        NSLog(@"------(%@)-----",responseObject) ;
        NSString *sss = [NSString stringWithFormat:@"%@",responseObject[@"points"]];
        if (sss.length == 0) {
            [_canUseCode setTitle:@"0.00" forState:(UIControlStateNormal)];
        }else{
            
            [_canUseCode setTitle:KSDIC(responseObject, @"points") forState:(UIControlStateNormal)];
        }
        
        NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
        _shopnameTF.text = [uuu objectForKey:@"mimeGoodName"];
    } failure:^(id error) {
        
    }];
}

#pragma mark 代理方法回调
- (void)textFieldDidEndEditing:(UITextField *)textField{
    _codeTF.text = [NSString stringWithFormat:@"%.2f",[textField.text floatValue]*10];
}

#pragma mark 点击事件
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}
//提交订单按钮
- (IBAction)commintBtn:(id)sender {
    if (_shopsTF.text.length == 0 || _shopnameTF.text.length == 0 || _chooseshopLab.text.length == 0 || _moneyTF.text.length == 0) {
        [MBProgressHUD showErrorMessage:@"请先完善信息"];
        return;
    }
    //添加支付弹框
//    [self setPayMoney:_moneyTF.text];
    
    NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
    [uuu setObject:_shopnameTF.text forKey:@"mimeGoodName"];
    
    WeakSelf
    
    weakSelf.pswView = [WPswView initBaseView];
    weakSelf.pswView.frame = self.view.bounds;
    
    [weakSelf.view addSubview:weakSelf.pswView];
    weakSelf.pswView.base_BlockIdx = ^(NSInteger index){
        
        pay_password = weakSelf.pswView.WPswtext.text;
        
        [weakSelf.pswView removeFrom];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [weakSelf commintURL:pay_password];//提交订单接口
            
        });
    };
    
}
//- (void)setPayMoney:(NSString *)money{
//    
//    payAlert = [[SFPaymentView alloc]init];
//    payAlert.title = @"请输入支付密码";
//    payAlert.detail = @"支付金额";
//    payAlert.amount= [money floatValue];
//    [payAlert show];
//    
//    __weak __typeof(self) weakSelf = self ;
//    payAlert.completeHandle = ^(NSString *inputPwd,UITextField *pwTF) {
//        [weakSelf commintURL:inputPwd];//提交订单接口
//    };
//}
- (void)commintURL:(NSString *)pw{
    [KSRequestManager postRequestWithUrlString:URL_codeRedemption parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"shop_id":_shop_id,@"goods_name":_shopnameTF.text,@"price":_moneyTF.text,@"pay_password":pw} success:^(id responseObject) {
        
        NSLog(@"------(%@)-----",responseObject) ;
        [MBProgressHUD showSuccessMessage:@"提交成功，等待审核"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(id error) {
//        NSLog(@"密码错误");
//        [self setTanKuang];
    }];
}
//- (void)setTanKuang{
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码错误" preferredStyle:(UIAlertControllerStyleAlert)];
//    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"忘记密码" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
//    }];
//    UIAlertAction *maketure = [UIAlertAction actionWithTitle:@"重新输入" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
//        
//        //添加支付弹框
//        [self setPayMoney:_moneyTF.text];
//        
//    }];
//    [alert addAction:cancle];
//    [alert addAction:maketure];
//    [self.navigationController presentViewController:alert animated:YES completion:nil];
//}
//确认商家账号按钮
- (IBAction)searchBtn:(id)sender {
    
    if (_shopsTF.text.length == 0) {
        [MBProgressHUD showSuccessMessage:@"请先输入商家账号"];
        return;
    }
    
    [KSRequestManager postRequestWithUrlString:URL_shopsList parameter:@{@"username":_shopsTF.text} success:^(id responseObject) {
        
        [MBProgressHUD showSuccessMessage:@"查询成功"];
        _shopsArr = [[NSMutableArray alloc]initWithArray:responseObject[@"shops"]];
        
        if (_shopsArr.count > 0) {
            
            _chooseshopLab.text = _shopsArr[0][@"shop_name"];
            _nameTF.text = [NSString stringWithFormat:@"%@ %@",_shopsArr[0][@"linkman"],_shopsArr[0][@"mobile"]] ;
            _shop_id = _shopsArr[0][@"id"];
        }
        
    } failure:^(id error) {
        
    }];
}
//点击选择店铺按钮
- (IBAction)chooseShops:(id)sender {
    
    if (_shopsTF.text.length == 0) {
        [MBProgressHUD showSuccessMessage:@"请先输入商家账号"];
        return;
    }

    [KSRequestManager postRequestWithUrlString:@"api/shops.php?act=get_user_shops" parameter:@{@"username":_shopsTF.text} success:^(id responseObject) {
        
        _shopsArr = [[NSMutableArray alloc]initWithArray:responseObject[@"shops"]];
        if (_shopsArr.count == 0) {
            [MBProgressHUD showErrorMessage:@"该商家下暂无店铺"];
            return;
        }
        [self shopsBounces];
        
    } failure:^(id error) {
        
    }];
    
}
- (void)shopsBounces{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:@"店铺列表" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    for (int i = 0; i < self.shopsArr.count; i++) {
        
        UIAlertAction *maketure = [UIAlertAction actionWithTitle:self.shopsArr[i][@"shop_name"] style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
            _chooseshopLab.text = _shopsArr[i][@"shop_name"];
            _nameTF.text = [NSString stringWithFormat:@"%@ %@",_shopsArr[i][@"linkman"],_shopsArr[i][@"mobile"]] ;
//            _phonenumTF.text = _shopsArr[i][@"mobile"];
            _shop_id = _shopsArr[i][@"id"];
            
        }];
        [alert addAction:maketure];
    }
    
    [alert addAction:cancle];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
}

#pragma mark 工具方法


#pragma mark - 键盘监听处理 -
- (void)keyboardWillShow:(NSNotification *)notify {
    
    CGRect _keyboardFrame;
    NSDictionary * userInfo = notify.userInfo;
    _keyboardFrame = ((NSValue *)userInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    
    CGFloat y = Screen_heigth - (CGRectGetMaxY(_bottomView.frame));
    
    CGFloat keyBoadrH = CGRectGetHeight(_keyboardFrame);
    
    if (keyBoadrH > y) {
        self.view.frame = CGRectMake(0, -(keyBoadrH -y)-44, Screen_wide, Screen_heigth);
        
    }
}


- (void)keyboardWillHide:(NSNotification *)notify {
    
    self.view.frame = CGRectMake(0, 0, Screen_wide, Screen_heigth);
}


//#pragma mark tableview
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    return _shopsArr.count;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return Screen_heigth/667*44;
//}
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"cell"];
//    }
//    cell.textLabel.font = [UIFont systemFontOfSize:14];
//    
//    cell.textLabel.text = self.shopsArr[indexPath.row][@"shop_name"];
//    return cell;
//}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self.tableView setHidden:YES];
//    _chooseshopLab.text = _shopsArr[indexPath.row][@"shop_name"];
//    _nameTF.text = _shopsArr[indexPath.row][@"linkman"];
//    _phonenumTF.text = _shopsArr[indexPath.row][@"mobile"];
//    _shop_id = _shopsArr[indexPath.row][@"id"];
//
//}
@end
