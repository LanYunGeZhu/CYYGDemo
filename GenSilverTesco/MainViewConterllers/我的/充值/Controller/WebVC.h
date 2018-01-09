//
//  WebVC.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/15.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"

@interface WebVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgview;
@property (nonatomic,strong) NSString *url ;
@property (nonatomic,strong) NSString *imgurl ;

@property (nonatomic,strong) NSString *ordersn ;
@property (nonatomic,assign) NSInteger mark ;
@end
