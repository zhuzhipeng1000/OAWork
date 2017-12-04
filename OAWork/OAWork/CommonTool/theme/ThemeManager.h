//
//  ThemeManager.h
//  Infinitus
//
//  Created by issuser on 13-10-30.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "SkinThemeContent.h"

#define DEFAULT_THEME               @"春天"
#define SUMMER_THEME    @"夏天"
#define AUTUMN_THEME    @"秋天"
#define WINTER_THEME    @"冬天"
#define THEME_SELECT                @"CurrentThemeName"

//主题对应的主题色
#define     SPRING      @"春天"
#define     SUMMER      @"夏天"
#define     AUTUMN      @"秋天"
#define     WINTER      @"冬天"

#define     SPRINGCOLOR  @"#e7f8c2"
#define     SUMMERCOLOR  @"#e6efff"
#define     AUTUMNCOLOR  @"#fff4d4"
#define     WINTERCOLOR  @"#ffe8e8"




// 南航皮肤代码 begin
#ifndef _SYSTEMCONFIGURATION_H
#error  You should include the `SystemConfiguration` framework and \
add `#import <SystemConfiguration/SystemConfiguration.h>`\
to the header prefix.
#endif

#ifdef _SYSTEMCONFIGURATION_H
extern NSString * const ThemeDidChangeNotification;
#endif

#define kThemeRed       @"red"
#define kThemeBlue      @"blue"
#define kThemeBlack     @"black"

#define IMAGE(imagePath) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(imagePath) ofType:@"png"]]

typedef enum {
    ThemeStatusWillChange = 0, // todo
    ThemeStatusDidChange,
} ThemeStatus;

// end

#define ThemeImage(imageName) [[ThemeManager sharedManager] imageWithImageName:(imageName)]

#define kNotThemeImage(imageName) [UIImage imageNamed:imageName]

#define ThemeColor(name) [[ThemeManager sharedManager] colorWithName:(name)]

#define ThemeHexColor(name) [[ThemeManager sharedManager] hexColorWithName:(name)]

@interface ThemeManager : NSObject

@property (nonatomic, retain) NSString *currentThemeName;
@property (strong, nonatomic) NSString *theme;

+ (ThemeManager *)sharedManager;

+ (ThemeManager *)sharedInstance; // 南航

/**
 *根据图片名，获取图片。具体实现：拼接枚举和拓展名得到完整的图片名
 *@param 图片名，注意不要传拓展名
 *@return UIImage
 */
- (UIImage *)imageWithImageName:(NSString *)imageName;

/**
 * 读取主题包颜色配置文件的颜色
 * @param name 要获取颜色的key
 * @return UIColor
 */
- (UIColor *)colorWithName:(NSString *)name;
/**
 * 读取主题包颜色配置文件的16进制颜色
 * @param name 要获取颜色的key
 * @return NSString
 */
- (NSString *)hexColorWithName:(NSString *)name;
/**
 * 获取当前主题色
 * @return NSString
 */
- (NSString *)currentThemeColor;
@end
