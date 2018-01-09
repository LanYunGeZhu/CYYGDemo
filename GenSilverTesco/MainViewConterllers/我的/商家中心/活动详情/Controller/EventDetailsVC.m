//
//  EventDetailsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/4.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "EventDetailsVC.h"
#import "PartInfoCell.h"
#import "EventContextCell.h"
#import "ReleaseNewActivitiesVC.h"
#import "PageModel.h"
@interface EventDetailsVC ()
@property (strong, nonatomic) NSArray *contextArray;
@end

@implementation EventDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addHeaderViewPageView:CGRectMake(0, 0, Screen_wide, Screen_wide *152/375)];
    self.pageView.isWebImage  = YES;
    PageModel *pageModel = [PageModel new];
    pageModel.ad_img = _model.imgs
    ;
    self.pageView.imageArray = @[pageModel];
    [self setRightWithString:@"编辑" action:@selector(editClick)];
}
- (void)editClick{
    ReleaseNewActivitiesVC *activitiesVC = [[UIStoryboard storyboardWithName:@"ReleaseNewActivitiesVC" bundle:nil] instantiateViewControllerWithIdentifier:@"ReleaseNewActivitiesVC"];
    activitiesVC.model = _model;
    [self.navigationController pushViewController:activitiesVC animated:YES];
}

- (void)initTableView{
    [self registerTableVieCell:@"PartInfoCell"];
    [self registerTableVieCellsArray:@[@"EventContextCell"]];
    self.title = @"活动详情";
    self.datasMutabArray = @[@"活动店铺",@"活动名称",@"活动时间",@"活动价格",@"商品原价",@"每人限购",@"活动总量",@"状态"];
    NSArray *array = @[@"审核中",@"审核中",@"活动中",@"已驳回"];
    self.contextArray = @[_model.shop_name,_model.title,[NSString stringWithFormat:@"%@-%@",_model.stime,_model.etime],_model.price,_model.sprice,_model.perorder,_model.maxorder,array[[_model.status integerValue]]];

}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasMutabArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasMutabArray.count == indexPath.row) {
        EventContextCell *cell = [tableView dequeueReusableCellWithIdentifier:@"EventContextCell" forIndexPath:indexPath];
        cell.context.text = _model.content;
        return cell;
    }
    PartInfoCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.nameLabel.text = self.datasMutabArray[indexPath.row];
    cell.context.text = self.contextArray[indexPath.row];
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasMutabArray.count == indexPath.row) {
       
        CGSize size = [KSTool sizeWithTexte:_model.content font:[UIFont systemFontOfSize:14] maxSize: CGSizeMake(Screen_wide - 32, MAXFLOAT)];
        return ceil(size.height) + 40;
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


@end
