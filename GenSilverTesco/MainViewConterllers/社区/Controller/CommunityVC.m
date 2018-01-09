//
//  CommunityVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/5.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "CommunityVC.h"
#import "CommunityListCell.h"

#import "ReleaseMessageVC.h"
#import "CommunityNewsVC.h"
#import "PostDetailsVC.h"
#import "CommunityModel.h"
#import "KSCLLocationManager.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import "MessageNumView.h"
@interface CommunityVC ()

@property (strong, nonatomic) NSString *address;

@property (strong, nonatomic) MessageNumView *numView;
@end

@implementation CommunityVC

- (MessageNumView *)numView{
    if (_numView == nil) {
        _numView = [MessageNumView initBaseView];
        _numView.frame = CGRectMake(0, 0, 60, 44);
        
    }
    return _numView;
}


- (void)setLeftDefultWithNav{};

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([UserInfoManager sharedManager].isLogin) {
        [self getMessagerNum];

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //    [self addMjRefresh];
    self.address = @"";
    [self setLeftWithImage:@"编辑" action:@selector(leftClick)];
//    [self setRightWithImage:@"消息" action:@selector(rightClick)];
    
    [self addMjRefresh];
    [self loadRequsetData];

    WeakSelf
    KSCLLocationManager * manager = [KSCLLocationManager shareManager];
    manager.isCity = YES;
    manager.locationBlock = ^(CLLocation *loction,id locality){
//        AMapLocationReGeocode * regocdeo = locality;
//        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",regocdeo.province,regocdeo.city,regocdeo.district];
        
        NSString *state=KSDIC(locality, @"State");
        
        NSString *city= KSDIC(locality, @"City");
        
        NSString *subLocality=KSDIC(locality, @"SubLocality");
//        weakSelf.address = [NSString stringWithFormat:@"%@%@%@",state,city,subLocality];


    };
    [manager start];
    
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc]initWithCustomView:self.numView];
    self.numView.base_BlockIdx = ^(NSInteger index){
        [weakSelf rightClick];
    };
}

- (void)getMessagerNum{
    [KSRequestManager postRequestWithUrlString:URL_bbs_new_msg_num parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        if ([KSDIC(responseObject, @"total") integerValue] == 0) {
            self.numView.numLabel.hidden = YES;
        }else{
            self.numView.numLabel.text = [NSString stringWithFormat:@"%@",KSDIC(responseObject, @"total")];
            self.numView.numLabel.hidden = NO;

        }
    } failure:^(id error) {
        
    }];
}

#pragma mark -- 发布消息
- (void)leftClick{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    
    WeakSelf
    ReleaseMessageVC *releaseMessage = [ReleaseMessageVC new];
    releaseMessage.addBBSSuccess = ^{
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    [self.navigationController pushViewController:releaseMessage animated:YES];
}

#pragma mark -- 消息
- (void)rightClick{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    
    CommunityNewsVC *communit = [CommunityNewsVC new];
    [self.navigationController pushViewController:communit animated:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}


- (void)loadRequsetData{

    NSDictionary *dic = @{@"user_id":[UserInfoManager sharedManager].user_id
                          ,@"page":@(self.page)
                          ,@"size":@(self.size)
                          ,@"address":self.address};
    
    [KSRequestManager postRequestWithUrlString:URL_bbs_lists parameter:dic success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[CommunityModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"CommunityListCell"];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommunityListCell *cell = (CommunityListCell *) [super tableView:tableView cellForRowAtIndexPath:indexPath];
    [cell.imageView_button1 addTarget:self action:@selector(imageView_button1Click:) forControlEvents:UIControlEventTouchUpInside];
    [cell.imageView_button2 addTarget:self action:@selector(imageView_button1Click:) forControlEvents:UIControlEventTouchUpInside];
    cell.communityModel = self.datasMutabArray[indexPath.section];
    [cell.praise addTarget:self action:@selector(praiseClikc:) forControlEvents:UIControlEventTouchUpInside];
    cell.praise.tag = indexPath.section;

    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeakSelf
    CommunityModel *model = self.datasMutabArray[indexPath.section];

    PostDetailsVC * postDetails = [PostDetailsVC new];
    postDetails.synchronousThumbUp = ^(CommunityModel *model){
        [weakSelf.datasMutabArray replaceObjectAtIndex:indexPath.section withObject:model];
        [weakSelf reloadSection:indexPath.section];
    };
    postDetails.iD = model.iD;
    [self.navigationController pushViewController:postDetails animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommunityModel *model = self.datasMutabArray[indexPath.section];
    
    CGSize size =[KSTool sizeWithTexte:model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide -32, MAXFLOAT)];
    NSArray *imagsArray = [self componentsSeparatedByString:model.imgs];
    if (imagsArray.count > 0) {
        return ceil(size.height) + 93 + 60;

    }else{
            return ceil(size.height) + 40 +60;

    }
    // 有图片
    
}

- (NSArray *)componentsSeparatedByString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return @[];
    }
    return [string componentsSeparatedByString:@"|"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

- (void)imageView_button1Click:(UIButton*)sender{
    CommunityListCell *cell = (CommunityListCell *)sender.superview.superview.superview;
    NSIndexPath *indexPath = [self.myTableView indexPathForCell:cell];
    CommunityModel *model = self.datasMutabArray[indexPath.section];
    NSArray *imagsArray = [model.imgs componentsSeparatedByString:@"|"];
    NSMutableArray *array = [NSMutableArray array];
    [imagsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@%@",URL_MANURL,obj]];
    }];
    
    [self base_ToViewLargerVersion:sender.superview currentImageIndex:sender.tag imageCount:array.count smlImage:sender.imageView.image bigImageUrl:array];
}

- (void)praiseClikc:(UIButton *)sender{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    
    CommunityListCell *cell = (CommunityListCell *)sender.superview.superview;

    CommunityModel *model = self.datasMutabArray[sender.tag];
    
    [KSRequestManager postRequestWithUrlString:URL_bbs_goods parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":model.iD} success:^(id responseObject) {
        cell.praise.selected = !cell.praise.selected;
        model.goods  = [NSString stringWithFormat:@"%d",![model.hasgoods boolValue]];
    } failure:^(id error) {
        
    }];
}



@end
