//
//  BackButton.m
//  GbssApps-IOS
//
//  Created by wenninghui on 16/5/5.
//
//

#import "BackButton.h"

@implementation BackButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 9;
    CGFloat imageH = 16;
    CGFloat imageX = -10;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleW = contentRect.size.width - 10 - 9 - 5;
    CGFloat titleH = contentRect.size.height ;
    CGFloat titleX = 5;
    CGFloat titleY = 0;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

@end
