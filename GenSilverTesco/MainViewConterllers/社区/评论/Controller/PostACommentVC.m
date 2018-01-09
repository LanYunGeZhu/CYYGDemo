//
//  PostACommentVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/24.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PostACommentVC.h"

@interface PostACommentVC ()

@end

@implementation PostACommentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"评论";
    [self setRightWithString:@"发布" action:@selector(releseLike)];
}

- (void)releseLike{
    
    if ([self.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入评论内容"];
        return;
    }
    
//    self.parent_id = @"7";
    [MBProgressHUD showActivityMessageInWindow:@"正在提交..."];
    [KSRequestManager postRequestWithUrlString:URL_bbs_add parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"content":self.contextTextView.text,@"parent_id":self.parent_id} success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:@"评论成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            if (_addCommitBlock) {
                _addCommitBlock([CommentsListModel whc_ModelWithJson:responseObject]);
            }
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
