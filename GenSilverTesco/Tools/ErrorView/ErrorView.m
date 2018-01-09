//
//  ErrorView.m
//  BigWinner
//
//  Created by kangshibiao on 2017/3/2.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ErrorView.h"

@implementation ErrorView

- (void)awakeFromNib{
    [super awakeFromNib];
}

- (IBAction)buttonSender:(id)sender{
    if (_loadButton) {
        _loadButton();
    }
}

@end
