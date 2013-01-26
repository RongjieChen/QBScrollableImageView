//
//  ViewController.m
//  QBScrollableImageView
//
//  Created by Katsuma Tanaka on 2013/01/27.
//  Copyright (c) 2013年 Katsuma Tanaka. All rights reserved.
//

#import "ViewController.h"

// Views
#import "QBScrollableImageView.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    QBScrollableImageView *imageView = [[QBScrollableImageView alloc] initWithFrame:CGRectMake(20, 40, 280, 210)];
    imageView.image = [UIImage imageNamed:@"cat.png"];
    imageView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    
    [self.view addSubview:imageView];
    [imageView release];
}

@end
