//
//  QBScrollableImageView.m
//  QBScrollableImageView
//
//  Created by Katsuma Tanaka on 2013/01/27.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "QBScrollableImageView.h"

@interface QBScrollableImageView ()

@property (nonatomic, retain) UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;

- (void)update;

@end

@implementation QBScrollableImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self) {
        // Scroll View
        UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        scrollView.delegate = self;
        scrollView.clipsToBounds = YES;
        scrollView.pagingEnabled = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.showsVerticalScrollIndicator = NO;
        scrollView.scrollsToTop = NO;
        scrollView.decelerationRate = 0;
        
        [self addSubview:scrollView];
        self.scrollView = scrollView;
        [scrollView release];
        
        // UIImageViewの設定
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.clipsToBounds = YES;
        
        [self.scrollView addSubview:imageView];
        self.imageView = imageView;
        [imageView release];
        
        // 2本指でのみスクロールできるようにする
        for(UIGestureRecognizer *gestureRecognizer in self.scrollView.gestureRecognizers) {
            if([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
                UIPanGestureRecognizer *panGestureRecognizer = (UIPanGestureRecognizer *)gestureRecognizer;
                panGestureRecognizer.minimumNumberOfTouches = 2;
            }
        }
        
        // 初期値の設定
        self.minimumZoomScale = 1.0;
        self.maximumZoomScale = 4.0;
    }
    
    return self;
}

- (void)setMinimumZoomScale:(CGFloat)minimumZoomScale
{
    self.scrollView.minimumZoomScale = minimumZoomScale;
}

- (CGFloat)minimumZoomScale
{
    return self.scrollView.minimumZoomScale;
}

- (void)setMaximumZoomScale:(CGFloat)maximumZoomScale
{
    self.scrollView.maximumZoomScale = maximumZoomScale;
}

- (CGFloat)maximumZoomScale
{
    return self.scrollView.maximumZoomScale;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    
    [self update];
}

- (UIImage *)image
{
    return self.imageView.image;
}

- (void)dealloc
{
    [_scrollView release];
    [_imageView release];
    
    [super dealloc];
}


#pragma mark - 

- (void)update
{
    if(self.image == nil) return;
    
    // ビューのサイズを調整
    CGSize filledImageSize = [QBScrollableImageView filledImageSizeWithImageSize:self.image.size containerSize:self.bounds.size];
    filledImageSize.width = round(filledImageSize.width);
    filledImageSize.height = round(filledImageSize.height);
    
    self.scrollView.contentSize = filledImageSize;
    self.imageView.frame = CGRectMake(0, 0, filledImageSize.width, filledImageSize.height);
    
    // 画像の中央が表示されるように調整する
    CGFloat offsetX = round((filledImageSize.width - self.frame.size.width) / 2.0);
    CGFloat offsetY = round((filledImageSize.height - self.frame.size.height) / 2.0);
    
    self.scrollView.contentOffset = CGPointMake(offsetX, offsetY);
}

+ (CGSize)filledImageSizeWithImageSize:(CGSize)imageSize containerSize:(CGSize)containerSize
{
    CGSize filledImageSize;
    
    if(containerSize.width > containerSize.height) {
        // QBScrollableImageViewのサイズが横>縦の場合
        filledImageSize = CGSizeMake(containerSize.width, (containerSize.width / imageSize.width) * imageSize.height);
        
        // 横に合わせて縦に余白ができるなら修正が必要
        if(filledImageSize.height < containerSize.height) {
            filledImageSize = CGSizeMake((containerSize.height / imageSize.height) * imageSize.width, containerSize.height);
        }
    } else {
        filledImageSize = CGSizeMake((containerSize.height / imageSize.height) * imageSize.width, containerSize.height);
        
        if(filledImageSize.width < containerSize.width) {
            filledImageSize = CGSizeMake(containerSize.width, (containerSize.width / imageSize.width) * imageSize.height);
        }
    }
    
    return filledImageSize;
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

@end
