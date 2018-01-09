//
//  KSImageView.h
//  MyImage
//
//  Created by kangshibiao on 16/5/4.
//  Copyright © 2016年 ZJTRRJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KSImageCell.h"
#import "JKImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CJbtn.h"
#import "UUImageAvatarBrowser.h"

typedef void(^popBlock)();
@interface KSImageView : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,JKImagePickerControllerDelegate>


@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *flowLaytout;
@property (strong, nonatomic) NSMutableArray *imageArr;
@property (strong, nonatomic) NSMutableArray *assetsArray;
@property (strong, nonatomic) popBlock block;

// 创建商品编辑
@property (assign, nonatomic) BOOL goodsEditor;

@property (strong, nonatomic) NSString *placeholderImage;
- (void)setColumn:(NSInteger )cloumn maximumNumberOfSelection:(NSInteger )maximumNumbe;



@end
