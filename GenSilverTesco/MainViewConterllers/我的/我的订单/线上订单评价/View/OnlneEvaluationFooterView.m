//
//  OnlneEvaluationFooterView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/8.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "OnlneEvaluationFooterView.h"

@implementation OnlneEvaluationFooterView


- (void)awakeFromNib{
    [super awakeFromNib];
    [self setViewCornerRadiusViews:@[self.commitCilick] floatCoriner:8];
}

- (void)base_ButtonsClick:(UIButton *)sender{
    
    [self.mensuButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (sender.tag < idx ) {
            obj.selected = YES;
        }else{
            obj.selected = NO;
        }
    }];
    [super base_ButtonsClick:sender];
}

- (void)setIndex:(NSInteger)index{
    [self.mensuButton enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (index < idx ) {
            obj.selected = YES;
        }else{
            obj.selected = NO;
        }
    }];
}

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholder.text =@"点击输入评论的内容";
    }
    else{
        self.placeholder.text = @"";
    }
    _theRemainingWords.text = [NSString stringWithFormat:@"%lu/300 剩余%lu字",(unsigned long)textView.text.length,(300-textView.text.length)];
    _model.com_context = textView.text;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}


@end
