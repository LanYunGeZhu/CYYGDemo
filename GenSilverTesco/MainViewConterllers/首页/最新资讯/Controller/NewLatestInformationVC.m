//
//  NewLatestInformationVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "NewLatestInformationVC.h"
#import "LatestNavMenusView.h"
#import "NewLatestInformationCell.h"
#import "InformationdetailsVC.h"
#import "NewLatestModel.h"
@interface NewLatestInformationVC ()

@property (assign, nonatomic) NSInteger ntype; //1商家活动 2创盈咨询 3区域咨询
@end

@implementation NewLatestInformationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    LatestNavMenusView *menusView = [LatestNavMenusView initBaseView];
    menusView.frame = CGRectMake(40, 0, Screen_wide - 80, 44);
    [menusView.segmentedControl addTarget:self action:@selector(nacMenusClick:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = menusView;
    
    self.ntype = 1;
    [self loadRequsetData];
    [self addMjRefresh];
}

- (void)nacMenusClick:(UISegmentedControl *)segmented{
    self.ntype = segmented.selectedSegmentIndex + 1;
    [self base_RefreshHeaderFooter:YES];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    for (int x = 0; x < 10; x ++) {
//        [self.datasMutabArray addObject:@(x)];
//    }
    [KSRequestManager postRequestWithUrlString:URL_newslists parameter:@{@"ntype":@(_ntype),@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"--%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[NewLatestModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    
    [self registerTableVieCell:@"NewLatestInformationCell"];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    NewLatestInformationCell *cell = (NewLatestInformationCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.newLatesType = self.ntype;
    cell.model = self.datasMutabArray[indexPath.row];
//    cell.context.text = @"你期待的年中活动大促,各商家火爆促销;6月18创盈在这里等你抢购!";
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    InformationdetailsVC *information = [InformationdetailsVC new];
    information.model = self.datasMutabArray[indexPath.row];
    information.newLitsType = _ntype;
    [self.navigationController pushViewController:information animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_ntype == 2) {
        return 70;
    }
    NewLatestModel *model = self.datasMutabArray[indexPath.row];
    CGSize size = [KSTool sizeWithTexte:model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 32, MAXFLOAT)];
    return ceil(size.height) + 38 + 33;
}



@end
