//
//  CTTabBarView.m
//  CTFukeIphone
//
//  Created by cattsoft on 14-9-12.
//  Copyright (c) 2014年 cattsoft. All rights reserved.
//

#import "CTTabBarView.h"


@implementation CTTabBarView

- (id)initWithFrame:(CGRect)frame target:(id)target Entity:(NSArray *)entitys
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate=target;
        self.backgroundColor = [UIColor whiteColor];
        self.itemEntityArray = entitys;
        self.itemViewArray = [NSMutableArray arrayWithCapacity:4];
        
        CGFloat magin = 10;
        CGFloat fix = iPhone6 ? 5.0f : 0.0f;
        fix = iPhone6Plus ? 10.0f : fix;
//        fix = [Utils isIPAD] ? 15.0f : fix;
        
        magin = magin + fix;
        
        float eachWidth = (self.frame.size.width - 2*magin)/_itemEntityArray.count;
        for(int i=0;i<_itemEntityArray.count;i++){
            CTTabBarEntity *entity = [_itemEntityArray objectAtIndex:i];
            float x = magin + i*eachWidth;
            CTTabBarItem *item = [[CTTabBarItem alloc]initWithFrame:CGRectMake(x, 1, eachWidth, frame.size.height-1) entity:entity target:self];
            
            [self.itemViewArray addObject:item];
            [self addSubview:item];
//            if (i < [_itemEntityArray count]-1)
//            {
//                UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(item.frame.origin.x + item.frame.size.width-1, item.frame.origin.y, 1, item.frame.size.height)];
//                lineView.backgroundColor = [Utils colorWithHexString:@"#cccccc"];
//                [self addSubview:lineView];
//            }

            //以上两种方法配合CTMainViewController.m里面的函数selectedItemAction使用，按需要进行切换
        }
        
        // 分割线
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kMinPixels)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
    }
    return self;
}

- (void)setCurrentThemeUI
{
    self.backgroundColor = [UIColor lightGrayColor];
    for (CTTabBarItem *barItem in _itemViewArray) {
        [barItem setCurrentThemeUI];
    }
}

-(void)selectIndex:(int)index{
    if(index > _itemEntityArray.count-1){
        return;
    }
    CTTabBarEntity *entity = [_itemEntityArray objectAtIndex:index];
    [self selectedItemAction:entity];
}


//清除被选择的标识
-(void)cleanSelectFlag{
    for(int i=0;i<self.itemViewArray.count;i++){
        CTTabBarItem *view = [self.itemViewArray objectAtIndex:i];
        view.entity.isSelected=NO;
    }
}

// 设置是否显示下载
- (void)setIsModuleDownload:(BOOL)isModuleDownload withIndex:(int)index
{
    if(index > _itemEntityArray.count-1){
        return;
    }
    
    CTTabBarItem *view = [self.itemViewArray objectAtIndex:index];
    view.isModuleDownload = isModuleDownload;
}

// 设置是否显示更新
- (void)setIsModuleUpdate:(BOOL)isModuleUpdate withIndex:(int)index
{
    if(index > _itemEntityArray.count-1){
        return;
    }
    
    CTTabBarItem *view = [self.itemViewArray objectAtIndex:index];
    view.isModuleUpdate = isModuleUpdate;
}
-(void)showHaveUnreadMessage:(BOOL)unreadyMessage index:(int)index{
    if(index > _itemEntityArray.count-1||index<0){
        return;
    }
    CTTabBarItem *view = [self.itemViewArray objectAtIndex:index];
    view.isHaveUnreadMessage = unreadyMessage;
}
#pragma CTTabBarItem delegate method
- (void)selectedItemAction:(CTTabBarEntity *)selectedEntity{
    [self cleanSelectFlag];
    selectedEntity.isSelected=YES;
    if([self.delegate respondsToSelector:@selector(selectedItemAction:)]){
        [self.delegate selectedItemAction:selectedEntity];
    }
    [self updateTabBarItem];
}

-(void)updateTabBarItem{
    for(int i=0;i<self.itemViewArray.count;i++){
        CTTabBarItem *view = [self.itemViewArray objectAtIndex:i];
        [view updateTabBarItemState:view.entity.isSelected];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
