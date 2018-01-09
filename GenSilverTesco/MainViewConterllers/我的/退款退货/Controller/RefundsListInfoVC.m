//
//  RefundsListInfoVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RefundsListInfoVC.h"
#import "OrderOnlineListCell.h"
#import "RefundsListHeadeView.h"
#import "RefundsInfoCell.h"
#import "RefundsTitleContexCell.h"
#import "RefundsListModel.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "EaseMessageViewController.h"

@interface RefundsListInfoVC ()

@property (strong, nonatomic) RefundsListHeadeView *headeView;

@property (nonatomic,strong) NSMutableDictionary *dataDic ;

@property (nonatomic,strong) NSMutableArray *goodArr ;

@end

@implementation RefundsListInfoVC

- (RefundsListHeadeView *)headeView{
    if (_headeView == nil) {
        _headeView = [RefundsListHeadeView initBaseView];
        _headeView.frame = CGRectMake(0, 0, Screen_wide, 50.0f);
        _headeView.statusButton.hidden = YES;
        _headeView.data = _status;
        
        _headeView.contactTheSeller.tag = [_back_id floatValue];
        [_headeView.contactTheSeller addTarget:self action:@selector(contactBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return  _headeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadRequsetData];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_orders_reback_detail parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"back_id":_back_id} success:^(id responseObject) {
        
        NSLog(@"---%@",responseObject);
        self.dataDic = [[NSMutableDictionary alloc]initWithDictionary:responseObject[@"order"]];
        
        self.goodArr = [[NSMutableArray alloc]initWithArray:responseObject[@"goods"]];
        
        RefundsListModel *model = [[RefundsListModel alloc]init];
        model.describe = responseObject[@"order"][@"back_reason"];
        [self.datasMutabArray addObject:model];
        
        [self.myTableView reloadData];
        
        
        //时间参数
        NSString*str = KSDIC(self.dataDic, @"update_time");
        if ([str integerValue] == 0) {
            return ;
        }
        NSTimeInterval time = [str doubleValue];
        NSDate*detaildate = [NSDate dateWithTimeIntervalSince1970:time];
        NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
        [formatter setTimeZone:[NSTimeZone localTimeZone]];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        NSString *timestr = [formatter stringFromDate:detaildate];
        _headeView.timer.text = timestr;
        
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    self.title = @"退款详情";
    [self registerTableVieCellsArray:@[@"RefundsTitleContexCell",@"OrderOnlineListCell"]];
    [self.myTableView registerClass:[RefundsInfoCell class] forCellReuseIdentifier:@"RefundsInfoCell"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.myTableView.tableHeaderView = self.headeView;
    });
    
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.goodArr.count + 2;
    }
    return 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row ==1) {
            RefundsTitleContexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundsTitleContexCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            cell.nameLable.text = indexPath.row == 0 ? @"退款金额":@"退款编号";
            cell.contextLable.text = indexPath.row == 0 ? KSDIC(self.dataDic, @"refund_money_1") : KSDIC(self.dataDic, @"back_id");
            
            return cell;
        }
        else{
            OrderOnlineListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderOnlineListCell" forIndexPath:indexPath];
            
            RefundsListModel *model = _receiveArr[indexPath.row-2];//商品数量
            NSDictionary *dic = _goodArr[indexPath.row - 2];
            
            cell.goods_name.text = KSDIC(dic, @"goods_name");
            cell.goods_num.text = [NSString stringWithFormat:@"x%ld",(long)[model.back_goods_number integerValue]];
            cell.goods_property.text = KSDIC(dic, @"goods_attr");
            cell.goods_price.text = [NSString stringWithFormat:@"￥%@",KSDIC(dic, @"back_goods_price")];
            [cell.icoImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(dic, @"goods_thumb")]] placeholderImage:KSPLAIMAGE];
            
            return cell;
        }

    }else{
        if (indexPath.row ==0) {
            RefundsTitleContexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundsTitleContexCell" forIndexPath:indexPath];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.nameLable.text = @"申请时间";
            NSString*str = KSDIC(self.dataDic, @"add_time");
            NSTimeInterval time = [str doubleValue];
            NSDate*detaildate = [NSDate dateWithTimeIntervalSince1970:time];
            NSDateFormatter*formatter = [[NSDateFormatter alloc]init];
            [formatter setTimeZone:[NSTimeZone localTimeZone]];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *timestr = [formatter stringFromDate:detaildate];

            cell.contextLable.text = timestr;
            return cell;
            
        }else{
            
            RefundsInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RefundsInfoCell" forIndexPath:indexPath];
            
            if (self.datasMutabArray.count > 0) {
                
                cell.model = self.datasMutabArray[0];
            }
            
            return cell;
        }
    }
   
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row ==1) {
            return 44;
        }
        return 91.0f;
    }else{
        if (indexPath.row == 0) {
            return 44;
        }
        if (self.datasMutabArray.count > 0) {
            
            RefundsListModel * model=  self.datasMutabArray[0];
            
            float flo = [self.myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RefundsInfoCell class] contentViewWidth:[self cellContentViewWith]];
            
            return flo;
        }
        return 0.1;
    }
  
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


- (void)contactBtn:(UIButton *)btn{
    
    if ([self.status integerValue] == 6) {//申请被拒绝
        
        //联系卖家
        EaseMessageViewController * chatController = [[EaseMessageViewController alloc]initWithConversationChatter:@"ljjxiaomi20170327" conversationType:EMConversationTypeChat];
        chatController.title = @"App客服" ;
        
        [self.navigationController pushViewController:chatController animated:YES];
        
    }else{
        
        //取消退款
        [KSRequestManager postRequestWithUrlString:@"api/orders.php?act=cancel_orders_reback" parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"back_id":self.back_id} success:^(id responseObject) {
            
            [MBProgressHUD showSuccessMessage:@"已取消"];
            _headeView.data = @"8";
            [self base_RefreshHeaderFooter:YES];
            [[NSNotificationCenter defaultCenter]postNotificationName:@"shuaxin" object:self];
            
        } failure:^(id error) {
            
        }];
        
    }
}
@end
