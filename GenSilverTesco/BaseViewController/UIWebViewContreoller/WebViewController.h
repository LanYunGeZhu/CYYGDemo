//
//  WebViewController.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/2.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : KSBaseViewController
/** */
/** */
@property (copy, nonatomic) NSString *url_string;
/** */
@property (weak, nonatomic) IBOutlet UILabel *lableString ;

@end
