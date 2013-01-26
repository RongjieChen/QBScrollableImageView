//
//  QBScrollableImageView.h
//  QBScrollableImageView
//
//  Created by Katsuma Tanaka on 2013/01/27.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QBScrollableImageView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) CGFloat minimumZoomScale;
@property (nonatomic, assign) CGFloat maximumZoomScale;
@property (nonatomic, retain) UIImage *image;

+ (CGSize)filledImageSizeWithImageSize:(CGSize)imageSize containerSize:(CGSize)containerSize;

@end
