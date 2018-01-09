//
//  InformationdetailsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "InformationdetailsVC.h"
#import "NewLatestInformationCell.h"
#import "GoodsInfoCell.h"
#import "InfomationImageCell.h"
#import "InformationInfoCell.h"
#import "GoodsImageCell.h"
#import "GoodsFooterWKWebView.h"

@interface InformationdetailsVC ()<UIWebViewDelegate>
@property (strong, nonatomic) GoodsFooterWKWebView *footerWebiView;
@property (strong, nonatomic) NSArray *titleArray;
@property (strong, nonatomic) NSArray *contextArray;
@end

@implementation InformationdetailsVC




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (_newLitsType == 2) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self addFooterView:_model.content];

        });
    }
    
    if (_newLitsType == 1) {
        self.titleArray = @[@"活动店铺",@"开始时间",@"结束时间",@"活动价格",@"商品原价",@"每人限领",@"活动总量"];
        self.contextArray = @[_model.shop_name,_model.stime,_model.etime,_model.price,_model.sprice,_model.perorder,[_model.orders integerValue] == 0 ? @"不限量":_model.orders];
    
    }
}

- (void)addFooterView:(NSString *)htmlString{
    WeakSelf
    self.footerWebiView = [[GoodsFooterWKWebView alloc]initWithFrame:CGRectMake(0, 0, Screen_wide, 100)];
    self.footerWebiView.hetmlString = htmlString;
    self.footerWebiView.didFinishNavigation = ^(CGFloat height){
        weakSelf.footerWebiView.frame = CGRectMake(0, 0, Screen_wide, height);
        [weakSelf.myTableView reloadData];
        [MBProgressHUD hideHUD];
    };
    self.myTableView.tableFooterView = self.footerWebiView;
}



- (void)initTableView{
    self.title = @"资讯详情";
    [self registerTableVieCellsArray:@[@"NewLatestInformationCell",@"InformationInfoCell",@"InfomationImageCell"]];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1 && _newLitsType == 1) {
        return self.titleArray.count +1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (_newLitsType ==2) {
        return 1;
    }
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        NewLatestInformationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewLatestInformationCell" forIndexPath:indexPath];
        cell.name.text = _model.title;
        cell.timer.text = _model.addtime;
        cell.context.text = @"";
        return cell;
    }
    else if (indexPath.section ==1){
        InformationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([InformationInfoCell class]) forIndexPath:indexPath];
        if (indexPath.row == self.titleArray.count ) {
            cell.contextLabel.text = _model.content;
            cell.d_contextLabel.hidden = YES;

        }else{
            cell.contextLabel.text = self.titleArray[indexPath.row];
            cell.d_contextLabel.text = self.contextArray[indexPath.row];
            cell.d_contextLabel.hidden = NO;
        }
        
        return cell;
    }
    else{
        InfomationImageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InfomationImageCell" forIndexPath:indexPath];
        [cell.pictureImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,_model.imgs]] placeholderImage:KSPLAIMAGE];
        if ([_model.imgs isEqualToString:@""]) {
            cell.pictureImageView.hidden =YES;
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }else if (indexPath.section ==1){
        if (indexPath.section == 1 && _newLitsType == 1) {
            return 40;
        }
        CGSize size = [KSTool sizeWithTexte:_model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 32, MAXFLOAT)];
        return ceil(size.height) +32;
    }else{
        if ([_model.imgs isEqualToString:@""]) {
            
            return 0;
        }
        return 164;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 00.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        InfomationImageCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        [self base_ToViewLargerVersion:cell.contentView currentImageIndex:0 imageCount:1 smlImage:cell.pictureImageView.image bigImageUrl:@[[NSString stringWithFormat:@"%@%@",URL_MANURL,_model.imgs]]];

    }
}




@end
