//
//  CommentsListModel.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Replys :NSObject
@property (nonatomic , copy) NSString              * addtime;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * user_id;

@end

@interface CommentsListModel : NSObject
@property (nonatomic , strong) NSArray<Replys *>              * replys;
@property (nonatomic , copy) NSString              * addtime;
@property (nonatomic , copy) NSString              * alias;
@property (nonatomic , copy) NSString              * iD;
@property (nonatomic , copy) NSString              * content;
@property (nonatomic , copy) NSString              * goods;
@property (nonatomic , copy) NSString              * imgs;
@property (nonatomic , copy) NSString              * headimg;
@property (nonatomic , copy) NSString              * real_name;
@property (nonatomic , copy) NSString              * user_name;
@property (nonatomic , copy) NSString              * user_id;
@property (nonatomic , copy) NSString              * hasgoods;

@end
