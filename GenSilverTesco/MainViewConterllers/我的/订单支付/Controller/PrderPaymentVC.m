//
//  PrderPaymentVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PrderPaymentVC.h"
#import "PayHeadeInfoCell.h"
#import "PayTypeList.h"
#import "PayTypeListModel.h"
#import "ShoppingCartVC.h"
#import "GoodsDetailsVC.h"
#import "WebVC.h"
#import "MyOrderListVC.h"
#import "WPswView.h"

@interface PrderPaymentVC ()

//支付弹框
@property (nonatomic,strong) WPswView *pswView;
@property (nonatomic,strong) NSString *pay_password ;

@property (strong, nonatomic) NSArray *itmesArray;
@property (assign, nonatomic) NSInteger seleced_Index;
@property (assign, nonatomic) BOOL isFlog;

@property (strong, nonatomic)NSString *pay_points;

@property (nonatomic,strong) NSString *ordersn ;

@end

@implementation PrderPaymentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSArray *images;NSArray *topS;NSArray *dowS;
    if (_mark == 1) {
        
        self.pay_points = @"余额支付(剩余0.00)";
        images = @[@"我的余额",@"支付宝",@"微信",@"图层 5"];
        topS = @[@"积分支付",@"支付宝支付",@"微信支付",@"快钱支付"];
        dowS = @[@"积分支付安全便捷",@"支持有支付宝和网银的用户使用",@"使用微信支付安全便捷",@"使用快钱支付安全便捷"];
    }else{
        
        images = @[@"支付宝",@"微信",@"图层 5"];
        topS = @[@"支付宝支付",@"微信支付",@"快钱支付"];
        dowS = @[@"支持有支付宝和网银的用户使用",@"使用微信支付安全便捷",@"使用快钱支付安全便捷"];
        
    }
    self.itmesArray = @[images,topS,dowS];
    self.seleced_Index = 1;
    if (_mark == 1) {
        [self loadRequsetData];
    }
    self.title = @"支付订单";
    
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPayResult) name:@"getPayResult1" object:nil];
}
//- (void)getPayResult{
//    //获取支付结果
//    [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=ck_recharge" parameter:@{@"ordersn":self.ordersn} success:^(id responseObject) {
//        
//        if ([responseObject[@"ispaid"] isEqual:@"1"]) {//支付成功
//            [MBProgressHUD showSuccessMessage:@"支付成功"];
//        }else{
//            [MBProgressHUD showSuccessMessage:@"支付失败"];
//        }
//        
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            
//            //跳到订单列表
//            MyOrderListVC *myOder= [MyOrderListVC new];
//            if (_mark == 1) {
//                myOder.isFlog = YES;
//            }else{
//                myOder.index = 0;
//            }
//            [self.navigationController pushViewController:myOder animated:YES];
//            
//        });
//        
//        
//    } failure:^(id error) {
//        
//    }];
//}


- (void)goBack{
   __block UIViewController *goBackColler;
    dispatch_group_t group = dispatch_group_create();
    [self.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_enter(group);
        if ([obj isKindOfClass:[ShoppingCartVC class]] || [obj isKindOfClass:[GoodsDetailsVC class]]) {
            goBackColler = obj;
            * stop = YES;
        }
        dispatch_group_leave(group);

    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (goBackColler) {
            [self.navigationController popToViewController:goBackColler animated:YES];
        }else{
            [super goBack];
        }
    });
}

- (void)initTableView{
    [self registerTableVieCellsArray:@[@"PayHeadeInfoCell",@"PayTypeList"]];
}

- (void)loadRequsetData{
    //获取可用余额
    [KSRequestManager postRequestWithUrlString:URL_appinfomation parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        self.pay_points  = [NSString stringWithFormat:@"余额支付(剩余%@)",responseObject[@"user"][@"pay_points"]];
        [self.myTableView reloadData];
    } failure:^(id error) {
        
    }];
}

- (void)addItmesData{

    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_mark == 1) {
      return section == 0 ? 1: 5;
    }
    return section == 0 ? 1: 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        PayHeadeInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PayHeadeInfoCell" forIndexPath:indexPath];
        if (_mark == 1) {
            NSArray *arr3 = [self.data componentsSeparatedByString:@" "];
            cell.price.text = arr3[7];
        }else{
            
            cell.price.text =[NSString stringWithFormat:@"%@",KSDIC(_data, @"order_amount")];
        }
        return cell;
    }else
    {
        PayTypeList *cell = [tableView dequeueReusableCellWithIdentifier:@"PayTypeList" forIndexPath:indexPath];
    
        
        if (indexPath.row == 0) {
            [cell viewHidden:@[cell.iocImageView,cell.title,cell.context,cell.seleced_button]];
            cell.title1.hidden = NO;
        }else{
            [cell viewShow:@[cell.iocImageView,cell.title,cell.context,cell.seleced_button]];
            cell.title1.hidden = YES;
            cell.iocImageView.image = [UIImage imageNamed:self.itmesArray[0][indexPath.row- 1]];
            cell.title.text = _itmesArray[1][indexPath.row - 1];
            cell.context.text = _itmesArray[2][indexPath.row - 1];
            if(indexPath.row == _seleced_Index) cell.seleced_button.selected = YES;
        }
        return cell;
    }

}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            return;
        }
        if (_isFlog == NO) {
            PayTypeList *cell1 = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
            cell1.seleced_button.selected = NO;
            
        }
        _seleced_Index = indexPath.row;
        PayTypeList *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.seleced_button.selected = YES;
        _isFlog = YES;
    
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row !=0) {
            PayTypeList *cell = [tableView cellForRowAtIndexPath:indexPath];
            cell.seleced_button.selected = NO;
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ? 80 : 51;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 16;
}

- (IBAction)immediatePayment:(id)sender{
    
    NSArray *arr = @[@"alipay",@"wxpay",@"99bill"];
    if (_mark == 1) {
        //二维码里面的内容:店铺id 商家id 商品名称 积分让利比 现金让利比 店铺名称 金额 支付积分
        NSArray *arr3 = [self.data componentsSeparatedByString:@" "];
        NSString *paytype;NSDictionary *params;
        if (_seleced_Index > 1) {
            paytype= arr[_seleced_Index-2];
            params = @{@"user_id":[UserInfoManager sharedManager].user_id,@"shoper_id":arr3[2],@"pay_money":arr3[7],@"shop_id":arr3[1],@"rlbl":arr3[5],@"goods_name":arr3[3],@"price":arr3[7],@"paytype":paytype};
            
            [KSRequestManager postRequestWithUrlString:@"api/user.php?act=offline_pay" parameter:params success:^(id responseObject) {
                
                NSLog(@"------(%@)-----",responseObject) ;
                //支付订单号
                self.ordersn = responseObject[@"ordersn"];
                
                //跳到支付网页
                NSString *textURL;
                if (_seleced_Index == 3) {
                    WebVC * vc = [[WebVC alloc]init];
                    vc.imgurl = responseObject[@"img"];
                    vc.ordersn = self.ordersn;
                    vc.mark = self.mark;
                    [self.navigationController pushViewController:vc animated:YES];
                    return ;
                }else if (_seleced_Index == 2) {//支付宝支付
                    textURL = responseObject[@"qr_code"];
                    
                }else if (_seleced_Index == 4){//快钱支付
                    textURL = responseObject[@"img"];
                }
                
                //跳到订单列表
                MyOrderListVC *myOder= [MyOrderListVC new];
                myOder.isFlog = YES;
                [self.navigationController pushViewController:myOder animated:YES];
                
                NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
                [uuu setObject:@"1" forKey:@"vcShow"];
                [uuu setObject:@"PrderPaymentVC" forKey:@"vc"];
                [uuu synchronize];
                
                NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
                [[UIApplication sharedApplication] openURL:cleanURL];
                
                
                
            } failure:^(id error) {
                
            }];

            
        }else{
            
            WeakSelf
            
            weakSelf.pswView = [WPswView initBaseView];
            weakSelf.pswView.frame = self.view.bounds;
            
            [weakSelf.view addSubview:weakSelf.pswView];
            weakSelf.pswView.base_BlockIdx = ^(NSInteger index){
                
                weakSelf.pay_password = weakSelf.pswView.WPswtext.text;
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    NSDictionary * param = @{@"user_id":[UserInfoManager sharedManager].user_id,@"shoper_id":arr3[2],@"pay_integral":arr3[8],@"shop_id":arr3[1],@"rlbl":arr3[4],@"goods_name":arr3[3],@"price":arr3[7],@"pay_password":weakSelf.pay_password};
                    [weakSelf commintURL:param];//提交订单接口
                    
                });
            };

        }
        
    }else{
        
        [KSRequestManager postRequestWithUrlString:URL_order_pay parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"order_id":(NSString *)_data[@"order_id"],@"cash":(NSString *)_data[@"order_amount"],@"paytype":arr[_seleced_Index-1]} success:^(id responseObject) {
            
            NSLog(@"------(%@)-----",responseObject) ;
            //支付订单号
            self.ordersn = responseObject[@"ordersn"];
            
            NSString *textURL;
            if (_seleced_Index == 1) {//支付宝支付
                textURL = responseObject[@"qr_code"];
            }else if (_seleced_Index == 3){//快钱支付
                textURL = responseObject[@"img"];
            }else{
                WebVC * vc = [[WebVC alloc]init];
                vc.imgurl = responseObject[@"img"];
                [self.navigationController pushViewController:vc animated:YES];
                return ;
            }
            
            //跳到订单列表
            MyOrderListVC *myOder= [MyOrderListVC new];
            myOder.index = 0;
            [self.navigationController pushViewController:myOder animated:YES];
            
            NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
            [uuu setObject:@"1" forKey:@"vcShow"];
            [uuu setObject:@"PrderPaymentVC" forKey:@"vc"];
            [uuu synchronize];
            
            NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
            [[UIApplication sharedApplication] openURL:cleanURL];
            
            
        } failure:^(id error) {
            
        }];
    }

 
}


- (void)commintURL:(NSDictionary *)paramsDic{
    
    [KSRequestManager postRequestWithUrlString:@"api/user.php?act=offline_pay" parameter:paramsDic success:^(id responseObject) {
        
        NSLog(@"------(%@)-----",responseObject) ;
        [self.pswView removeFrom];

        [MBProgressHUD showSuccessMessage:@"支付成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            //跳到订单列表
            MyOrderListVC *myOder= [MyOrderListVC new];
            myOder.isFlog = YES;
            [self.navigationController pushViewController:myOder animated:YES];
        });
        
        
    } failure:^(id error) {
        
    }];

}
@end
