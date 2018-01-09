//
//  BaseLoginRegisteredVC.m
//  BigWinner
//
//  Created by kangshibiao on 2017/2/22.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "BaseLoginRegisteredVC.h"
#import "EaseMessageViewController.h"
#import "ForgotPasswordVC.h"
@interface BaseLoginRegisteredVC ()
@property (assign, nonatomic) NSInteger base_countdown;
@end

@implementation BaseLoginRegisteredVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)setDirectLoginTitle:(UIButton *)sender title:(NSString *)title{
    NSMutableAttributedString *mutabArrri = [[NSMutableAttributedString alloc]initWithString:title];
    [mutabArrri addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x163E67)} range:NSMakeRange(0, 8)];
    [mutabArrri addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:14],NSForegroundColorAttributeName:UIColorFromRGB(0x163E67)} range:NSMakeRange(8,mutabArrri.length - 8)];
    [sender setAttributedTitle:mutabArrri forState:UIControlStateNormal ];
}


- (void)setTextFieldPlaceholderColor:(NSArray <UITextField *>*)views{
    [views enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField * textField = (UITextField *)obj;
        [textField setValue:COLOR_placeholder forKeyPath:@"_placeholderLabel.textColor"];
    }];
}

/** 设置圆角*/
- (void)setViewCornerRadiusViews:(NSArray <UIView *>*)view{
    [view enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.layer.cornerRadius = 4;
        obj.layer.masksToBounds = YES;
    }];
}

/** 获取验证码*/
- (IBAction)getCode:(UIButton *)sender{
    [MBProgressHUD showActivityMessageInWindow:@"正在获取..."];
    if ([self.phoneText isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleasePhone];
        return;
    }
    if (self.phoneText.length !=11) {
        [MBProgressHUD showTipMessageInWindow:errorPhone];
        return;
    }
    [MBProgressHUD showActivityMessageInView:theAuthenticationCodeSent];
    NSDictionary *dic ;
    NSString *url = @"";
    if ([self isKindOfClass:[ForgotPasswordVC class]]) {
        url = URL_send_mobile_code;
        dic =  @{@"username":self.phoneText,@"isapp":@"1"};
    }else{
        url = URL_getcaptchabyid;
        dic = @{@"mobile":self.phoneText,@"isapp":@"1"};
    }
    
//    [KSRequestManager postRequestWithUrlString:url parameter:@{@"mobile":self.phoneText,@"isapp":@"1"} success:^(id responseObject) {
//        NSLog(@"---%@",responseObject);
//        [MBProgressHUD showSuccessMessage:codeSuccess];
//        [self.base_timer setFireDate:[NSDate distantPast]];
//        _base_countdown = 60;
//    } failure:^(id error) {
//        
//    }];
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil]];

    [manager POST:[NSString stringWithFormat:@"%@%@",URL_MANURL,url] parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([KSDIC(responseObject, @"status") integerValue] == 1) {
            [MBProgressHUD showSuccessMessage:codeSuccess];
            [self.base_timer setFireDate:[NSDate distantPast]];
            _base_countdown = 60;

        }else{
            switch ([KSDIC(responseObject, @"err") integerValue]) {
                case 0:{
                    [MBProgressHUD showTipMessageInWindow:KSDIC(responseObject, @"msg")];
                }
                    break;
                case 1:
                {
                    [MBProgressHUD showTipMessageInWindow:@"不要重复获取验证码"];

                }
                    break;
                case 2:
                {
                    [MBProgressHUD showTipMessageInWindow:@"手机号码格式错误"];

                }
                    break;
                case 3:
                {
                    [MBProgressHUD showTipMessageInWindow:@"手机号码已存在"];

                }
                    break;
                case 4:
                {
                    [MBProgressHUD showTipMessageInWindow:@"手机号码已存在"];

                }
                    break;
                default:
                    break;
            }

        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD showErrorMessage:noNetwork];
    }];

}


- (NSTimer *)base_timer{
    if (!_base_timer) {
        _base_timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerStart) userInfo:nil repeats:YES];
    }
    return _base_timer;
}

- (void)timerStart{
    if (_base_countdown == 0) {
        self.sendCode.userInteractionEnabled = YES;
        [self.sendCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.base_timer setFireDate:[NSDate distantFuture]];
        return;
    }
    self.sendCode.userInteractionEnabled = NO;
    _base_countdown --;
    [self.sendCode setTitle:[NSString stringWithFormat:@"%lds",(long)_base_countdown] forState:UIControlStateNormal];

}

#pragma 正则匹配用户密码6-18位数字和字母组合
- (BOOL)checkPassword:(NSString *)password
{
    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:password];
    return isMatch;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)dealloc{
    self.base_timer = nil;
}

//点击登陆后的操作
- (void)loginWithUsername:(NSString *)username password:(NSString *)password responseObject:(id)responseObject
{
    [[EMClient sharedClient] logout:NO];
    
    //异步登陆账号
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            //            [weakself hideHud];
            if (!error) {
                [MBProgressHUD hideHUD];
                [[UserInfoManager sharedManager]insterUserInfo:responseObject[@"userinfo"]];
                
                
                
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                //                EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"wangyajing" conversationType:EMConversationTypeChat];
                //                [self.navigationController pushViewController:chatController animated:YES];
                //                //获取数据库中数据
                
                //                [MBProgressHUD showHUDAddedTo:weakself.view animated:YES];
                //                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                //                    [[EMClient sharedClient] migrateDatabaseToLatestSDK];
                //                    dispatch_async(dispatch_get_main_queue(), ^{
                //                        [[ChatDemoHelper shareHelper] asyncGroupFromServer];
                //                        [[ChatDemoHelper shareHelper] asyncConversationFromDB];
                //                        [[ChatDemoHelper shareHelper] asyncPushOptions];
                //                        [MBProgressHUD hideAllHUDsForView:weakself.view animated:YES];
                //                        //发送自动登陆状态通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                //
                //                        //保存最近一次登录用户名
                //                        [weakself saveLastLoginUsername];
                //                [weakself getTheFriecdsList];
                //                    });
                //                });
                //                   [[ViewController new] initTableBarControllrer];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                [MBProgressHUD showErrorMessage:@"登陆失败！请检查是否有环信ID"];
                
            }
        });
    });
}


@end
