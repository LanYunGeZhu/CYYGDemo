//
//  UIViewController+OpenImagePicker.m
//  ios拍照-相册-录像
//
//  Created by sny on 16/1/5.
//  Copyright © 2016年 sny. All rights reserved.
//

#import "UIViewController+OpenImagePicker.h"
#import <objc/runtime.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UIViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong)UIImagePickerController * snyImgPicker;
@property(nonatomic,copy)void(^snycompleted)(UIImage * image,NSString * filePath);
@end



@implementation UIViewController (OpenImagePicker)

-(void)openImagePickerWithAction:(OpenImagePickerAction)action completed:(void(^)(UIImage * image,NSString * filePath))completed
{
    if (!self.snyImgPicker)
    {
        self.snyImgPicker = [[UIImagePickerController alloc] init];
    }
    self.snyImgPicker.allowsEditing = YES;
    self.snyImgPicker.delegate = self;
    
    self.snycompleted = completed;
    
    if (action==OpenImagePickerAction_xiangce)
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            [self snyShowAlert:@"暂无法打开相册"];
            return;
        }
        self.snyImgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
    }
    else
    {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] || ![UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear])
        {
            [self snyShowAlert:@"摄像头无法使用"];
            return;
        }
        //是否允许编辑
        self.snyImgPicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.snyImgPicker.cameraDevice = UIImagePickerControllerCameraDeviceRear;

        if (action==OpenImagePickerAction_luxiang)
        {
            self.snyImgPicker.mediaTypes = @[(NSString *)kUTTypeMovie];
            self.snyImgPicker.videoQuality = UIImagePickerControllerQualityTypeIFrame1280x720;
            self.snyImgPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        }
        else
        {
            self.snyImgPicker.mediaTypes = @[(NSString *)kUTTypeImage];
            self.snyImgPicker.videoQuality = UIImagePickerControllerQualityTypeMedium;
            self.snyImgPicker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        }
    }
    
    [self presentViewController:self.snyImgPicker animated:YES completion:nil];
    
}
#pragma mark -- UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
    {
        UIImage *image = nil;
        if (picker.allowsEditing)
        {
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        }
        else
        {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //对图片大小进行压缩--
        
        if (self.snycompleted)
        {
            self.snycompleted(image,nil);
        }
        //图片保存到相册
      // UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
    {
        NSURL *url = [info objectForKey:UIImagePickerControllerMediaURL];
        NSString *urlStr = [url path];
        if (self.snycompleted)
        {
            self.snycompleted(nil,urlStr);
        }
        //视频保存到相册
        //        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr))
        //        {
        //            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);
        //        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
-(void)snyShowAlert:(NSString *)alert
{
    [[[UIAlertView alloc] initWithTitle:nil message:alert delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil, nil] show];
}
-(void)setSnyImgPicker:(UIImagePickerController *)snyImgPicker
{
    objc_setAssociatedObject(self, @selector(snyImgPicker), snyImgPicker, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImagePickerController *)snyImgPicker
{
    return objc_getAssociatedObject(self, @selector(snyImgPicker));
}
-(void)setSnycompleted:(void (^)(UIImage *,NSString *))snycompleted
{
    objc_setAssociatedObject(self, @selector(snycompleted), snycompleted, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(void(^)(UIImage *,NSString *))snycompleted
{
    return objc_getAssociatedObject(self, @selector(snycompleted));
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissModalViewControllerAnimated:YES];
}
@end
