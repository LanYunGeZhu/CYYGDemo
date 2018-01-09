//
//  AReplyMessage.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityNewsModel.h"
@interface AReplyMessage : KSBaseViewController
/** */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *layouHeight;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
/** 昵称*/
@property (weak, nonatomic) IBOutlet UILabel *nickName;
/**  时间*/
@property (weak, nonatomic) IBOutlet UILabel *timer;
/** */
@property (weak, nonatomic) IBOutlet UILabel *context;
/** */
@property (weak, nonatomic) IBOutlet UILabel *address;

@property (weak, nonatomic) IBOutlet UILabel *placeholder;

/** 剩余字数*/
@property (weak, nonatomic) IBOutlet UILabel *theRemainingWords;

@property (strong, nonatomic) IBOutlet UITextView *contextTextView;
/** */
@property (strong, nonatomic) CommunityNewsModel *model;
@end
