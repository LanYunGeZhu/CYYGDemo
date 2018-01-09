//
//  PostDetailsVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommunityModel.h"

@interface PostDetailsVC : KSBaseRefreshViewController
/** */
@property (copy, nonatomic) NSString *iD;

/** 如果点赞跟数量；修改 需要同步*/
@property (copy, nonatomic) void(^synchronousThumbUp)(CommunityModel *model);
@end
