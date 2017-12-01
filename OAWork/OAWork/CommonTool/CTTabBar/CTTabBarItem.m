//
//  CTTabBarItem.m
//  CTFukeIphone
//
//  Created by cattsoft on 14-9-12.
//  Copyright (c) 2014年 cattsoft. All rights reserved.
//  tabBar单元(包含文字、图标)

#import "CTTabBarItem.h"
#import "Utils.h"

#define itemLength 25 //(iPhone6 || iPhone6Plus ? 30:(iPhone5?27:25))//图标

#define CTTabBarItemImageRatio 0.7

@interface CTTabBarItem ()

@property (nonatomic,strong) UIImageView *downloadImageView;
@property (nonatomic,strong) UIImageView *unReadMeesageView;
@end

@implementation CTTabBarItem

- (id)initWithFrame:(CGRect)frame entity:(CTTabBarEntity *)entity target:(id)target
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:11.0];
        
        self.entity = entity;
        self.delegate=target;
        
        [self setImage:[UIImage imageNamed:entity.normalImgName] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:entity.selectedImgName] forState:UIControlStateSelected];
        [self setImage:[UIImage imageNamed:entity.normalImgName] forState:UIControlStateHighlighted];
        [self setTitle:entity.titleStr forState:UIControlStateNormal];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[Utils colorWithHexString:@"#5dbed8"] forState:UIControlStateSelected];
        
//        float itemIconY = (iPhone6 || iPhone6Plus ? 5:( iPhone5 ? 3:2));
//        float itemTitleY = itemLength+itemIconY+(iPhone6 || iPhone6Plus || iPhone5 ? 5:2);
//        float bottomSapceH = frame.size.height - itemTitleY - 10;
//        itemIconY = (bottomSapceH + itemIconY)/2.0f;
//        itemTitleY = itemLength+itemIconY+(iPhone6 || iPhone6Plus || iPhone5 ? 5:2);
////        self.itemIcon = [[UIButton alloc]initWithFrame:CGRectMake((frame.size.width-itemLength)/2, itemIconY, itemLength, itemLength)];
//        self.itemIcon = [[UIButton alloc]initWithFrame:CGRectMake(0, itemIconY, frame.size.width, frame.size.height)];
//        [self addSubview:self.itemIcon];
//        
//        [self.itemIcon setTitle:[NSString stringWithFormat:@" %@", entity.titleStr] forState:UIControlStateNormal];
//        self.itemIcon.titleLabel.font = [UIFont boldSystemFontOfSize:14.0f];
//        self.itemTitle = [[UIButton alloc]initWithFrame:CGRectMake(0, itemTitleY, frame.size.width, 10)];
//        if(iPhone6 || iPhone6Plus){
//            [self.itemTitle.titleLabel setFont:[UIFont systemFontOfSize:14]];
//        }else{
//            [self.itemTitle.titleLabel setFont:[UIFont systemFontOfSize:12]];
//        }
//        [self.itemTitle setTitle:entity.titleStr forState:UIControlStateNormal];
//        [self addSubview:self.itemTitle];
//
//        [self setBackgroundImage:[CTCommonUtil generateImageWithColor:[CTCommonUtil convert16BinaryColor:@"#0c3f99"] size:CGSizeMake(1, 1)] forState:UIControlStateHighlighted];
//        [self setBackgroundImage:[CTCommonUtil generateImageWithColor:[CTCommonUtil convert16BinaryColor:@"#0c3f99"] size:CGSizeMake(1, 1)] forState:UIControlStateSelected];
        
        [self addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.itemIcon addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.itemTitle addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self setCurrentThemeUI];
        
    }
    return self;
}


- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageW = 20;
    CGFloat imageH = 17;
    CGFloat imageX = (contentRect.size.width-20)/2;
    CGFloat imageY = 5;
    
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - contentRect.size.height * CTTabBarItemImageRatio;
    CGFloat titleX = 0;
    CGFloat titleY = contentRect.size.height * CTTabBarItemImageRatio * 0.9;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
    
}

- (void)setIsModuleDownload:(BOOL)isModuleDownload
{
    _isModuleDownload = isModuleDownload;
    
    if (isModuleDownload) {
        
        [self upWithDownImageView:NO];
    }else {
        [_downloadImageView removeFromSuperview];
        _downloadImageView = nil;
    }
}

- (void)setIsModuleUpdate:(BOOL)isModuleUpdate
{
    _isModuleUpdate = isModuleUpdate;
    
    if (isModuleUpdate) {
        
        [self upWithDownImageView:YES];
    }else {
        [_downloadImageView removeFromSuperview];
        _downloadImageView = nil;
    }
    
}

- (UIImageView *)upWithDownImageView:(BOOL)isUp
{
    if (!_downloadImageView)
    {
        CGFloat wh = 13;
        CGFloat y =  self.imageView.frame.size.height -5;
        
#ifdef IOS_DEVICE_PAD
        CGFloat x = self.frame.size.width - wh - 15 - 70;
#else
        CGFloat x = self.frame.size.width - wh - 15;
#endif
        _downloadImageView = [[UIImageView alloc] initWithFrame:CGRectMake(x, y, wh, wh)];
        _downloadImageView.image = [UIImage imageNamed:(isUp ? @"module_update" : @"module_download")];
        [self addSubview:_downloadImageView];
    }
    
    return _downloadImageView;
}


-(void)clickAction:(UIButton *)button
{
    if([self.delegate respondsToSelector:@selector(selectedItemAction:)]){
        [self.delegate selectedItemAction:self.entity];
        
    }
}

- (void)setCurrentThemeUI
{
//    [self.itemIcon setImage:ThemeImage(_entity.normalImgName) forState:UIControlStateNormal];
//    [self.itemIcon setImage:ThemeImage(_entity.selectedImgName) forState:UIControlStateSelected];
//    [self.itemIcon setTitleColor:[Utils colorWithHexString:@"#808389"] forState:UIControlStateNormal];
//    [self.itemIcon setTitleColor:[Utils colorWithHexString:@"#BF161C"] forState:UIControlStateSelected];
//    [self.itemTitle setTitleColor:[Utils colorWithHexString:@"#808389"] forState:UIControlStateNormal];
//    [self.itemTitle setTitleColor:[Utils colorWithHexString:@"#BF161C"] forState:UIControlStateSelected];
    
//    [self setTitleColor:ThemeColor(kTabBarTitleColor) forState:UIControlStateNormal];
//    [self setTitleColor:ThemeColor(kTabBarSelectTitleColor) forState:UIControlStateSelected];
}

//更新tabbar的选中状态
-(void)updateTabBarItemState:(BOOL)flag
{
    [self setSelected:flag];
//    [self.itemIcon setSelected:flag];
//    [self.itemTitle setSelected:flag];
}
-(void)setIsHaveUnreadMessage:(BOOL)isHaveUnreadMessage{
 
    [self  shownOrHiddenUnreadMessageMark:!isHaveUnreadMessage];
  
    _isHaveUnreadMessage=isHaveUnreadMessage;
}
-(UIImageView*)shownOrHiddenUnreadMessageMark:(BOOL)isHidden{
    
    if (!_unReadMeesageView)
    {
        CGFloat wh = 8;
        CGFloat y = 8 ;

        _unReadMeesageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-8, y, 6, 6)];
        _unReadMeesageView.backgroundColor=[Utils colorWithHexString:@"#5dbed8"];
        _unReadMeesageView.layer.cornerRadius=wh/2;
        _unReadMeesageView.clipsToBounds=YES;
        [self addSubview:_unReadMeesageView];
    }
    [self bringSubviewToFront:_unReadMeesageView];
    _unReadMeesageView.hidden=isHidden;
    
    return _unReadMeesageView;

}

@end
