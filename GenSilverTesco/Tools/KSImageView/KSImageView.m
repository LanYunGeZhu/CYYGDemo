//
//  KSImageView.m
//  MyImage
//
//  Created by kangshibiao on 16/5/4.
//  Copyright © 2016年 ZJTRRJ. All rights reserved.
//

#define Witd         self.frame.size.width

#import "KSImageView.h"

@implementation KSImageView
{
    JKImagePickerController *imagePickerController;
    
    NSInteger _maximumNumbe;
    NSInteger _cloumn;
    NSInteger indexItems;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
//        [self addSubview:self.collectionView];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    if (self = [super initWithCoder:aDecoder]) {
        [self addSubview:self.collectionView];
        
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(0, 0, Screen_wide , self.frame.size.height);
}

- (void)setColumn:(NSInteger )cloumn maximumNumberOfSelection:(NSInteger )maximumNumbe{
    _cloumn  = cloumn;
    _maximumNumbe = maximumNumbe;
    [self.collectionView reloadData];
}

- (void)setImageArr:(NSMutableArray *)imageArr{
    
    _imageArr = imageArr;
    NSLog(@"----------------%@",NSStringFromCGRect(self.frame));
    [self.collectionView reloadData];
}

- (NSMutableArray *)assetsArray{
    if (!_assetsArray) {
        
        _assetsArray = [NSMutableArray array];
    }
    return _assetsArray;
}
- (UICollectionView *)collectionView{
    
    if (!_collectionView) {
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, Screen_wide -16, self.frame.size.height) collectionViewLayout:self.flowLaytout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.scrollEnabled = NO;
        [_collectionView registerNib:[UINib nibWithNibName:@"KSImageCell" bundle:nil] forCellWithReuseIdentifier:@"KSImageCell"];
    }
    return _collectionView;
}
- (UICollectionViewFlowLayout *)flowLaytout{
    
    if (!_flowLaytout) {
        
        _flowLaytout = [[UICollectionViewFlowLayout alloc]init];
        
    }
    return _flowLaytout;
}
#pragma mark --- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_imageArr.count == _maximumNumbe)
    {
        return _imageArr.count;
    }
    return _imageArr.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    KSImageCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KSImageCell" forIndexPath:indexPath];
    
    
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClock:) forControlEvents:UIControlEventTouchUpInside]
    ;
    
    if (_imageArr.count == indexPath.row)
    {
        cell.deleteBtn.hidden = YES;
        
        cell.hedImageView.image = [UIImage imageNamed:_placeholderImage?_placeholderImage: @"添加动态图片"];
    }
    else{
        
        cell.deleteBtn.hidden = NO;
        if ([self.imageArr[indexPath.item] isKindOfClass:[UIImage class]]) {
            UIImage * iamge = self.imageArr[indexPath.item];
            
            cell.hedImageView.image =[self imageCompressForSize:iamge targetSize:CGSizeMake(Witd/_cloumn-30, Witd/_cloumn-30 + 8)];

        }
        else{

            [cell.hedImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URL_MANURL,self.imageArr[indexPath.item]]] placeholderImage:KSPLAIMAGE];
        }
    }
    return cell;
    
}
#pragma mark --- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    indexItems = indexPath.item;
    KSImageCell *cell = (KSImageCell *)[collectionView cellForItemAtIndexPath:indexPath];

    if (_imageArr.count == indexPath.row)
    {
        [self composePicAdd];
    }
    else{
        if (indexPath.item +1 == _maximumNumbe) {
            [self composePicAdd];
            return;
        }
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        if ([self.imageArr[indexPath.item] isKindOfClass:[UIImage class]]) {
            UIImage * image = self.imageArr[indexPath.item];
            [imageview setImage:image];
        }else{
            [imageview setImage:cell.hedImageView.image]; //获取显示在按钮上的图片（压缩过）

        }
        //    [imageview setImage:_ImageArray[sender.tag]];          //获取从相册获取的原图片（原来的）
        [UUImageAvatarBrowser showImage:imageview];

    }
}

#pragma mark --- UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(Witd/_cloumn-30, Witd/_cloumn-30 + 8);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 8;
}
#pragma --- mark 删除
- (void)deleteBtnClock:(UIButton *)sender
{
    KSImageCell *cell = (KSImageCell *)[sender superview].superview;
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    if (_imageArr.count ==0) {
        return;
    }
    //编辑单独处理？
    if (_goodsEditor) {
        if (_imageArr.count == _maximumNumbe) {
            if ([self.imageArr[indexPath.item] isKindOfClass:[UIImage class]]) {
//
                __block int num = 0;
                [self.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        num ++;
                    }
                }];
                [self.assetsArray removeObjectAtIndex:indexPath.item - num];
            }
            
            [self.imageArr removeObjectAtIndex:indexPath.item];
            [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        }
        else{
            if ([self.imageArr[indexPath.item] isKindOfClass:[UIImage class]]) {
                //
                __block int num = 0;
                [self.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([obj isKindOfClass:[NSString class]]) {
                        num ++;
                    }
                }];
                [self.assetsArray removeObjectAtIndex:indexPath.item - num];
            }

            [self.imageArr removeObjectAtIndex:indexPath.item];
            [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
      
        if (_block) {
            _block();
        }
        return;
    }
    if (_imageArr.count == _maximumNumbe) {
        [self.imageArr removeObjectAtIndex:indexPath.item];
        [self.assetsArray removeObjectAtIndex:indexPath.item];
        [self.collectionView reloadData];
        if (_block) {
            _block();
        }
        return;
    }
    [self.imageArr removeObjectAtIndex:indexPath.item];
    [self.assetsArray removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    if (_block) {
        _block();
    }
/*
    KSImageCell *cell = (KSImageCell *)[sender superview].superview;
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:cell];
    if (_imageArr.count ==0) {
        return;
    }
   
    if (_imageArr.count == _maximumNumbe) {
        
        if ([self.imageArr[indexPath.item] isKindOfClass:[UIImage class]]) {
            __block int urlIdx = 0;
            [self.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj isKindOfClass:[NSString class]]) {
                    urlIdx ++;
                }
            }];
            [self.assetsArray removeObjectAtIndex:indexPath.item - urlIdx];

        }
        [self.imageArr removeObjectAtIndex:indexPath.item];

        [self.collectionView reloadSections:[NSIndexSet indexSetWithIndex:0]];
        if (_block) {
            _block();
        }
        return;
    }
    
    if ([self.imageArr[indexPath.item] isKindOfClass:[UIImage class]]) {
        __block int urlIdx = 0;
        [self.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[NSString class]]) {
                urlIdx ++;
            }
        }];
        [self.assetsArray removeObjectAtIndex:indexPath.item -urlIdx];
        
    }

    [self.imageArr removeObjectAtIndex:indexPath.item];

    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    if (_block) {
        _block();
    }
 */
}

- (void)composePicAdd
{
    imagePickerController = [[JKImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.showsCancelButton = YES;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = _maximumNumbe;
    imagePickerController.selectedAssetArray = self.assetsArray;
    imagePickerController.noSelectedArray = self.imageArr;
    UIWindow *wiondw= [[UIApplication sharedApplication].delegate window];
    UITabBarController *tabBar =(UITabBarController *) wiondw.rootViewController;
    
    UINavigationController *pushClassStance = (UINavigationController *)tabBar.viewControllers[tabBar.selectedIndex];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:imagePickerController];
    [pushClassStance presentViewController:navigationController animated:YES completion:NULL];

    
}
#pragma mark - JKImagePickerControllerDelegate
- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAsset:(JKAssets *)asset isSource:(BOOL)source
{
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

- (void)imagePickerController:(JKImagePickerController *)imagePicker didSelectAssets:(NSArray *)assets isSource:(BOOL)source
{
//    [MBProgressHUD show];
    
    NSMutableArray *arr = [NSMutableArray array];
    
    ALAssetsLibrary   *lib = [[ALAssetsLibrary alloc] init];
    self.assetsArray =[NSMutableArray arrayWithArray:assets];

    for (int i = 0; i < assets.count; i ++ )
    {
        JKAssets  *asset = assets[i];
        
        [lib assetForURL:asset.assetPropertyURL resultBlock:^(ALAsset *asset)
         {
             if (asset)
             {
                 
                 UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
                 
                 [arr addObject: image];
                 
                 if (arr.count == assets.count)
                 {
                     if (_goodsEditor) {
                         __block int num = 0;
                         [self.imageArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                             if ([obj isKindOfClass:[NSString class]]) {
                                 num ++;
                             }
                         }];
                         NSMutableArray * edArray = [[NSMutableArray alloc]initWithArray:self.imageArr];
                         if (num > 0) {
                             [edArray addObjectsFromArray:arr];
                         }
                         else{
                             edArray = arr;
                         }
                         self.imageArr = edArray;
                         [self.collectionView reloadData];
                         if (_block) {
                             
                             _block();
                         }
                
                     }else
                     {
                         self.imageArr = arr;
                         if (_block) {
                             
                             _block();
                         }
                         

                     }
//                     [JCProgressHUD dismiss];

                     
                 }
             
             }
         } failureBlock:^(NSError *error) {
             
         }];
        
    }
    
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (void)imagePickerControllerDidCancel:(JKImagePickerController *)imagePicker
{
    [imagePicker dismissViewControllerAnimated:YES completion:^{
        
    }];
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
