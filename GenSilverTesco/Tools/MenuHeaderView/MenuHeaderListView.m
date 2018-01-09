//
//  MenuHeaderListView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/2.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "MenuHeaderListView.h"
#import "MenuListModel.h"
@implementation MenuHeaderListView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
     
        
    }
    return self;
}

- (void)setTableNum:(TableView_Num)tableNum{
    _tableNum = tableNum;
    if (tableNum == tableView_Num1) {
        self.left_tab_width.constant = Screen_wide;
        self.rightTableView.hidden = YES;
    }else{

    }
    self.left_tab_height.constant = 400;
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    }];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 0) {
        return self.leftDatasArray.count;
    }else{
        if (_tableNum == tableView_Num1) {
            return 0;
        }
        return [self.rightDatasArray[self.indexPath_row] count];
    }
}

static NSString *cellId = @"";
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:cellId];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (tableView.tag == 0) {
        MenuListModel *model = self.leftDatasArray[indexPath.row];
        if (self.indexPath_row != indexPath.row) {
            cell.textLabel.textColor = [UIColor blackColor];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }else{
            cell.textLabel.textColor = [UIColor redColor];
            cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
        }
        cell.textLabel.text = model.title;

    }else{
        
        NSArray *array = self.rightDatasArray[self.indexPath_row];
        MenuListModel *model = array[indexPath.row];
        cell.textLabel.text = model.title;
        cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return cell;
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_tableNum  == tableView_Num1) {
        [self baseXIB_removeSubView];
        if (self.base_BlockIdx) {
            self.base_BlockIdx(indexPath.row);
        }
    }else{
        if (tableView.tag == 0) {
            MenuListModel *oldModel = self.leftDatasArray[self.indexPath_row];
            oldModel.select = 0;
            UITableViewCell *ordeCell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:self.indexPath_row inSection:0]];
            ordeCell.textLabel.textColor = [UIColor blackColor];
            ordeCell.contentView.backgroundColor = [UIColor whiteColor];
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            MenuListModel *model = self.leftDatasArray[indexPath.row];
            model.select = 1;
            cell.textLabel.textColor = [UIColor redColor];
            cell.contentView.backgroundColor = [UIColor groupTableViewBackgroundColor];
            self.indexPath_row = indexPath.row;
            [self.rightTableView reloadData];
        }else{
            if (self.table_index) {
                self.table_index(self.indexPath_row,indexPath.row);
            }
            NSLog(@"---%d",indexPath.row);
            [self baseXIB_removeSubView];
        }
      
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .01;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self baseXIB_removeSubView];
}

#pragma mark -- TableView 分割线
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


@end
