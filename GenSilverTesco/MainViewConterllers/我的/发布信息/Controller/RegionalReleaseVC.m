//
//  RegionalReleaseVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/28.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "RegionalReleaseVC.h"
#import <UIButton+WebCache.h>
@interface RegionalReleaseVC ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong, nonatomic) NSString *imagesUrl;

@property (strong, nonatomic) id data;
@property (strong, nonatomic) UIImage *iamge;
@end

@implementation RegionalReleaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.imagesUrl = @"";
    [self.imagesButton.imageView setContentMode:UIViewContentModeScaleAspectFill];
    [self.imagesButton.layer setMasksToBounds:YES];

    [self setRightWithString:@"提交" action:@selector(subCommit)];
    self.title = @"发布信息";
    [self getTheAgentInformation];
    
    if (_model) {
        [self.imagesButton sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,_model.imgs]] forState:UIControlStateNormal placeholderImage:KSPLAIMAGE];
        self.titleLabel.text = _model.title;
        self.contextTextView.text = _model.content;
        self.imagesUrl = _model.imgs;
        
    }
}

- (void)getTheAgentInformation{
    [KSRequestManager postRequestWithUrlString:URL_agent_info parameter:@{@"user_id":[UserInfoManager sharedManager].user_id} success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        self.areaLabel.text = KSDIC(responseObject, @"agent_area");
        self.data = responseObject;
          self.placeholder.text = @"";
        
    } failure:^(id error) {
        
    }];
}


- (void)subCommit{
    [self.view endEditing:YES];
    if ([self.titleLabel.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入标题"];
        return;
    }
    
    if ([self.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入内容"];
        return;
    }
    
    if ([self.titleLabel.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:@"请输入标题"];
        return;
    }
    
    if (self.iamge == nil&&_model == nil) {
        
        [MBProgressHUD showTipMessageInWindow:@"请添加图片"];
        return;
    }
    WeakSelf
    [self upLoadImageView:^(NSString *imageUrl) {
        weakSelf.imagesUrl = imageUrl;
        NSDictionary *dic = @{@"province":KSDIC(_data, @"province")
                              ,@"city":KSDIC(_data, @"city")
                              ,@"district":KSDIC(_data, @"district")
                              ,@"title":self.titleLabel.text
                              ,@"content":self.contextTextView.text
                              ,@"user_id":[UserInfoManager sharedManager].user_id
                              ,@"imgs":self.imagesUrl
                              ,@"oid":_model?_model.iD:@""
                              };
        [MBProgressHUD showActivityMessageInWindow:isSubmitted];
        [KSRequestManager postRequestWithUrlString:URL_news_add parameter:dic success:^(id responseObject) {
            [MBProgressHUD hideHUD];
            [MBProgressHUD showTipMessageInWindow:addSuccess];
            if (weakSelf.upLoadSuccess) {
                weakSelf.upLoadSuccess();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } failure:^(id error) {

        }];

    }];
   
}

- (void)addRequestData{
    
}

- (void)upLoadImageView:(void(^)(NSString *imageUrl))imageUrl{
    if (self.iamge == nil) {
        if (![self.imagesUrl isEqualToString:@""]) {
            imageUrl(self.imagesUrl);
            return;
        }
    }
    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:nil images:@[self.iamge] success:^(id responseObject) {
        NSLog(@"---%@",responseObject);
        imageUrl(KSDIC( responseObject, @"imgs"));
    } failure:^(NSError *error) {
        
    }];
}

- (IBAction)selectButtonImages:(id)sender{
    
    [KSTool alertViewWithController:self title:@"请选择" message:nil items:@[@"相机",@"相册"] style:UIAlertControllerStyleActionSheet idx:^(NSInteger indx) {
        
        [KSTool ipadCamereWithConeroller:self SourceType:indx == 0 ? UIImagePickerControllerSourceTypeCamera : UIImagePickerControllerSourceTypePhotoLibrary allowsEditing:NO];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self.imagesButton setImage:KSDIC(info, @"UIImagePickerControllerOriginalImage") forState:UIControlStateNormal];
    self.iamge = KSDIC(info, @"UIImagePickerControllerOriginalImage");
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    
}


#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholder.text =@"输入快讯内容";
    }
    else{
        self.placeholder.text = @"";
    }
//    _theRemainingWords.text = [NSString stringWithFormat:@"%lu/300 剩余%lu字",(unsigned long)textView.text.length,(300-textView.text.length)];
    //    NSLog(@"---%d",textView.text.length);
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
@end
