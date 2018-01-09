//
//  wNickNameVC.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"

typedef void (^nickCallBack)(NSDictionary *nick) ;

@interface WNickNameVC : KSBaseViewController

@property (nonatomic,strong)nickCallBack nick;

@property (nonatomic,weak)IBOutlet UITextField *nickNameTf;

@end
