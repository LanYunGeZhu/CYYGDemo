//
//  PostDetailsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PostDetailsVC.h"
#import "CommunityListCell.h"
#import "PostHeaderView.h"
#import "CommentsListCell.h"
#import "PostACommentVC.h"
#import "CommentsListModel.h"
@interface PostDetailsVC ()<SDPhotoBrowserDelegate>

@property (strong, nonatomic) CommunityModel *model;
@end

@implementation PostDetailsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"帖子详情";
    [self addMjRefresh];
    [self loadRequsetData];
}

- (void)goBack{
    
    if (_synchronousThumbUp) {
        _synchronousThumbUp(_model);
    }
    [super goBack];
}

- (void)base_RefreshHeaderFooter:(BOOL)isHeader{
    [super base_RefreshHeaderFooter:isHeader];
    [self loadRequsetData];
}

- (void)loadRequsetData{
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    [KSRequestManager postRequestWithUrlString:URL_bbs_detail parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":self.iD} success:^(id responseObject) {
        _model = [CommunityModel whc_ModelWithJson:responseObject];
        NSLog(@"---%@",responseObject);
        dispatch_group_leave(group);
        NSLog(@"--成功0");

    } failure:^(id error) {
        
    }];
    dispatch_group_enter(group);

    [KSRequestManager postRequestWithUrlString:URL_bbs_replys parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":self.iD,@"page":@(self.page),@"size":@(self.size)} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        [self.datasMutabArray addObjectsFromArray:[CommentsListModel whc_ModelWithJson:responseObject keyPath:@"lists"]];
        dispatch_group_leave(group);
    } failure:^(id error) {
        
        
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        [self endRefresh];
        [self.myTableView reloadData];
    });
}

- (void)initTableView{
    [self registerTableVieCellsArray:@[@"CommentsListCell",@"CommunityListCell"]];
}

#pragma mark -- UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }else{
        CommentsListModel *model = self.datasMutabArray[section -1];
        return model.replys.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datasMutabArray.count +1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        CommunityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommunityListCell" forIndexPath:indexPath];
        [cell.imageView_button1 addTarget:self action:@selector(imageView_button1Click:) forControlEvents:UIControlEventTouchUpInside];
        [cell.imageView_button2 addTarget:self action:@selector(imageView_button1Click:) forControlEvents:UIControlEventTouchUpInside];
        cell.communityModel = _model;
        [cell.praise addTarget:self action:@selector(praiseClikc:) forControlEvents:UIControlEventTouchUpInside];
        [cell.comments_buutton addTarget:self action:@selector(comments_buuttonClick:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else{
        CommentsListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentsListCell" forIndexPath:indexPath];
        cell.base_IndexPath = indexPath;
        cell.model = self.datasMutabArray[indexPath.section -1];
        return cell;
    }
}

#pragma mark -- UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section !=0) {
        if (![UserInfoManager sharedManager].isLogin) {
            [[UserInfoManager sharedManager] goLoginPrompt:YES];
            return;
        }
        // 楼主跟评论人
        CommentsListModel * model = self.datasMutabArray[indexPath.section -1];
        if ([[UserInfoManager sharedManager].user_id isEqualToString:model.user_id] || [[UserInfoManager sharedManager].user_id isEqualToString:_model.user_id]) {
            [self pushAddCommentVC:model.iD success:^(CommentsListModel *model) {
                [self.datasMutabArray replaceObjectAtIndex:indexPath.section -1 withObject:model];
                [self reloadSection:indexPath.section];
            }];
        }
//        [self reloadSection:indexPath.section];

    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {

        CGSize size =[KSTool sizeWithTexte:_model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide -32, MAXFLOAT)];
        NSArray *imagsArray = [self componentsSeparatedByString:_model.imgs];
        if (imagsArray.count > 0) {
            return ceil(size.height) + 93 + 60;
            
        }else{
            return ceil(size.height) + 40 +60;
            
        }
    }

    CommentsListModel * model = self.datasMutabArray[indexPath.section -1];

    Replys *replysModel = model.replys[indexPath.row];
    NSString *context =@"";
    if ([replysModel.user_id isEqualToString:model.user_id]) {
        context = [NSString stringWithFormat:@"楼主 回复 : %@",replysModel.content];
    }else{
        context = [NSString stringWithFormat:@"%@ 回复 : %@",model.alias,replysModel.content];

    }
    CGSize size =[KSTool sizeWithTexte:context font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(Screen_wide -76, MAXFLOAT)];
    return ceil(size.height) + 4;
//    return 28;

}

- (NSArray *)componentsSeparatedByString:(NSString *)string{
    if ([string isEqualToString:@""]) {
        return @[];
    }
    return [string componentsSeparatedByString:@"|"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return section == 0 ? 10 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return .01;
    }
    CommentsListModel * model = self.datasMutabArray[section -1];
    CGSize size =[KSTool sizeWithTexte:model.content font:[UIFont systemFontOfSize:12] maxSize:CGSizeMake(Screen_wide -76, MAXFLOAT)];
    return ceil(size.height) + 60.0f;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    PostHeaderView *headerView = [PostHeaderView initBaseView];
    headerView.user_id = _model.user_id;
    headerView.model = self.datasMutabArray[section -1];
    [headerView.praise addTarget:self action:@selector(praiseListClick:) forControlEvents:UIControlEventTouchUpInside];
    headerView.praise.tag = section;
    [headerView.base_button addTarget:self action:@selector(headerViewBaseClikc:) forControlEvents:UIControlEventTouchUpInside];
    headerView.base_button.tag = section;
    return headerView;
}

- (void)imageView_button1Click:(UIButton*)sender{

    NSArray *imagsArray = [_model.imgs componentsSeparatedByString:@"|"];
    NSMutableArray *array = [NSMutableArray array];
    [imagsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@%@",URL_MANURL,obj]];
    }];
    
    [self base_ToViewLargerVersion:sender.superview currentImageIndex:sender.tag imageCount:2 smlImage:sender.imageView.image bigImageUrl:array];
  
}

/** 楼主回复*/
- (void)headerViewBaseClikc:(UIButton *)sender{
    if (sender.tag !=0) {
        if (![UserInfoManager sharedManager].isLogin) {
            [[UserInfoManager sharedManager] goLoginPrompt:YES];
            return;
        }
        // 楼主跟评论人
        CommentsListModel * model = self.datasMutabArray[sender.tag -1];
        if ([[UserInfoManager sharedManager].user_id isEqualToString:model.user_id] || [[UserInfoManager sharedManager].user_id isEqualToString:_model.user_id]) {
            [self pushAddCommentVC:model.iD success:^(CommentsListModel *model) {
                [self.datasMutabArray replaceObjectAtIndex:sender.tag -1 withObject:model];
                [self reloadSection:sender.tag];
            }];
        }
        //        [self reloadSection:indexPath.section];
        
    }

}

//评论点赞
- (void)praiseListClick:(UIButton *)sender{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    CommentsListModel *model = self.datasMutabArray[sender.tag -1];
    [KSRequestManager postRequestWithUrlString:URL_bbs_goods parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":model.iD} success:^(id responseObject) {
     
        model.hasgoods  = [NSString stringWithFormat:@"%d",![model.hasgoods boolValue]];
        if ([model.hasgoods boolValue]) {
            model.goods = [NSString stringWithFormat:@"%d",[model.goods intValue] + 1 ];
        }else{
            model.goods = [NSString stringWithFormat:@"%d",[model.goods intValue] - 1];
            
        }
        [sender setTitle:[NSString stringWithFormat:@"  点赞(%@)",model.goods] forState:UIControlStateNormal];
        sender.selected = [model.hasgoods boolValue];
    } failure:^(id error) {
        
    }];
}

//主提点赞
- (void)praiseClikc:(UIButton *)sender{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    CommunityListCell *cell = (CommunityListCell *)sender.superview.superview;
    [KSRequestManager postRequestWithUrlString:URL_bbs_goods parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"id":_model.iD} success:^(id responseObject) {
        cell.praise.selected = !cell.praise.selected;
        _model.hasgoods  = [NSString stringWithFormat:@"%d",![_model.hasgoods boolValue]];
    } failure:^(id error) {
    }];
}

- (void)comments_buuttonClick:(UIButton *)sender{
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    WeakSelf
    [self pushAddCommentVC:_model.iD success:^(CommentsListModel *model) {
        [weakSelf.datasMutabArray addObject:model];
        [weakSelf.myTableView insertSections:[NSIndexSet indexSetWithIndex:weakSelf.datasMutabArray.count] withRowAnimation:UITableViewRowAnimationTop];
    }];
}

- (void)pushAddCommentVC:(NSString *)Id success:(void(^)(CommentsListModel *model))success{
    
    PostACommentVC *post = [PostACommentVC new];
    post.addCommitBlock = ^(CommentsListModel *model){
        success(model);
    };
    post.parent_id = Id;
    [self.navigationController pushViewController:post animated:YES];
 
}


@end
