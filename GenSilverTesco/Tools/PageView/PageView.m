//
//  PageView.m
//  05-图片轮播器
//
//  Created by 柒月丶 on 15-8-6.
//  Copyright (c) 2015年 柒月丶. All rights reserved.
//

#import "PageView.h"
#import "UIImageView+WebCache.h"
#import "PageModel.h"
#import "WebViewController.h"
@interface PageView () <UIScrollViewDelegate>

//@property (nonatomic ,strong) NSArray *imageArray;

@property (nonatomic ,strong) UIScrollView *scrollView;

@property (nonatomic ,strong) UIPageControl *pageControl;


@end


@implementation PageView

-(instancetype)initPageViewFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setNeedsLayout];
}

-(void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    [self setUpScrollView:imageArray];
    [self setUpImage:imageArray];
    [self setUpPageControl:imageArray];
    //保证不管先设置图片来源还是时间，都可以start
    [self.timer invalidate];
    [self startTimer];
}

-(void)setDuration:(NSTimeInterval)duration
{
    _duration = duration;
    [self.timer invalidate];
    [self startTimer];
}

- (NSMutableArray *)imageViewArray{
    if (_imageViewArray == nil) {
        _imageViewArray = [NSMutableArray array];
    }
    return _imageViewArray;
}
/**
 *  设置scrollView
 */
-(void)setUpScrollView:(NSArray *)array
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    scrollView.delegate = self;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pageViewClick:)];
    [scrollView addGestureRecognizer:tapGesture];

    [self addSubview:scrollView];
    self.scrollView = scrollView;
}

/**
 *  设置scrollView的内容图片：如果是网络图片的话就用SDWebImage加载，本地则直接设置
 *  暂时没想出其他方法。
 */
-(void)setUpImage:(NSArray *)array
{
    CGSize contentSize = CGSizeMake(0,0);

    CGPoint startPoint  = CGPointZero;
;
//    NSLog(@"%d",self.isWebImage);
    if (array.count > 1) {     //多张图片
        for (int i = 0 ; i < array.count + 2; i++) {
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            imageView.clipsToBounds = YES;

            if (i == 0) {
                //第一个imageview放最后一张
                PageModel *model = array[array.count -1];
                _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL, model.ad_img) ] placeholderImage:KSPLAIMAGE]:(imageView.image = [UIImage imageNamed:array[array.count - 1]]);

            }else if(i == array.count + 1){
                //最后一个imageview放第一张
//                imageView.image = [UIImage imageNamed:array[0]];
                PageModel *model = array[0];

                _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL,model.ad_img)] placeholderImage:KSPLAIMAGE]:(imageView.image = [UIImage imageNamed:array[0]]);
            }else{
                //4，1，2，3，4，1类似
//                imageView.image = [UIImage imageNamed:array[i - 1]];
                PageModel *model = array[i -1];

                _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL,model.ad_img)]   placeholderImage:KSPLAIMAGE]:(imageView.image = [UIImage imageNamed:array[i - 1]]);
            }
            [self.imageViewArray addObject:imageView];
            [self.scrollView addSubview:imageView];
            contentSize = CGSizeMake((array.count + 2) * self.frame.size.width,0);
            startPoint = CGPointMake(self.frame.size.width, 0);
        }
    }else{ //1张图片
        for (int i = 0; i < array.count; i ++) {
            UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height)];
            [imageView setContentMode:UIViewContentModeScaleAspectFill];
            imageView.clipsToBounds = YES;

//            imageView.image = [UIImage imageNamed:array[i]];
            PageModel *model = array[i ];

            _isWebImage==YES?[imageView sd_setImageWithURL:[NSURL URLWithString:StringWithStr(URL_MANURL,model.ad_img)]placeholderImage:KSPLAIMAGE]:(imageView.image = [UIImage imageNamed:array[i]]);
            
            [self addSubview:imageView];
            [self.imageViewArray addObject:imageView];
        }
        contentSize = CGSizeMake(self.frame.size.width, 0);
        startPoint = CGPointZero;
    }
    //开始的偏移量跟内容尺寸
    self.scrollView.contentOffset = startPoint;
    self.scrollView.contentSize = contentSize;
    if (self.imageArray.count >1) {
        [self.imageViewArray removeObjectAtIndex:0];
        [self.imageViewArray removeObject:self.imageViewArray.lastObject];
    }
 
}

-(void)setUpPageControl:(NSArray *)array
{
//    NSLog(@"scrollView-frame:%f",self.scrollView.contentOffset.x);
    
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.superview.backgroundColor = [UIColor redColor];
    pageControl.numberOfPages = array.count;
    //默认是0
    pageControl.currentPage = 0;
    //自动计算大小尺寸
    CGSize pageSize = [pageControl sizeForNumberOfPages:array.count];
    pageControl.bounds = CGRectMake(0, 0, pageSize.width, pageSize.height);
    pageControl.center = CGPointMake(self.center.x, self.frame.size.height - 20);
//    pageControl.pageIndicatorTintColor =[UIColor whiteColor];
//    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor lightGrayColor];
    [pageControl addTarget:self action:@selector(pageChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:pageControl];
    if (array.count == 1) {
        pageControl.hidden = YES;
    }
    self.pageControl = pageControl;
}

-(void)pageChange:(UIPageControl *)page
{
    NSLog(@"%zd  & %f",page.currentPage,self.bounds.size.width);
    //获取当前页面的宽度
    CGFloat x = page.currentPage * self.bounds.size.width;
    //通过设置scrollView的偏移量来滚动图像
    [self.scrollView setContentOffset:CGPointMake(x, 0) animated:YES];
}


#pragma mark - Timer时间方法
-(void)startTimer
{
    if (!_duration) {
        self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }else{
        self.timer = [NSTimer timerWithTimeInterval:_duration target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
    }
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

-(void)updateTimer
{
    CGPoint newOffset = CGPointMake(self.scrollView.contentOffset.x  + CGRectGetWidth(self.scrollView.frame), 0);
    [self.scrollView setContentOffset:newOffset animated:YES];
}


#pragma mark - scrollView代理方法
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.x < self.frame.size.width) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width * (self.imageArray.count + 1), 0) animated:NO];
    }
    //偏移超过
    if (scrollView.contentOffset.x > self.frame.size.width * (self.imageArray.count + 1)) {
        [self.scrollView setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
    }
    int pageCount = scrollView.contentOffset.x / self.frame.size.width;
    
    if (pageCount > self.imageArray.count) {
        pageCount = 0;
    }else if (pageCount == 0){
        pageCount = (int)self.imageArray.count - 1;
    }else{
        pageCount--;
    }
    self.pageControl.currentPage = pageCount;
}

//手势点击
- (void)pageViewClick:(UITapGestureRecognizer *)tap
{
    NSLog(@"点击了第%ld页",self.pageControl.currentPage);
    [self.delegate didSelectPageViewWithNumber:self.pageControl.currentPage];
    if (![self.imageArray[0] isKindOfClass:[PageModel class]]) {
        return;
      
    }
    PageModel * model = self.imageArray[self.pageControl.currentPage];

    if (model.ad_link == nil) {
        [self base_ToViewLargerVersion:self.imageArray.count == 1? self: self.scrollView currentImageIndex:self.pageControl.currentPage imageCount:self.imageArray.count smlImage:[self getScrollerViewSubViewImageView] bigImageUrl:[self urlImagesArray]];
        return;
    }
    WebViewController * webView =[WebViewController new];
    webView.url_string = model.ad_link;
    webView.title = model.ad_name;
    [[KSTabBarController gitNavigationController] pushViewController:webView animated:YES];
}

- (UIImage *)getScrollerViewSubViewImageView{
    
   __block UIImage *image =nil;
    if (self.imageArray.count == 1) {
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[UIImageView class]]) {
                UIImageView *imageView = obj;
                image= imageView.image;
            }
        }];
    }else{
        UIImageView *imageView = self.imageViewArray [self.pageControl.currentPage];
        return imageView.image;
    }
    return image;
}

- (NSArray *)urlImagesArray{
    __block NSMutableArray *array = [NSMutableArray array];
    [self.imageArray enumerateObjectsUsingBlock:^(PageModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:@"%@%@",URL_MANURL,obj.ad_img]];
    }];
    return array;
}

static char objc_smlImage;
static char objc_bigImageUrl;
- (void)base_ToViewLargerVersion:(UIView *)view currentImageIndex:(NSInteger)currentImageIndex imageCount:(NSInteger )imageCount smlImage:(UIImage *)smlImage bigImageUrl:(NSArray< NSString *> *)bigImageUrl{
    objc_setAssociatedObject(self, &objc_smlImage, smlImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, &objc_bigImageUrl, bigImageUrl, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    SDPhotoBrowser *photoBrowser = [SDPhotoBrowser new];
    photoBrowser.delegate = self;
    photoBrowser.currentImageIndex = currentImageIndex;
    photoBrowser.imageCount = imageCount;
    photoBrowser.sourceImagesContainerView = view;
    
    [photoBrowser show];
    
}

#pragma mark  SDPhotoBrowserDelegate

// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
{
    UIImageView *imageView = self.imageViewArray [index];
    return imageView.image;
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index
{
    NSArray *array = objc_getAssociatedObject(self, &objc_bigImageUrl);
    
    NSString *urlStr = array[index];
    return [NSURL URLWithString:urlStr];
}

//停止滚动时
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
}


//开始拖动时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer invalidate];
}

//结束拖动时
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}





@end
