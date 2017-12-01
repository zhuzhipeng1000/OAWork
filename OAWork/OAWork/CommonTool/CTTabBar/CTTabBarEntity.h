//
//  CTTabBarEntity.h
//  CTFukeIphone
//
//  Created by cattsoft on 14-9-12.
//  Copyright (c) 2014年 cattsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CTTabBarEntity : NSObject

@property(nonatomic,assign)int index;
@property(nonatomic,retain)NSString *titleStr;//标题
@property(nonatomic,retain)NSString *normalImgName;//未选中背景图片
@property(nonatomic,retain)NSString *selectedImgName;//选中背景图片
@property(nonatomic,retain)NSString *controllerName;//控制器名字
@property(nonatomic,assign)BOOL isSelected;//当前是否被选择
@property(nonatomic,retain)NSString *uri;//运行的模块
@property(nonatomic,retain)NSString *scrFile;//拷贝的包名

@end
