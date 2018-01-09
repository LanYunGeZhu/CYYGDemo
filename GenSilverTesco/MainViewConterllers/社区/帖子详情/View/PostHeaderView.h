//
//  PostHeaderView.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsListModel.h"
@interface PostHeaderView : KSBaseXIBView
/** */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** */
@property (weak, nonatomic) IBOutlet UILabel*name;
/** */
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** */
@property (weak, nonatomic) IBOutlet UIButton *praise;
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;
/** 当前帖子的用户名*/
@property (strong, nonatomic) NSString *user_id;


/** */
@property (strong, nonatomic) CommentsListModel *model;

/** */
@property (weak, nonatomic) IBOutlet UILabel *isOriginalPoster;
@end
