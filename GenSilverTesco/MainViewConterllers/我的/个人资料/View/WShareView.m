//
//  WShareView.m
//  GenSilverTesco
//
//  Created by LWW on 2017/7/20.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "WShareView.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialWechatHandler.h"
#import "WCreateCode.h"
@implementation WShareView

- (void)awakeFromNib{
    [super awakeFromNib];
    
    [self.IconImage.layer setCornerRadius:5.0f];
    [self.IconImage.layer setMasksToBounds:YES];
    [self.TopView.layer setCornerRadius:5];
    [self.TopView.layer setMasksToBounds:YES];
    [self WGetPicture];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([touches anyObject].view != _TView)
    {
        [self removeFromSuperview];
    }
}

- (void)base_ButtonsClick:(UIButton *)sender
{
    [super base_ButtonsClick:sender];
    switch (sender.tag) {
        case 0:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];

        }
            break;
        case 1:
        {            [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];

        }
            break;
        case 2:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_QQ];

        }
            break;
        case 3:
        {
            [self shareWebPageToPlatformType:UMSocialPlatformType_Qzone];

        }
            break;
            
        default:
            break;
    }
    
}
- (void)WGetPicture
{
    [KSRequestManager postRequestWithUrlString:URL_apprecordregister parameter:@{@"parent_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        self.headUrl = KSDIC(responseObject, @"url");
        self.IconImage.image =[WCreateCode qrImageForString:self.headUrl imageSize:200];
        NSLog(@"---%@",responseObject);
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          });
    } failure:^(id error) {
        
    }];

}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建网页内容对象
    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"创盈易购" descr:@"诚邀注册创盈易购APP！" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = self.headUrl;
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
        //创建图片内容对象
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self.delegate completion:^(id data, NSError *error) {
        if (error) {
            [self removeFromSuperview];
            [MBProgressHUD showErrorMessage:@"分享失败!"];
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                
                [self removeFromSuperview];

                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                [self removeFromSuperview];

                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
}


@end
