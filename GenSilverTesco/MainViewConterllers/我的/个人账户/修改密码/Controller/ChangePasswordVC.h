//
//  ChangePasswordVC.h
//  Diamond
//
//  Created by MrSong on 17/7/11.
//  Copyright © 2017年 FSShao. All rights reserved.
//

#import "KSBaseViewController.h"

@interface ChangePasswordVC : KSBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *oldPW;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *password2;

@property (nonatomic,strong) NSString *type ;
@end
