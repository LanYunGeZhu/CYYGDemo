//
//  wNickNameVC.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WNickNameVC.h"

@interface WNickNameVC ()

@end

@implementation WNickNameVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];
}

//
- (void)initData

{
    self.title = @"个人资料";
    [self setRightWithString:@"完成" action:@selector(clickToback)];
        
}





- (void)clickToback
{
    
    [self WGetrequestData];
    
}

- (void)WGetrequestData
{
    if ([_nickNameTf.text length] > 0)
    {
        [KSRequestManager postRequestWithUrlString:URL_appsingledefy parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"field":@"alias",@"val":self.nickNameTf.text} success:^(id responseObject) {
            
            [MBProgressHUD showSuccessMessage:WDefyNicknameSuccess];
            
            if (self.nick&&self.nickNameTf.text.length>0)
            {
                
                if(self.nick)
                    self.nick(@{@"nick":self.nickNameTf.text});
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            else
            {
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        } failure:^(id error) {
            
        }];
    }
    else{
        [MBProgressHUD showWarnMessage:WDefyNicknameTip];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
