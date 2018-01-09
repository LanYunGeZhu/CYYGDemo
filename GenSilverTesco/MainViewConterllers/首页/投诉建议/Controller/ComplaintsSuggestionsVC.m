//
//  ComplaintsSuggestionsVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ComplaintsSuggestionsVC.h"
#import "ComplainMenusView.h"
@interface ComplaintsSuggestionsVC ()

@property (strong, nonatomic)ComplainMenusView *complainView;

@property (assign, nonatomic) NSInteger stype ;
@end

@implementation ComplaintsSuggestionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initViewMenusNavView];
    [self intViewCodeView];
 
  
}

- (void) initViewMenusNavView{
    WeakSelf
    self.complainView = [ComplainMenusView initBaseView];
    self.complainView.frame = CGRectMake(0, 0, 148, 44);
    self.complainView.base_BlockIdx = ^(NSInteger idx){
        [weakSelf menusSelect:idx];
    };
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.complainView];

}

- (void)intViewCodeView{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _codeView = [[CodeView alloc] initWithFrame:self.codeBgView.bounds];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
        [_codeView addGestureRecognizer:tap];
        [self.codeBgView addSubview: _codeView];
    });
}

- (void)tapClick:(UITapGestureRecognizer*)tap
{
    [_codeView changeCode];
    NSLog(@"---%@",_codeView.changeString);
}

- (void)menusSelect:(NSInteger)index{
    
    NSLog(@"----%ld",(long)index);
    self.stype = index;
}

#pragma mark -- 提交
- (IBAction)submitButton:(id)sender{
 
    if (![UserInfoManager sharedManager].isLogin) {
        [[UserInfoManager sharedManager] goLoginPrompt:YES];
        return;
    }
    BOOL result = [_codeView.changeString caseInsensitiveCompare:_codeFiled.text] == NSOrderedSame;

    if (!result) {
        
        [MBProgressHUD showTipMessageInWindow:@"验证码不正确"];
        [_codeView changeCode];
        return;
    }
    
    if ([self.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleaseContext];
        return;
    }
    
    [MBProgressHUD showActivityMessageInWindow:isSubmitted];
    [KSRequestManager postRequestWithUrlString:URL_wxsuggest parameter:@{@"isapp":@1,@"user_id":[UserInfoManager sharedManager].user_id,@"content":self.contextTextView.text,@"stype":@(self.stype)} success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:submittedSuccessfully];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    } failure:^(id error) {
        
    }];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholder.text =@"请输入内容";
    }
    else{
        self.placeholder.text = @"";
    }
    if (textView.text.length >300) {
        textView.text = [textView.text substringToIndex:300];
    }
    _theRemainingWords.text = [NSString stringWithFormat:@"%lu/300 剩余%lu字",(unsigned long)textView.text.length,(300-textView.text.length)];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


@end
