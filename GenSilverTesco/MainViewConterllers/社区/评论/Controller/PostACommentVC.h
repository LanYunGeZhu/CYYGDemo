//
//  PostACommentVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentsListModel.h"
@interface PostACommentVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;
/** 剩余字数*/
@property (weak, nonatomic) IBOutlet UILabel *theRemainingWords;

/** */
@property (strong, nonatomic) NSString *parent_id;

/** 评论成功回调*/
@property (copy, nonatomic) void(^addCommitBlock)(CommentsListModel *model);



@end
