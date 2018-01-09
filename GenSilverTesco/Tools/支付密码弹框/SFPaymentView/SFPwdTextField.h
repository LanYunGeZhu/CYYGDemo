//
//  SFPwdTextField.h
//  GenSilverTesco
//
//  Created by MrSong on 17/8/7.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SFPasswordDelegate <NSObject>

- (void)completeInput:(NSString*)pwd;

@end

@interface SFPwdTextField : UIView

@property (nonatomic, weak) id<SFPasswordDelegate> delegate;

@property (nonatomic, strong) UITextField *pwdTextField;

@end
