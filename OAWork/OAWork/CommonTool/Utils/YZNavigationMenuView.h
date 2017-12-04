//
//  YZNavigationMenuView.h
//  YZNavigationMenuView
//
//  Created by holden on 2016/12/25.
//  Copyright © 2016年 holden. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YZNavigationMenuViewDelegate;


@interface YZNavigationMenuView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,assign)  int type;
@property (nonatomic, assign) id<YZNavigationMenuViewDelegate>delegate;
@property (nonatomic,assign) NSTextAlignment textLabelTextAlignment;
@property (nonatomic,strong) UIColor *cellColor;
/**
 点击每一栏时通过block回调,索引从0开始,
 */
@property (nonatomic, copy) void (^clickedBlock)(NSInteger index);

/**
 初始化对象

 @param point 箭头指向的位置
 @param imageArray image对象或者图片名称
 @param titleArray 显示的标题, titleArray和imageArray的个数需保持一致
 @return 初始化对象
 */
- (instancetype)initWithPositionOfDirection:(CGPoint)point images:(NSArray *)imageArray titleArray:(NSArray<NSString *> *)titleArray andType:(int)type;

@end

@protocol YZNavigationMenuViewDelegate <NSObject>

@optional

/**
 点击每一栏时通过代理回调

 @param menuView self
 @param index 每一栏的索引,从0开始,
 */
- (void)navigationMenuView:(YZNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index;
-(void)didiSelextNames:(NSMutableArray*)names;

@end
