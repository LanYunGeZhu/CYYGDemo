//
//  SFMyCollectVC.m
//  Diamond
//
//  Created by MrSong on 17/7/6.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import "SFMyCollectVC.h"
#import "SFMyCollectModel.h"
#import "SFMyCollectCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"
#import "GoodsDetailsVC.h"

@interface SFMyCollectVC ()<UITableViewDataSource,UITableViewDelegate>

@property (assign, nonatomic) NSInteger _page;
@property (nonatomic,strong) NSMutableArray *deleteArr ;
@property (nonatomic,strong) NSMutableArray *dataArray ;

@end

@implementation SFMyCollectVC
#pragma mark 懒加载
- (NSMutableArray *)deleteArr{
    if (!_deleteArr) {
        _deleteArr = [NSMutableArray array];
    }
    return _deleteArr;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark 生命周期
- (void)viewDidLoad{
    [super viewDidLoad];
    self.title = @"我的收藏";
    [self selfInitUI];
    [self AFManagerDragon_requestData];
}

#pragma mark 加载UI
/*! 布局UI */
- (void)selfInitUI{

    _deleteArr = [[NSMutableArray alloc]init];
    self.myTableView.dataSource = self;
    self.myTableView.delegate = self;
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    if ([self.myTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.myTableView setSeparatorInset:(UIEdgeInsetsMake(0, 0, 0, 0))];
    }
    
    [self.myTableView registerClass:[SFMyCollectCell class] forCellReuseIdentifier:@"SFMyCollectCell"];
    
//    [self setRightWithString:@"编辑" action:@selector(editBtn:)];
    
}
#pragma mark 请求数据
/*! 自定义数据*/
- (void)gitRequestData{
    
    [KSRequestManager postRequestWithUrlString:URL_myCollect parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"page":[NSString stringWithFormat:@"%ld",(long)__page]} success:^(id responseObject) {
        
        if (__page == 1) {
            [self.dataArray removeAllObjects];
        }
        
        NSMutableArray*listArr = [[NSMutableArray alloc]initWithArray:responseObject[@"lists"]];
        for (NSDictionary *dic in listArr) {
            SFMyCollectModel *model = [[SFMyCollectModel alloc]initWithDictionary:dic];
            
            [self.dataArray addObject:model];
        }
        
        [self.myTableView reloadData];
        [self endRefresh];
        
    } failure:^(id error) {
        
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.dataArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SFMyCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SFMyCollectCell"];
    
    cell.collectBtn.tag = indexPath.section;
    [cell.collectBtn addTarget:self action:@selector(collectButton:) forControlEvents:(UIControlEventTouchUpInside)];

    
    cell.model = self.dataArray[indexPath.section];
    
    
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SFMyCollectModel * model=  self.dataArray[indexPath.section];
    
    float flo = [self.myTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[SFMyCollectCell class] contentViewWidth:[UIScreen mainScreen].bounds.size.width];
    
    return flo;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return .1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 8.0;
}

//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
//}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GoodsDetailsVC *goods =[GoodsDetailsVC new];
    SFMyCollectModel *model = self.dataArray[indexPath.section];
    goods.goods_id = model.goods_id;
    [self.navigationController pushViewController:goods animated:YES];
    
//    [_deleteArr addObject:self.dataArray[indexPath.section]];
//    
//    NSArray *subviews = [[tableView cellForRowAtIndexPath:indexPath] subviews];
//    for (id subCell in subviews) {
//        if ([subCell isKindOfClass:[UIControl class]]) {
//            
//            for (UIImageView *circleImage in [subCell subviews]) {
//                circleImage.image = [UIImage imageNamed:@"对勾"];
//            }
//        }
//        
//    }
}
//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    [_deleteArr removeObject:self.dataArray[indexPath.section]];
//    
//    NSArray *subviews = [[tableView cellForRowAtIndexPath:indexPath] subviews];
//    for (id subCell in subviews) {
//        if ([subCell isKindOfClass:[UIControl class]]) {
//            
//            for (UIImageView *circleImage in [subCell subviews]) {
//                circleImage.image = [UIImage imageNamed:@"灰16-16"];
//            }
//        }
//        
//    }
//}


#pragma mark 点击事件
//取消收藏 ptype 1取消收藏 0收藏
- (void)collectButton:(UIButton *)btn{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确认取消收藏吗?" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
    }];
    UIAlertAction *maketure = [UIAlertAction actionWithTitle:@"确认" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
        SFMyCollectModel *model = self.dataArray[btn.tag];
        [KSRequestManager postRequestWithUrlString:URL_cancleCollect parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"goods_id":model.goods_id,@"ptype":@"1"} success:^(id responseObject) {
            
            NSLog(@"------(%@)-----",responseObject) ;
            //删除本地数据
            [_myTableView beginUpdates];
            NSMutableIndexSet *indexArr = [NSMutableIndexSet new];
            [indexArr addIndex:btn.tag];
            [self.dataArray removeObjectAtIndex:btn.tag];
            [_myTableView deleteSections:indexArr withRowAnimation:(UITableViewRowAnimationNone)];
            [_myTableView endUpdates];
            
        } failure:^(id error) {
            
        }];
        
    }];
    [alert addAction:cancle];
    [alert addAction:maketure];
    [self.navigationController presentViewController:alert animated:YES completion:nil];
    

    
}

- (void)editBtn:(UIButton *)sender{//编辑按钮
    
    if (self.dataArray.count == 0) {
        return;
    }
    
    _allchooseBtn.frame = CGRectMake(0, 0, Screen_wide/2, 44);
    _deleteBtn.frame = CGRectMake(Screen_wide/2, 0, Screen_wide/2, 44);
    _myTableView.allowsMultipleSelectionDuringEditing = YES;
    _myTableView.editing = !_myTableView.editing;
    
    if (_myTableView.editing) {
        
        [_bottomView setHidden:NO];
//        [sender setTitle:@"取消" forState:(UIControlStateNormal)];
        
    }else{
        
        [_bottomView setHidden:YES];
//        [sender setTitle:@"编辑" forState:(UIControlStateNormal)];
    }
    
    
}
- (IBAction)allchooseBtn:(UIButton *)sender {//全选
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        
        for (int i = 0; i < self.dataArray.count; i++) {
            
            [_deleteArr addObject:self.dataArray[i]];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            [self.myTableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
            NSArray *subviews = [[_myTableView cellForRowAtIndexPath:indexPath] subviews];
            for (id subCell in subviews) {
                if ([subCell isKindOfClass:[UIControl class]]) {
                    
                    for (UIImageView *circleImage in [subCell subviews]) {
                        circleImage.image = [UIImage imageNamed:@"对勾"];
                    }
                }
                
            }
        }
        
    }else{
        
        [self.deleteArr removeAllObjects];
        for (int i = 0; i < self.dataArray.count; i++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
            [self.myTableView deselectRowAtIndexPath:indexPath animated:NO];
            NSArray *subviews = [[_myTableView cellForRowAtIndexPath:indexPath] subviews];
            for (id subCell in subviews) {
                if ([subCell isKindOfClass:[UIControl class]]) {
                    
                    for (UIImageView *circleImage in [subCell subviews]) {
                        circleImage.image = [UIImage imageNamed:@"灰16-16"];
                        circleImage.contentMode = UIViewContentModeScaleAspectFill;
                    }
                }
                
            }
        }
        
    }
    
    
    
}
- (IBAction)deleteBtn:(id)sender {//删除
    
    if (_deleteArr.count == 0) {
        NSLog(@"至少选择一项");
        return;
    }
    
    NSMutableArray *deleteArray = [NSMutableArray array];
    for (NSIndexPath *indexPath in self.myTableView.indexPathsForSelectedRows) {
        [deleteArray addObject:self.dataArray[indexPath.section]];
    }
    
    NSMutableArray *currentArray = self.dataArray;
    [currentArray removeObjectsInArray:deleteArray];
    self.dataArray = currentArray;
    if (self.dataArray.count ==0) {
        self.myTableView.editing = NO;
        [self setRightWithString:@"编辑" action:@selector(editBtn:)];
        _bottomView.hidden = YES;
    }
    
    dispatch_after(1.0, dispatch_get_main_queue(), ^{
        
        [self.myTableView reloadData];
    });
}





#pragma mark 工具方法




@end
