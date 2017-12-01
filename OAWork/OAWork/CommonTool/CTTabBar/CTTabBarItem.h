//
//  CTTabBarItem.h
//  CTFukeIphone
//
//  Created by cattsoft on 14-9-12.
//  Copyright (c) 2014年 cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTTabBarEntity.h"


@protocol CTTabBarItemDelegate <NSObject>
//点击tabitem事件
- (void)selectedItemAction:(CTTabBarEntity *)selectedEntity;
@end

@interface CTTabBarItem : UIButton
@property(nonatomic,retain)UIButton *itemIcon;//图标
@property(nonatomic,retain)UIButton *itemTitle;//文字
@property(nonatomic,retain)CTTabBarEntity *entity;
@property(nonatomic,retain)id<CTTabBarItemDelegate>delegate;

@property (nonatomic,assign) BOOL isModuleDownload; // 是否有模块下载
@property (nonatomic,assign) BOOL isModuleUpdate;   // 是否有模块更新
@property (nonatomic,assign) BOOL isHaveUnreadMessage;//是否有未读

- (id)initWithFrame:(CGRect)frame entity:(CTTabBarEntity *)entity target:(id)target;

//更新tabbar的选中状态
-(void)updateTabBarItemState:(BOOL)flag;

// 换主题
- (void)setCurrentThemeUI;

@end
