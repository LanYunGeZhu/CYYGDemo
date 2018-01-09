//
//  Header.h
//  KSTool
//
//  Created by mc on 16/3/17.
//  Copyright © 2016年 kangshibiao. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBCOLOR(r, g, b, a)         ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a])

#define RGBSJ(r,g,b,a)  ([UIColor colorWithRed:arc4random()%r/255.0 green:arc4random()%g/255.0 blue:arc4random()%b/255.0 alpha:a])

#define KSDIC(dic,valuer) [dic objectForKey:valuer]==[NSNull null]?@"":[dic objectForKey:valuer]
#define DICSTING(dic,valuer) [NSString stringWithFormat:@"%@",KSDIC(dic, valuer)]
#define  StringWithStr(param,str) ([NSString stringWithFormat:@"%@%@",param,str]) //转换为字符串


#define KSPLAIMAGE [UIImage imageNamed:@"placeholderImage"]
#define WeakSelf __weak typeof(self) weakSelf = self;

//打印日志
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif
#define Screen_wide    [UIScreen mainScreen].bounds.size.width
#define Screen_heigth  [UIScreen mainScreen].bounds.size.height
#define KSFO [UIFont systemFontOfSize:Screen_wide/320*14]
#define FONT(size) [UIFont systemFontOfSize:Screen_wide/320 * size]
#define MainScreen_wide    [UIScreen mainScreen].bounds.size.width/320
#define MainScreen_heigth  [UIScreen mainScreen].bounds.size.height/480

#define KS_W(width) Screen_wide*(width/320.0)
#define KS_H(height) Screen_heigth*(height/667.0)
/********************************   颜色  ******************************************/
//黄色
#define HRGB ([UIColor colorWithRed:231/255.0 green:98/255.0 blue:29/255.0 alpha:1])

/** 背景色 天蓝色吗 不知道 。，*/
#define COLOR_background UIColorFromRGB(0xE4F1FC)

/** 文字颜色  。，*/
#define COLOR_text UIColorFromRGB(0x163E67)

/** 首页按钮选中颜色*/
#define COLOR_SelectedButton UIColorFromRGB(0x288CC9)

/** 首页搜索展位文字颜色*/
#define COLOR_placeholder [UIColor colorWithRed:19/255.0f green:61/255.0f blue:104/255.0f alpha:.5]

//通知
//添加手势
static NSString *const addInteractivePopGesture = @"addInteractivePopGesture" ;
//移除手势
static NSString *const interactivePopGesture = @"interactivePopGesture";
/**隐藏购物车*/
static NSString *const shoppingCartHidden = @"shoppingCartHidden";
/** 显示购物车*/
static NSString *const shoppingCartShow = @"shoppingCartShow";

static NSString *const addCommunityInput = @"addCommunityInput";
extern NSString *const shode;

/** 监听 是否修改头像 是否修改 用户名*/
static NSString *const updeteSuccessUserCenter = @"updeteSuccessUserCenter";

/** 环信通知 监听未读消息数量*/
static NSString *const setupUnreadMessageCount = @"setupUnreadMessageCount";
// 友盟Key
#define UmengAppkey @"598bfee06e27a421d8000549"
//qq空间
#define kQQLoginKey @"1106267203"
#define kQQSecretKey @"69zH30qMSW04gJQC"
//微信
#define kWeiXinKey @"wx152a9ab20be45dda"
#define kWeiXinSecretKey @"c1bad4644caf62685b8bb182a81f7741"




#endif /* Header_h */
