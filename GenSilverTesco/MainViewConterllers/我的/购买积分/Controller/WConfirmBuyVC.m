//
//  WConfirmBuyVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WConfirmBuyVC.h"
#import "WBuyTypeCell.h"
#import "WPayView.h"
#import "UILabel+Kiwi.h"
#import "WebVC.h"

static NSString *kCellID = @"cellID";



@interface WConfirmBuyVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *ItemArr;
}
@property (nonatomic,strong) WPayView *payView;
@property (nonatomic,strong) NSString * paytype;

@end

@implementation WConfirmBuyVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
}

- (void)initData
{
    [self.MyTab registerNib:[UINib nibWithNibName:@"WBuyTypeCell" bundle:nil] forCellReuseIdentifier:kCellID];
    NSArray *imageS = @[@"支付宝",@"微信",@"图层 5"];
    NSArray *topS = @[@"支付宝支付",@"微信支付",@"快钱支付"];
    NSArray *dowS = @[@"支持有支付宝和网银的用户使用",@"使用微信支付安全便捷",@"使用块钱支付安全便捷"];
    self.scoreLa.text = StringWithStr(@"购买积分:",self.score);
    [self.moneyLa WSetMutibleColorWithPay:StringWithStr(@"支付金额:", StringWithStr(self.shopMoney, @"元"))];
    ItemArr = @[imageS,topS,dowS];
    _payView = [WPayView initBaseView];
    _payView.frame = CGRectMake(0, 0, Screen_wide, 200);
    dispatch_async(dispatch_get_main_queue(), ^{
        self.MyTab.tableFooterView = _payView;
    });
    self.title = @"确认支付";
    ;
    __weak __typeof(self) weakSelf = self ;
    _payView.base_BlockIdx = ^(NSInteger index)
    {
        switch (index) {
            case 0:
            {
                NSLog(@"确认支付");
                [KSRequestManager postRequestWithUrlString:@"api/user.php?act=rechargedo" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"amount":weakSelf.shopMoney,@"ptype":@"0",@"paytype":weakSelf.paytype} success:^(id responseObject) {
                    NSString *textURL;
                    if ([weakSelf.paytype isEqualToString:@"alipay"]) {//支付宝支付
                        textURL = responseObject[@"qr_code"];
                    }else if ([weakSelf.paytype isEqualToString:@"99bill"]){//快钱支付
                        textURL = responseObject[@"to_url"];
                    }else{
                        WebVC * vc = [[WebVC alloc]init];
                        vc.imgurl = responseObject[@"imgurl"];
                        [weakSelf.navigationController pushViewController:vc animated:YES];
                    }
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
