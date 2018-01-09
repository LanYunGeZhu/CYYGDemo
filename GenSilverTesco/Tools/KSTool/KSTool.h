//
//  KSTool.h
//  KSTool
//
//  Created by mc on 16/3/12.
//  Copyright © 2016年 kangshibiao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface KSTool : NSObject
/**
 * 判断字符串 里面有没有值
 */
+ (BOOL)isEqualToStringNew:(NSString *)text;

/**
 *  设置时间格式
 *  @param timer 时间 输出格式为：2010-10-27 10:22:13
 */

+ (NSString *)setTimeFormat:(double)timer;
/**
 *   设置时间格式 需要传入style timer
 *   @param style 你需要的时间格式
 *   @param timer 毫秒值
 *
 */

+ (NSString *)setTimeStyle:(NSString *)style timer:(double)timer;
/**
 *   获取毫秒值
 *
 */

+ (double)gitTimeIntervalText:(NSString *)text dataType:(NSString *)dataType;
/**
 *   分离字符串
 *   @param valuer 传入分离的字符
 *   @param content 内容
 */
+ (NSString *)SeparatdeValuer:(NSString *)valuer content:(NSString *)content;
/**
 *  获取字体的长度或者宽度
 *  @param text 字体
 *  @param font 字体类型
 *  @param size 字体大小
 */
+ (CGSize)sizeWithTexte:(NSString *)text font:(UIFont *)font maxSize:(CGSize)size;
/**
 *  判断一个字典里面有米有对应的key
 *  @param dic
 *  @param key
 */
+ (BOOL )dictionaryWith:(NSDictionary *)dic key:(NSString *)key;

/**
 *  UIalertView UIActionSheet 提示框
 *  @param title
 *  @param message
 *  @param style
 *  @param items 数组只能放两个
 */
+ (void)alertViewWithController:(UIViewController *)controller
                          title:(NSString *)title
                        message:(NSString *)message
                          items:(NSArray *)itesm
                          style:(UIAlertControllerStyle )style
                            idx:(void (^)(NSInteger indx))idx;
/**
 *  动画效果
 */
+ (void)showKey:(UIView *)view;

/*
 * 拨打电话
 * @param phone
 */
+ (void)callPhone:(NSString *)phone;

/**
 * 根据传入的毫秒 转成 几分钟前 刚刚
 * @param ts
 */

+ (NSString*)dateTransformString:(long long)ts;

/**
 * 判断是不是手机号码
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;

/**
 * 判断银行卡是否合法
 */
+ (BOOL)checkCardNo:(NSString*) cardNo;

/**
 * 判断是不是身份证号码
 */
+ (BOOL)validateIdentityCard:(NSString *)identityCard;

/**
 * ipad打开相机
 */
+ (void)ipadCamereWithConeroller:(id)viewController SourceType:(UIImagePickerControllerSourceType)SourceType allowsEditing:(BOOL)allowsEditing;
#pragma mark ---设置所有的控件都是圆角
///** 
// * 设置所有的控件都是圆角 
// */
//+(void)setControlsRoundCorner:(NSArray *)controls ;

/** 
 *返回某个键对应的所有值，拼接为一个逗号分隔的字符串 
 */
+ (NSString*)userChoosePatchwork:(NSMutableArray *)mutaArr forKey:(NSString *)key;

/**
 * 公共方法设置富文本
 * @param string 需要设置的字符串
 * @parma color  需要设置的颜色
 * @parma startNum 开始
 * @parma length   长度
 */
+ (NSMutableAttributedString *)setAttributedString:(NSString * )string  color:(UIColor *)color startNum:(NSInteger)startNum length:(NSInteger)length;
@end
