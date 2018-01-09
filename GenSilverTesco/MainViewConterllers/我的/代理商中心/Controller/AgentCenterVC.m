//
//  AgentCenterVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/26.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "AgentCenterVC.h"
#import "AgentHeaderView.h"
#import "AgentListCell.h"
#import "AmountCell.h"
#import "UploadTheMerchantsVC.h"
#import "UIImage+ImageEffects.h"
#import "RegionalPerformanceVC.h"
@interface AgentCenterVC ()

@property (strong, nonatomic)AgentHeaderView *headerView;

@property (strong, nonatomic) id data;
@end

@implementation AgentCenterVC

- (AgentHeaderView *)headerView{
    if (_headerView == nil) {
        _headerView = [AgentHeaderView initBaseView];
        _headerView.frame = CGRectMake(0, 0, Screen_wide, Screen_wide *251/375);
        [_headerView hiddenNum];
    }
    return _headerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"代理商中心";
    self.datasMutabArray = [@[@[@""]
                              ,@[@{@"name":@"区域订单审核",@"image":@"区域订单审核"},@{@"name":@"商家入驻审核",@"image":@"商家入驻审核"},@{@"name":@"区域会员列表",@"image":@"区域会员列表"}]
                              ,@[@{@"name":@"业务员管理",@"image":@"业务员管理"},@{@"name":@"商家活动管理",@"image":@"商家活动管理"},@{@"name":@"区域信息管理",@"image":@"区域信息管理"}]
                              ,@[/**@{@"name":@"活动报备",@"image":@"活动报备"}*/@{@"name":@"推荐扶持区域名单",@"image":@"推荐扶持区域名单"},@{@"name":@"推荐扶持区域业绩",@"image":@"推荐扶持区域业绩"}]]mutableCopy];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    [KSRequestManager postRequestWithUrlString:URL_agent_info parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        self.data = responseObject;
        [self reloadSection:0];
        [self.headerView.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(self.data, @"face_card")]] placeholderImage:KSPLAIMAGE] ;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
            UIImage *image = [UIImage imageWithData:[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(self.data, @"face_card")]]]];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (image) {
                    self.headerView.bgImageView.image = [[self OriginImage:image scaleToSize:CGSizeMake(self.headerView.frame.size.width, self.headerView.frame.size.height)] blurImage];
                    
                }
            });
        });
//        [self.headerView.bgImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,KSDIC(self.data, @"face_card")]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
////            dispatch_async(dispatch_get_main_queue(), ^{
////                self.headerView.bgImageView.image = [image blurImage];
////
////            });
//        }];

    } failure:^(id error) {
        
    }];
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}



- (void)initTableView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.myTableView.tableHeaderView = self.headerView;
    });
    [self registerTableVieCellsArray:@[@"AmountCell",@"AgentListCell"]];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.datasMutabArray[section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return  self.datasMutabArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        WeakSelf
        AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmountCell" forIndexPath:indexPath];
        if (_data) {
            cell.monthOnGold.text =[NSString stringWithFormat:@"%@", KSDIC(_data, @"monthStat")];
            cell.yearsOnGold.text = [NSString stringWithFormat:@"%@", KSDIC(_data, @"totalStat")];
        }
        
        cell.baseCell_buttonIndex = ^(NSInteger index){
            // 区域业绩  上传商家
            index == 0 ? [weakSelf regionalPerformance] : [weakSelf addMerchts] ;
 
        };
        return cell;
    }else{
        AgentListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AgentListCell" forIndexPath:indexPath];
        id data = self.datasMutabArray[indexPath.section];
        cell.name.text = data[indexPath.row][@"name"];
        cell.icoImageView.image = [UIImage imageNamed:data[indexPath.row][@"name"]];

        return cell;
    }
    return nil;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSArray *viewConterollers = @[@[@"RegionalOrderApprovalVC",@"TenantsReviewVC",@"RegionalMemberVC"],@[@"SalesManagementVC",@"BusinessActivityManagementVC",@"RegionalInformationVC"],@[@"SupportListVC",@"RecommendedAreaPerformanceVC"]];
    
    UIViewController *viewController = [NSClassFromString(viewConterollers[indexPath.section -1][indexPath.row]) new];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath.section ==0 ? 95 : 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 8.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01f;
}

#pragma mark -- 区域业绩
- (void)regionalPerformance{
    RegionalPerformanceVC * regional = [RegionalPerformanceVC new];
    [self.navigationController pushViewController:regional animated:YES];
}

#pragma mark -- 添加商家
- (void)addMerchts{

    UploadTheMerchantsVC *upload = [UploadTheMerchantsVC new];
    upload.isyw = 0;
    [self.navigationController pushViewController:upload animated:YES];
}

@end
