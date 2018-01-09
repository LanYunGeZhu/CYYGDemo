//
//  AReplyMessage.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/18.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "AReplyMessage.h"

@interface AReplyMessage ()

@end

@implementation AReplyMessage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self headerViewHeight];
    [self setRightWithString:@"发送" action:@selector(sendClick)];
    self.title = @"回复消息";
}

- (void)sendClick{
    NSLog(@"--f发送");
    
    if ([self.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入评论内容"];
        return;
    }
    
    [KSRequestManager postRequestWithUrlString:URL_bbs_add parameter:@{@"user_id":[UserInfoManager sharedManager].user_id,@"content":self.contextTextView.text,@"parent_id":_model.parent_id} success:^(id responseObject) {
        [MBProgressHUD showTipMessageInWindow:@"回复成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];

        });
    } failure:^(id error) {
        
    }];
}

- (void)headerViewHeight{
    [self.headerImageView.layer setCornerRadius:16];
    [self.headerImageView.layer setMasksToBounds:YES];
    
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,_model.headimg]] placeholderImage:KSPLAIMAGE];
    self.context.text = _model.content;
    self.nickName.text = _model.alias;
    self.timer.text = [KSTool dateTransformString:[_model.addtime doubleValue] ];
    self.context.text = _model.content;
    CGSize size =[KSTool sizeWithTexte:_model.content font:[UIFont systemFontOfSize:14] maxSize:CGSizeMake(Screen_wide -32, MAXFLOAT)];
    self.layouHeight.constant = ceil(size.height) + 41;
    [UIView animateWithDuration:.3 animations:^{
        [self.view layoutIfNeeded];
    }];
    
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholder.text =@"请输入要回复的内容";
    }
    else{
        self.placeholder.text = @"";
    }
    _theRemainingWords.text = [NSString stringWithFormat:@"%lu/300 剩余%lu字",(unsigned long)textView.text.length,(300-textView.text.length)];
    //    NSLog(@"---%d",textView.text.length);
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}


@end
