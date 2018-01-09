//
//  SFMyCollectVC.h
//  Diamond
//
//  Created by MrSong on 17/7/6.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import "KSBaseViewController.h"

@interface SFMyCollectVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *myTableView;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIButton *allchooseBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;

@end
