//
//  WPswView.m
//  GenSilverTesco
//
//  Created by LWW on 2017/8/16.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WPswView.h"

@implementation WPswView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    self.WPswView.layer.cornerRadius = 5;
    self.WPswView.clipsToBounds  = YES;
    self.WPswtext.delegate = self;
    [KSTool showKey:self.WPswView];
    [self.WPswtext becomeFirstResponder];
    [self.WPswtext addTarget:self action:@selector(textValueDidChange:) forControlEvents:UIControlEventEditingChanged];

}
- (void)textValueDidChange:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]||[textField.text length] ==0)
    {
        self.Btn.userInteractionEnabled = NO;
    }
    else
    {
        self.Btn.userInteractionEnabled = YES;
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if ([textField.text isEqualToString:@""]||[textField.text length] ==0)
    {
        self.Btn.userInteractionEnabled = NO;
    }
    else
    {
        self.Btn.userInteractionEnabled = YES;
    }
}
- (void)base_ButtonsClick:(UIButton *)sender
{
    [super base_ButtonsClick:sender];
    if(self.Btn.userInteractionEnabled == YES)
    {
        [self endEditing:YES];
    }
    else
    {
        [MBProgressHUD showErrorMessage:WPswTip];

    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches anyObject].view != _WPswView)
    {
        [self removeFromSuperview];
        [self baseXIB_removeSubView];
    }
}

- (void)removeFrom
{
    [self removeFromSuperview];

}


@end
