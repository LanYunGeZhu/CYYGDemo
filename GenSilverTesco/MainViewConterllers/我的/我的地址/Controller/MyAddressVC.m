//
//  MyAddressVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/21.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MyAddressVC.h"
#import "MyAddressCell.h"
#import "AddAddressCell.h"
#import "AddAddressVC.h"
@interface MyAddressVC ()

@end

@implementation MyAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadRequsetData];
    [self addMjRefresh];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
//    for (int x= 0; x < 3; x ++) {
//        
//        [self.datasMutabArray addObject:@(x)];
//    }
    [KSRequestManager postRequestWithUrlString:URL_address_list parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        
        [self.datasMutabArray addObjectsFromArray:[MyAddressModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        [self.myTableView reloadData];
        [self endRefresh];
    } failure:^(id error) {
       
    }] ;
}

- (void)initTableView{
    [self registerTableVieCellsArray:@[@"MyAddressCell",@"AddAddressCell"]];
    self.base_table_deleteEdit = YES;
    self.title = @"收货地址";
    [super initTableView];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasMutabArray.count  == indexPath.section) {
        AddAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddAddressCell" forIndexPath:indexPath];
        return cell;
    }
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyAddressCell" forIndexPath:indexPath];
    cell.model = self.datasMutabArray[indexPath.section];
//    cell.address.text = @"浙江省西湖区文三路 553 号中小企业大厦2002室浙江省西湖区文三路 553 号中小企业大厦2002室";
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.datasMutabArray.count  == indexPath.section ) {
        NSLog(@"新增");
        AddAddressVC *addres =[AddAddressVC new];
        WeakSelf
        addres.updataAddress= ^(){
            [weakSelf base_RefreshHeaderFooter:YES];
        };
        [self.navigationController pushViewController:addres animated:YES];
    }else{
        if (_isAddress == 1) {
            AddAddressVC *addres =[AddAddressVC new];
            WeakSelf
            addres.updataAddress= ^(){
                [weakSelf base_RefreshHeaderFooter:YES];
            };
            addres.model = self.datasMutabArray[indexPath.section];
            [self.navigationController pushViewController:addres animated:YES];
            return;
        }
        if (_selectListModel) {
            _selectListModel(self.datasMutabArray[indexPath.section]);
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.datasMutabArray.count == indexPath.section ) {
        
        return 44;
    }
    MyAddressModel *model = self.datasMutabArray[indexPath.section];
    CGSize size = [KSTool sizeWithTexte:[NSString stringWithFormat:@"%@%@",model.rnames,model.address] font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide - 28, MAXFLOAT)];
    return ceil(size.height) + 29 + 14;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 16;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MyAddressModel *model = self.datasMutabArray[indexPath.section];
        [KSRequestManager postRequestWithUrlString:URL_address_del parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"address_id":model.address_id} success:^(id responseObject) {
            [self.datasMutabArray removeObjectAtIndex:indexPath.section];
            [self.myTableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationLeft];
        } failure:^(id error) {
            
        }];
    }
}


@end
