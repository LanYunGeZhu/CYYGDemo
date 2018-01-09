//
//  HelpCenterInfoVC.h
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelpCenterInfoVC : KSBaseRefreshViewController
/** */
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/** */
@property (strong, nonatomic) id data;


@end
