//
//  ReleaseMessageVC.m
//  GenSilverTesco
//
//  Created by kangshibiao on 2017/7/14.
//  Copyright © 2017年 ZheJiangTianErRuanJian. All rights reserved.
//

#import "ReleaseMessageVC.h"

@interface ReleaseMessageVC ()

@end

@implementation ReleaseMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   
    
    [self setRightWithString:@"发布" action:@selector(releaseClikc)];
    [[WHC_KeyboardManager share]addMonitorViewController:self];
    
    
    self.imagesView.imageArr = @[];
    self.title = @"发布消息";
    [self.imagesView setColumn:4 maximumNumberOfSelection:2];
    self.imagesView.block =^{
        
    };
}

- (void)releaseClikc{
    NSLog(@"-fabu--");
  
    if ([self.contextTextView.text isEqualToString:@""]) {
        [MBProgressHUD showTipMessageInWindow:pleaseContext];
        return;
    }
    
    [MBProgressHUD showActivityMessageInWindow:@"正在添加..."];
    if (self.imagesView.imageArr.count > 0) {
        
        [self upLoadStoreIamgs:self.imagesView.imageArr success:^(NSArray *imagesArray) {
            NSDictionary *dic=  @{@"user_id":[UserInfoManager sharedManager].user_id
                                  ,@"content":self.contextTextView.text
                                  ,@"imgs":[self setStoreImagesaArrayString:imagesArray]
                                  };
            [self addRequestData:dic];
        }];
        return;
    }
    NSDictionary *dic=  @{@"user_id":[UserInfoManager sharedManager].user_id
                          ,@"content":self.contextTextView.text
                          ,@"imgs":@""
                          };
    [self addRequestData:dic];
  
}

- (void)addRequestData:(id)dic{
    
    [KSRequestManager postRequestWithUrlString:URL_bbs_add parameter:dic success:^(id responseObject) {
        [MBProgressHUD hideHUD];
        [MBProgressHUD showTipMessageInWindow:@"添加成功"];
        [self goBack];
        if (_addBBSSuccess) {
            _addBBSSuccess();
        }
    } failure:^(id error) {
        
    }];
}

// 上传图片

- (void)upLoadStoreIamgs:(NSArray *)idImager success:(void(^)(NSArray *imagesArray))imagesArray{
        dispatch_group_t group1 = dispatch_group_create();
        NSMutableArray *imagsUrlArray1 = [NSMutableArray array];
        
        dispatch_group_async(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);
            [idImager enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSLog(@"---第-%lu--开始上传",(unsigned long)idx);
                [self upLoadIamgesView:obj updataSccuss:^(NSString *imageUrl) {
                    dispatch_semaphore_signal(semaphore1);
                    [imagsUrlArray1 addObject:imageUrl];
                    NSLog(@"---第-%d--上传成功",idx);
                    
                } failure:^(id error) {
                    dispatch_semaphore_signal(semaphore1);
                    
                }];
                dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);
                
            }];
            
        });
    dispatch_group_notify(group1, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        imagesArray(imagsUrlArray1);
    });
}

//拼接店铺展示图
- (NSString *)setStoreImagesaArrayString:(NSArray *)imagesArray{
    __block NSString *urlStrin  =@"";
    [imagesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([urlStrin isEqualToString:@""]) {
            urlStrin = obj;
        }else{
            urlStrin = [NSString stringWithFormat:@"%@|%@",urlStrin,obj];
        }
    }];
    return urlStrin;
}

- (void)upLoadIamgesView:(UIImage *)image updataSccuss:(void(^)(NSString *imageUrl))upLoadSuccess failure:(void(^)(id error))failureImageUrl{
    [KSRequestManager upLodImageRequestWithUrlString:URL_uploadImage parameter:nil images:@[image] success:^(id responseObject) {
        upLoadSuccess(KSDIC(responseObject, @"imgs"));
    } failure:^(NSError *error) {
        failureImageUrl(nil);
    }];
}


#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        self.placeholder.text =@"编辑您要发布的内容信息...";
    }
    else{
        self.placeholder.text = @"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
    
}

@end
