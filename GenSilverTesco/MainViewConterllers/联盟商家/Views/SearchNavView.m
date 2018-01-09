//
//  SearchNavView.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/13.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "SearchNavView.h"

@implementation SearchNavView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib{
    [super awakeFromNib];
    [self.bgView.layer setCornerRadius:15];
    [self.bgView.layer setMasksToBounds:YES];
    self.serachTextField.tintColor = [UIColor blackColor];
}

- (IBAction)mencClick:(UIButton *)sender{
    if (self.isResponse) {
        self.searchButton.hidden = YES;
        [self.serachTextField becomeFirstResponder];
    }
    else{
        if (self.serachTextBlock) {
            self.serachTextBlock(self.serachTextField.text);
        }
    }
    
}

- (void)setIsResponse:(BOOL)isResponse{
    _isResponse = isResponse;
}


#pragma mark -- UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.isResponse) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.serachTextBlock) {
        self.serachTextBlock(self.serachTextField.text);
    }

    return YES;
}
/** 重写方法 防止 父类删除*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

@end
