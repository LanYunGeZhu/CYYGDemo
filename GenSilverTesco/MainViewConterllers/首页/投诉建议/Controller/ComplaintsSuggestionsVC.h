//
//  ComplaintsSuggestionsVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/17.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CodeView.h"
@interface ComplaintsSuggestionsVC : KSBaseViewController

@property (weak, nonatomic) IBOutlet UILabel *placeholder;
@property (strong, nonatomic) IBOutlet UITextView *contextTextView;

/** 剩余字数*/
@property (weak, nonatomic) IBOutlet UILabel *theRemainingWords;
/**验证码动态生成 */
@property (strong, nonatomic) CodeView *codeView;

/** */
@property (weak, nonatomic) IBOutlet UIView *codeBgView;

/** 请输入验证码*/
@property (weak, nonatomic) IBOutlet UITextField *codeFiled;



@end
