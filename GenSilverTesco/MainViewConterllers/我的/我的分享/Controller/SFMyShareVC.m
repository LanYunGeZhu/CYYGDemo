//
//  SFMyShareVC.m
//  GenSilverTesco
//
//  Created by MrSong on 17/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SFMyShareVC.h"
#import "SFMyShareCell.h"
#import "SFMyShareModel.h"
#import "WShareView.h"

@interface SFMyShareVC ()<UITableViewDelegate,UITableViewDataSource>

@property (assign, nonatomic) NSInteger _page;
@property (nonatomic,strong) NSMutableArray *dataArray ;
@property (strong, nonatomic)  WShareView *shareView;

@end

@implementation SFMyShareVC

#pragma mark 懒加载

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
- (void)viewDidLoad{
    [super viewDidLoad];
    [self selfInitUI];
    [self AFManagerDragon_requestData];
}

#pragma mark 加载UI
/*! 布局UI */
- (void)selfInitUI{
    
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    
    [self.myTableView registerNib:[UINib nibWithNibName:@"SFMyShareCell" bundle:nil] forCellReuseIdentifier:@"SFMyShareCell"];
    _hasCode.titleLabel.adjustsFontSizeToFitWidth = YES;

    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{
    
    [KSRequestManager postRequestWithUrlString:URL_myShare parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":[NSString stringWithFormat:@"%ld",(long)__page],@"change_type":@"6"} success:^(id responseObject) {
        
        NSString *btntittle = [NSString stringWithFormat:@"%@",responseObject[@"tintegral"]] ;
        if (btntittle.length == 0) {
            [_hasCode setTitle:@"0.00" forState:(UIControlStateNormal)];
        }else{
            [_hasCode setTitle:btntittle forState:(UIControlStateNormal)];
        }
        
        
        NSMutableArray*listArr = [[NSMutableArray alloc]initWithArray:responseObject[@"lists"]];
        for (NSDictionary *dic in listArr) {
            SFMyShareModel *model = [[SFMyShareModel alloc]initWithDictionary:dic];
            
            [self.dataArray addObject:model];
        }
        
        [self.myTableView reloadData];
        [self endRefresh];
        
    } failure:^(id error) {
        [self endRefresh];
    }];
    
    
}
- (void)endRefresh{
    [self.myTableView.mj_header endRefreshing];
    [self.myTableView.mj_footer endRefreshing];
}

/*!  数据请求 */
- (void)AFManagerDragon_requestData{
    __page = 1;
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self.dataArray removeAllObjects];
        [self.myTableView reloadData];
        __page = 1;
        [self gitRequestData];
    }];
    
    self.myTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        __page ++;
        [self gitRequestData];
    }];
    [self gitRequestData];
}

#pragma mark 代理方法回调
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SFMyShareCell *cell = [_myTableView dequeueReusableCellWithIdentifier:@"SFMyShareCell"];
    
    if (!cell) {
        cell = [[SFMyShareCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"SFMyShareCell"];
    }
    
    if (self.dataArray.count > 0) {
        
        cell.model = self.dataArray[indexPath.row];
    }
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return Screen_heigth/667*50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8.0;
}

#pragma mark 点击事件
- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES] ;
}
//马上邀请
- (IBAction)inviteBtn:(id)sender {
    _shareView  = [WShareView initBaseView];
    [self.view addSubview:_shareView] ;
    _shareView.frame = CGRectMake(0, 0, Screen_wide,Screen_heigth+50);
    _shareView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    WeakSelf
    _shareView.delegate = self;
    _shareView.base_BlockIdx = ^(NSInteger index)
    {
        switch (index) {
          
            case 4:
            {
                [weakSelf.shareView setHidden:YES];
            }
                break;
                
            default:
                break;
        }
    };
}

#pragma mark 工具方法




@end
