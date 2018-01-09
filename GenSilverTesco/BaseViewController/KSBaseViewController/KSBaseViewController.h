//
//  KSBaseViewController.h
//  HSH
//
//  Created by kangshibiao on 16/5/30.
//  Copyright © 2016年 mc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "SDPhotoBrowser.h"
@interface KSBaseViewController : UIViewController <SDPhotoBrowserDelegate>

- (void)loadRequsetData;
/**  懒加载初始化一个可变数组*/
@property (strong, nonatomic) NSMutableArray *datasMutabArray;
@property (nonatomic,strong) NSMutableDictionary *datasMutabDic ;

/**
 *  左边返回按钮
 *
 * @param imageName 图片名字 字符串类型
 * @param action    回到方法
 */
- (void)setLeftWithImage:(NSString *)imageName action:(SEL)action;

/**
 *  左边默认返回按钮图片
 *  没有回调方法
 */
- (void)setLeftDefultWithNav;

/**
 * 左边返回按钮 文字
 * @param text   标题名字
 * @param action 回调方法
 */
- (void)setLeftWithString:(NSString *)text action:(SEL)action;

/**
 * 左边返回按钮 文字
 *
 * @param text   标题名字
 */
- (void)setLeftDefaultWithString:(NSString *)text;

/**
 * 右边按钮 图片
 * @param  imageName  图片名字
 * @param  action     回调事件
 */
- (void)setRightWithImage:(NSString *)imageName action:(SEL)action;

/**
 * 右边按钮 文字
 * @param  text 名字
 * @param  action 回调事件
 */
- (void)setRightWithString:(NSString *)text action:(SEL)action;
- (void)goBack;

/**
 * 分割线到头
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

/** 计算经纬度*/
- (NSString *)calculationDistance:(CLLocation* )loction latitude:(double)latitude longitude:(double)longitude;

- (void)setNavStatusBarRedColor:(UIColor *)color;

/** 拨打电话*/
- (void)base_callPhone:(NSString *)mobile;

/**
 * 弹出一个pickView
 * datasArray 二维数组 ，自动处理多个分区
 * selectArray  选择成功回调  数组 《包含 索引 内容》
 */
- (void)base_showPickViewListDatasArray:(NSArray *)datasArray selectArray:(void (^)(NSArray *array))selectArray;
/**
 * 查看大图
 * @param view 当前ImageView 的父视图 superView
 * @param currentImageIndex 当前图片索引
 * @param imageCount        图片的总数量
 * @param smlImage          UImage小图
 * @param bigImageUrl       大图
 */
- (void)base_ToViewLargerVersion:(UIView *)view currentImageIndex:(NSInteger)currentImageIndex imageCount:(NSInteger )imageCount smlImage:(UIImage *)smlImage bigImageUrl:(NSArray< NSString *> *)bigImageUrl;

- (void)dealloc;
@end
