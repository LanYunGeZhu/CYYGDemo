//
//  wCheckIde.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "KSBaseViewController.h"
#import "WTouchTabDelegate.h"
#import "WInfomationModel.h"

typedef void (^IdeCallBack)(BOOL wIdeSubmit);

@interface WCheckIdeVC : KSBaseViewController

@property (nonatomic,strong)IdeCallBack Ide;

@property (nonatomic,weak)IBOutlet WTouchTabDelegate *IDETab;

@end
