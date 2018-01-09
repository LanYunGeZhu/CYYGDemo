//
//  WRechargeVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WRechargeVC.h"
#import "WBuyTypeCell.h"
#import "RechargeRecordVC.h"
#import "WPayView.h"
#import "WebVC.h"
#import "MyOrderListVC.h"

static NSString *kCellID = @"cellID";
@interface WRechargeVC ()<UITableViewDelegate,UITableViewDataSource,TouchDelegate>
{
    NSArray *ItemArr;
}

@property (nonatomic,strong) WPayView *payView;
@property (nonatomic,assign) int counti ;
@property (nonatomic,strong) NSTimer *ttt ;
@end

@implementation WRechargeVC

- (void)viewDidLoad {
    [super viewDidLoad];

    _paytype = @"alipay";
    [self initData];
    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getPayResult) name:@"getPayResult3" object:nil];
}
- (void)getPayResult{
    _ttt = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(aaa) userInfo:nil repeats:YES];
}
- (void)aaa{
    _counti += 1;
    
    //获取支付结果
    [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=ck_recharge" parameter:@{@"ordersn":self.ordersn} success:^(id responseObject) {
        
        if ([responseObject[@"ispaid"] integerValue] == 1) {//支付成功
            
            [self.ttt invalidate];
            
            [MBProgressHUD showSuccessMessage:@"充值成功"];
            //跳到充值记录列表
            RechargeRecordVC *myOder= [RechargeRecordVC new];
            [self.navigationController pushViewController:myOder animated:YES];
            
        }else{
            if (_counti > 20) {
                [MBProgressHUD showSuccessMessage:@"充值失败"];
                [self.ttt invalidate];
            }
        }
        
    } failure:^(id error) {
        
    }];

}


- (void)initData
{
    [self.RecharTab registerNib:[UINib nibWithNibName:@"WBuyTypeCell" bundle:nil] forCellReuseIdentifier:kCellID];
    
    self.RecharTab.toucDelegate = self;
    
    NSArray *imageS = @[@"支付宝",@"微信",@"图层 5"];
    NSArray *topS = @[@"支付宝支付",@"微信支付",@"快钱支付"];
    NSArray *dowS = @[@"支持有支付宝和网银的用户使用",@"使用微信支付安全便捷",@"使用快钱支付安全便捷"];
    
    ItemArr = @[imageS,topS,dowS];
    
    [self setRightWithImage:@"更多(7)" action:@selector(clickToRecord)];
    
    _payView = [WPayView initBaseView];
    
    _payView.frame = CGRectMake(0, 0, Screen_wide, 200);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.RecharTab.tableFooterView = _payView;
        
    });
    
    __weak __typeof(self) weakSelf = self ;
    _payView.base_BlockIdx = ^(NSInteger index)
    {
        if (_RecharGeTf.text.length == 0) {
            [MBProgressHUD showSuccessMessage:@"请输入金额"];
            return;
        }
        switch (index) {
            case 0:
            {
                NSLog(@"确认支付");
                [KSRequestManager postRequestWithUrlString:@"api/user.php?act=rechargedo" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"amount":weakSelf.RecharGeTf.text,@"ptype":@"0",@"paytype":weakSelf.paytype} success:^(id responseObject) {
                    
                    NSLog(@"------(%@)-----",responseObject) ;
                    //支付订单号
                    weakSelf.ordersn = responseObject[@"ordersn"];
                    
                    NSString *textURL;
                    if ([weakSelf.paytype isEqualToString:@"alipay"]) {//支付宝支付
                        textURL = responseObject[@"qr_code"];
                    }else if ([weakSelf.paytype isEqualToString:@"99bill"]){//快钱支付
                        textURL = responseObject[@"to_url"];
                    }else{
                        WebVC * vc = [[WebVC alloc]init];
                        vc.imgurl = responseObject[@"imgurl"];
                        vc.ordersn = weakSelf.ordersn;
                        vc.mark = 3;
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
                    
                    //跳到充值记录列表
                    RechargeRecordVC *myOder= [RechargeRecordVC new];
                    [weakSelf.navigationController pushViewController:myOder animated:YES];
                    
                    NSUserDefaults *uuu = [NSUserDefaults standardUserDefaults];
                    [uuu setObject:@"1" forKey:@"vcShow"];
                    [uuu setObject:@"WRechargeVC" forKey:@"vc"];
                    [uuu synchronize];
                    
                    NSURL *cleanURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@", textURL]];
                    [[UIApplication sharedApplication] openURL:cleanURL];
                    
                    
                } failure:^(id error) {
                    
                }];
            }
                break;
                
            default:
                break;
        }
    };

    
    self.title = @"现金充值";
    
}

- (void)WPayRequest
{
    [KSRequestManager postRequestWithUrlString:URL_appgetBank parameter:@{} success:^(id responseObject) {
        
        
        
    } failure:^(id error) {
        
    }];
}

- (void)clickToRecord
{
    RechargeRecordVC *Vc = [RechargeRecordVC new];
    
    [self.navigationController pushViewController:Vc animated:YES];
}

- (void)tableView:(UITableView *)tableView touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBuyTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.typeImage.image = [UIImage imageNamed:ItemArr[0][indexPath.row]];
    cell.wTopLa.text = ItemArr[1][indexPath.row];
    cell.dowLa.text = ItemArr[2][indexPath.row];
    if(indexPath.row == 0) cell.iconBt.selected = YES;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [ItemArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        WBuyTypeCell *Cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0]];
        
        if (indexPath.row == idx)
        {
            Cell.iconBt.selected = YES;
        }
        else
        {
            Cell.iconBt.selected = NO;
        }
        if (indexPath.row == 0) {
            _paytype = @"alipay";
        }else if (indexPath.row == 1) {
            _paytype = @"wxpay";
        }else{
            _paytype = @"99bill";
        }
        
    }];
}

@end
