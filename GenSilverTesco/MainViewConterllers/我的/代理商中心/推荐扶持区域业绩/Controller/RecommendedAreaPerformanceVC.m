//
//  RecommendedAreaPerformanceVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/1.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RecommendedAreaPerformanceVC.h"
#import "AmountCell.h"
#import "RegionalListCell.h"
#import "RegionalSerachNavView.h"
#import "KSPickView.h"
#import "RecommendedModel.h"
@interface RecommendedAreaPerformanceVC ()

@property (strong, nonatomic) NSString *year;
@property (strong, nonatomic) NSString *month;
@property (strong, nonatomic) RegionalSerachNavView *navView;

@property (copy, nonatomic) NSString *serachText;

@property (strong, nonatomic) id data ;
@end

@implementation RecommendedAreaPerformanceVC

- (RegionalSerachNavView *)navView{
    if (_navView == nil) {
        _navView = [RegionalSerachNavView initBaseView];
    }
    return _navView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.year = @"";
    self.month = @"";
    self.serachText = @"";
    [self addMjRefresh];
    [self loadRequsetData];
    [self initNavView];
    [[WHC_KeyboardManager share] addMonitorViewController:self];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)initNavView{

    WeakSelf
    self.navView.frame = CGRectMake(0, 0, Screen_wide, 35);
    self.navView.base_BlockIdx = ^(NSInteger index){
        [weakSelf showPickViewTimer];
    };
    self.navView.searchBlick = ^(NSString *serachString){
        NSLog(@"---%@",serachString);
        weakSelf.serachText = serachString;
        [weakSelf base_RefreshHeaderFooter:YES];
    };
    self.navigationItem.titleView = self.navView;
 
}

- (void)loadRequsetData{
//    [super loadRequsetData];
    NSDictionary * dic = @{@"user_id":[UserInfoManager sharedManager].user_id
                           ,@"page":@(self.page)
                           ,@"size":@(self.size)
                           ,@"keys":self.serachText
                           ,@"year":self.year
                           ,@"month":self.month};
    [KSRequestManager postRequestWithUrlString:URL_subsstat parameter:dic success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[RecommendedModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        _data = responseObject;
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
        
    }];
}

- (void)initTableView{
    [self registerTableVieCell:@"RegionalListCell"];
    [self registerTableVieCellsArray:@[@"AmountCell"]];
}

- (void)showPickViewTimer{
    WeakSelf
    NSMutableArray * array = [NSMutableArray array];
    for (int x = 0; x < 100; x ++) {
        [array addObject:[NSString stringWithFormat:@"%d",(x + 2015)]];
    }
    KSPickView *pickView = [[KSPickView alloc]initWithFrame:[UIScreen mainScreen].bounds type:PickTypePickView];
    pickView.datasArr = @[array,@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"]];
    pickView.blockArray = ^(NSArray *array){
        __block NSString *weakString = nil;
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (!weakString) {
                weakString = KSDIC(obj, @"context");
                self.year = KSDIC(obj, @"context");
            }else{
                weakString = [NSString stringWithFormat:@"%@-%@",weakString,KSDIC(obj, @"context")];
                self.month = KSDIC(obj, @"context");

            }
            [weakSelf.navView.selectData setTitle:weakString forState:UIControlStateNormal];
        }];
        [weakSelf base_RefreshHeaderFooter:YES];

    };
    [pickView show];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        AmountCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AmountCell" forIndexPath:indexPath];
        if (_data) {
            cell.monthOnGold.text = [NSString stringWithFormat:@"%@",KSDIC(_data, @"mrl")];
            cell.yearsOnGold.text =[NSString stringWithFormat:@"%@", KSDIC(_data, @"totalrl")];
        }
      

        cell.bgView.hidden = YES;
        return cell;
    }else{
        RegionalListCell *cell = (RegionalListCell *) [super tableView:tableView cellForRowAtIndexPath:indexPath];

        cell.model = self.datasMutabArray[indexPath.section -1];
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == 0 ?50 : 124.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}


#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.navView.serachBar.isFirstResponder) {
        [self.navView.serachBar resignFirstResponder];
        return;
    }
}




@end
