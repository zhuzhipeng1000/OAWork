//
//  CTTabBarView.h
//  CTFukeIphone
//
//  Created by cattsoft on 14-9-12.
//  Copyright (c) 2014年 cattsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CTTabBarEntity.h"
#import "CTTabBarItem.h"

@protocol CTTabBarViewDelegate <NSObject>
//点击tabitem事件
- (void)selectedItemAction:(CTTabBarEntity *)selectedEntity;
@end

@interface CTTabBarView : UIView

@property(nonatomic,retain) UIView *controllerView;
@property (nonatomic, assign) id<CTTabBarViewDelegate> delegate;
@property(nonatomic,retain) NSArray *itemEntityArray;
@property(nonatomic,retain) NSMutableArray *itemViewArray;

- (id)initWithFrame:(CGRect)frame target:(id)target Entity:(NSArray *)entitys;

-(void)selectIndex:(int)index;
// 换主题
- (void)setCurrentThemeUI;

// 设置是否显示下载
- (void)setIsModuleDownload:(BOOL)isModuleDownload withIndex:(int)index;

// 设置是否显示更新
- (void)setIsModuleUpdate:(BOOL)isModuleUpdate withIndex:(int)index;
//是否显示有未读消息
-(void)showHaveUnreadMessage:(BOOL)unreadyMessage index:(int)index;
@end
