//
//  wIdeView.h
//  GenSilverTesco
//
//  Created by LWW on 2017/7/19.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WIdeView : KSBaseXIBView
//会员名
@property (nonatomic,weak)IBOutlet UITextField *nameTf;
//身份证
@property (nonatomic,weak)IBOutlet UITextField *IdeTf;
//网点
@property (nonatomic,weak)IBOutlet UITextField *NetCodeTf;
//卡号
@property (nonatomic,weak)IBOutlet UITextField *CardNoTf;
//地址
@property (nonatomic,weak)IBOutlet UITextField *AddressTf;
//微信
@property (nonatomic,weak)IBOutlet UITextField *WechatTf;
//QQ
@property (nonatomic,weak)IBOutlet UITextField *QQTf;

//添加
@property (nonatomic,weak)IBOutlet UIButton *AddBt;
//身份证
@property (nonatomic,weak)IBOutlet UIImageView *IdePic;
//银行
@property (nonatomic,weak)IBOutlet UILabel *BankLa;
//区域
@property (nonatomic,weak)IBOutlet UILabel *AreaLa;
@property (nonatomic,weak)IBOutlet UILabel *ClickLa;


@end
