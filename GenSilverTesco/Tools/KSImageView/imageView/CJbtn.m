//
//  CJbtn.m
//  test
//
//  Created by angel on 15/11/8.
//  Copyright (c) 2015年 angel. All rights reserved.
//

#import "CJbtn.h"
//#import "KSTool.h"
#import <AssetsLibrary/AssetsLibrary.h>
@implementation CJbtn

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
 
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (void)setAsset:(JKAssets *)asset{
    if (_asset != asset) {
        _asset = asset;
        
        ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
        [lib assetForURL:_asset.assetPropertyURL resultBlock:^(ALAsset *asset) {
            if (asset) {

                //按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
//                +(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
                
               UIImage *minImage =  [self imageCompressForSize:[UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]] targetSize:self.frame.size];
                [self setBackgroundImage:minImage forState:UIControlStateNormal];

            }
        } failureBlock:^(NSError *error) {
            
        }];
    }
    
}
//按比例缩放,size 是你要把图显示到 多大区域 CGSizeMake(300, 140)
 - (UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size{
    
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    
    if(CGSizeEqualToSize(imageSize, size) == NO){
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
            
        }
        else{
            
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        if(widthFactor > heightFactor){
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}


@end
