//
//  SearchViewVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SearchViewVC.h"
#import "SerachLsitCell.h"
@interface SearchViewVC ()

@end

@implementation SearchViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavSerachView:CGRectMake(0, 0, Screen_wide, 31) isResponse:YES addressTextIco:NO];
    [self.searchView.serachTextField becomeFirstResponder];
    self.searchView.searchButton.hidden = YES;
    WeakSelf
    self.searchView.serachTextBlock = ^(NSString *serachText){
        NSLog(@"---%@",serachText);
        if (weakSelf.serachStringBlock) {
            [weakSelf.searchView.serachTextField endEditing:YES];
            weakSelf.serachStringBlock(serachText);
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    [self loadRequsetData];
}

- (void)goBack{
    
    [self.searchView.serachTextField resignFirstResponder];
    [super goBack];
}

- (void)loadRequsetData{
    for (int x = 0; x < 0; x ++) {
        [self.datasMutabArray addObject:@(x)];
    }
    [self.myTableView reloadData];
}

- (void)initTableView{
    
    [self registerTableVieCell:@"SerachLsitCell"];
    self.base_CellHeight = 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SerachLsitCell *cell = (SerachLsitCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.serachText.text = @"213";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.serachStringBlock) {
        self.serachStringBlock(@"213");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
