//
//  PamentCodeSuccessVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/8/3.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "PamentCodeSuccessVC.h"
#import "UIImage+Add.h"
//#import "UIImage+LXDCreateBarcode.h"
@import Photos;
@interface PamentCodeSuccessVC ()

@end

@implementation PamentCodeSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.stroeName.text = _data[@"store_name"];
    //二维码里面的内容:店铺id 商家id 商品名称 积分让利比 现金让利比 店铺名称,C1我要收款二维码 C2店铺制作二维码
    NSString *goodnameStr = [NSString stringWithFormat:@"%@",self.data[@"goods_name"]] ;
    if (goodnameStr.length == 0) {
        goodnameStr = @"未填写";
    }
    NSString *sss = [NSString stringWithFormat:@"C2 %@ %@ %@ %@ %@ %@",self.data[@"shop_id"],[UserInfoManager sharedManager].user_id,goodnameStr,self.data[@"rlbl1"],self.data[@"rlbl2"],_data[@"store_name"]];
    UIImage * newImage = [UIImage getQrImageString:sss  Size:162 withRed:0 Green:0 Blue:0];
    self.codeImageView.image = newImage;
    
    self.title = @"制作收款码";
}

- (IBAction)saveThePhotoAlbum:(id)sender{
    
    if (self.codeImageView.image) {
        [self loadImageFinished:self.codeImageView.image];

    }
}

- (void)loadImageFinished:(UIImage *)image
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        
        PHAssetChangeRequest *req = [PHAssetChangeRequest creationRequestForAssetFromImage:image];
        
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        
        NSLog(@"success = %d, error = %@", success, error);
        if (success) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showTipMessageInWindow:@"已保存到相册"];

            });
        }else{
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showTipMessageInWindow:@"保存失败请重试"];

            });
        }
        
    }];
}


//MARK: 二维码中间内置图片,可以是公司logo
-(UIImage *)logoQrCodeString:(NSString *)codeString logoImage:(UIImage *)logo{
    
    //
    NSArray *filters = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    NSLog(@"%@",filters);
    
    //二维码过滤器
    CIFilter *qrImageFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //设置过滤器默认属性 (老油条)
    [qrImageFilter setDefaults];
    
    //将字符串转换成 NSdata (虽然二维码本质上是 字符串,但是这里需要转换,不转换就崩溃)
    NSData *qrImageData = [codeString dataUsingEncoding:NSUTF8StringEncoding];
    
    //我们可以打印,看过滤器的 输入属性.这样我们才知道给谁赋值
    NSLog(@"%@",qrImageFilter.inputKeys);
    /*
     inputMessage,        //二维码输入信息
     inputCorrectionLevel //二维码错误的等级,就是容错率
     */
    
    
    //设置过滤器的 输入值  ,KVC赋值
    [qrImageFilter setValue:qrImageData forKey:@"inputMessage"];
    
    //取出图片
    CIImage *qrImage = [qrImageFilter outputImage];
    
    //但是图片 发现有的小 (27,27),我们需要放大..我们进去CIImage 内部看属性
    qrImage = [qrImage imageByApplyingTransform:CGAffineTransformMakeScale(20, 20)];
    
    //转成 UI的 类型
    UIImage *qrUIImage = [UIImage imageWithCIImage:qrImage];
    
    
    //----------------给 二维码 中间增加一个 自定义图片----------------
    //开启绘图,获取图形上下文  (上下文的大小,就是二维码的大小)
    UIGraphicsBeginImageContext(qrUIImage.size);
    
    //把二维码图片画上去. (这里是以,图形上下文,左上角为 (0,0)点)
    [qrUIImage drawInRect:CGRectMake(0, 0, qrUIImage.size.width, qrUIImage.size.height)];
    
    
    //再把小图片画上去
    UIImage *sImage = logo;
    
    CGFloat sImageW = 100;
    CGFloat sImageH= sImageW;
    CGFloat sImageX = (qrUIImage.size.width - sImageW) * 0.5;
    CGFloat sImgaeY = (qrUIImage.size.height - sImageH) * 0.5;
    
    [sImage drawInRect:CGRectMake(sImageX, sImgaeY, sImageW, sImageH)];
    
    //获取当前画得的这张图片
    UIImage *finalyImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return finalyImage;
//    //设置图片
//    self.codeImageView.image = finalyImage;
}


@end
