//
//  UIViewController+OpenImagePicker.h
//  ios拍照-相册-录像
//
//  Created by sny on 16/1/5.
//  Copyright © 2016年 sny. All rights reserved.
//
//英语很烂  
//UIImagePickerController中文显示，请将info.plist Localization native development region 设置成china

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, OpenImagePickerAction) {
    OpenImagePickerAction_paizhao,
    OpenImagePickerAction_xiangce,
    OpenImagePickerAction_luxiang
};

@interface UIViewController (OpenImagePicker)
/**
 *  打开相机或相册
 *
 *  @param action    拍照or相册or录像
 *  @param completed 完成的block image是图片(废话) filePath是录像的视频的文件地址
 */
-(void)openImagePickerWithAction:(OpenImagePickerAction)action completed:(void(^)(UIImage * image,NSString * filePath))completed;

@end
