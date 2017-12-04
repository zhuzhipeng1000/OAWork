//
//  ThemeManager.m
//  Infinitus
//
//  Created by issuser on 13-10-30.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "ThemeManager.h"
#import "Utils.h"
#import "iConsole.h"

const NSString *ThemeChangeNotification = @"Infinitus.theme.change";
// 南航
NSString * const ThemeDidChangeNotification = @"me.ilvu.theme.change";

@interface ThemeManager()

@property (nonatomic, retain) NSString *currentColorPath;
@property (nonatomic, retain) NSArray *defaultColors;
@property (nonatomic, retain) NSArray *currentColors;

@end

@implementation ThemeManager

@synthesize currentThemeName = _currentThemeName;
@synthesize theme = _theme;

- (void)dealloc
{
    self.currentThemeName = nil;
    self.currentColorPath = nil;
    self.defaultColors = nil;
    self.currentColors = nil;
    
//    [super dealloc];
}

+ (ThemeManager *)sharedManager
{
    static dispatch_once_t once;
    static ThemeManager *instance = nil;
    dispatch_once( &once, ^{ instance = [[ThemeManager alloc] init]; } );
    return instance;
}

+ (ThemeManager *)sharedInstance
{
    return [self sharedManager];
}

- (UIImage *)imageWithImageName:(NSString *)imageName
{
    self.currentThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:THEME_SELECT];
    if ([_currentThemeName isEqualToString:DEFAULT_THEME])
    {
        imageName = [NSString stringWithFormat:@"%@", imageName];
    }
    else
    {
        imageName = [NSString stringWithFormat:@"%@", imageName];
    }

    UIImage *result = [UIImage imageWithContentsOfFile:[self filePahtWithFileName:imageName themeName:_currentThemeName]];
    if (!result)
    {
        NSString *directory = [NSString stringWithFormat:@"%@/%@", @"www/theme", [self theme]];
        
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:imageName
                                                              ofType:@"png"
                                                         inDirectory:directory];
        
        result = [[UIImage imageWithContentsOfFile:imagePath] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 12)];
    }
    if (!result) {
        result = [UIImage imageNamed:imageName];
    }
    return result;
}

- (UIColor *)colorWithName:(NSString *)name
{
    NSString *hexColor = [self hexColorWithName:name];
    if (hexColor)
        return [Utils colorWithHexString:hexColor];
    return nil;
}

- (NSString *)hexColorWithName:(NSString *)name
{
    NSString *color = nil;
    NSError *error = nil;
    self.currentThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:THEME_SELECT];
    
    // 默认主题
    if (!_defaultColors)
    {
        NSString *filePath = [self filePahtWithFileName:@"configure.xml" themeName:DEFAULT_THEME];
        
           
    }
    
    if ([_currentThemeName isEqualToString:DEFAULT_THEME])
    {
        color = [self getHexColorWithName:name colors:_defaultColors];
    }
    else
    {
        NSString *filePath = [self filePahtWithFileName:@"configure.xml" themeName:_currentThemeName];
        // 当前主题没有解析过颜色或主题有改变时重新读取
        if (!_currentColors || filePath != _currentColorPath)
        {
            self.currentColorPath = filePath;
            
                
        }
        color = [self getHexColorWithName:name colors:_currentColors];
        if (!color) // 当前主题没颜色时，从默认主题获取
        {
            color = [self getHexColorWithName:name colors:_defaultColors];
        }
    }
    
    return color;
}

- (NSString *)getHexColorWithName:(NSString *)name colors:(NSArray *)colors
{
    for (NSDictionary *dict in colors)
    {
        if ([[dict objectForKey:@"name"] isEqualToString:name])
        {
            return [dict objectForKey:@"text"];
        }
    }
    return nil;
}

- (NSString *)filePahtWithFileName:(NSString *)fileName themeName:(NSString *)currentThemeName
{
    NSString *filePath = nil;
    if ([currentThemeName isEqualToString:DEFAULT_THEME]) {
        filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    }else if ([currentThemeName isEqualToString:SUMMER_THEME]){
        filePath = [[NSBundle mainBundle]
                     pathForResource:fileName
                     ofType:nil
                     inDirectory:@"summer"];
    }else if ([currentThemeName isEqualToString:AUTUMN_THEME]){
        filePath = [[NSBundle mainBundle]
                     pathForResource:fileName
                     ofType:nil
                     inDirectory:@"autumn"];
    }else if ([currentThemeName isEqualToString:WINTER_THEME]){
        filePath = [[NSBundle mainBundle]
                     pathForResource:fileName
                     ofType:nil
                     inDirectory:@"winter"];
    }else{
//        NSFileManager *fileMamager = [NSFileManager defaultManager];
//        NSString *cachePath = [NSHomeDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",THEME_DOWNLOAD_CACHES_PATH,currentThemeName]];
//        
//        NSArray *pathArray = [fileMamager subpathsAtPath:cachePath];
//        NSString *subPath = [pathArray objectAtIndex:0];
//        //NSLog(@"subpath :%@",subPath);
//        cachePath = [cachePath stringByAppendingPathComponent:subPath];
//        
//        filePath = [cachePath stringByAppendingPathComponent:fileName];
//        NSLog(@"%@",filePath);
    }
    return filePath;
}

#pragma mark - 南航

- (void)setTheme:(NSString *)theme
{
    if (_theme) {
        _theme=nil;
    }
    _theme = [theme copy];
    // post notification to notify the observers that the theme has changed
    ThemeStatus status = ThemeStatusDidChange;
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"ChangeTheme" object:[NSNumber numberWithInt:status]]];
    
    
    [[NSUserDefaults standardUserDefaults] setObject:theme forKey:@"setting.theme"];
}

- (NSString *)theme
{
    _theme = [[NSUserDefaults standardUserDefaults] objectForKey:@"setting.theme"];
    
    if ( _theme == nil )
    {
        return @"default";
    }
    return _theme;
}

- (NSString *)currentThemeColor
{
    NSString *currentThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:THEME_SELECT];
    
    if ([currentThemeName isEqualToString:SUMMER]) {
        return  SUMMERCOLOR;
    }else if ([currentThemeName isEqualToString:AUTUMN]){
        return  AUTUMNCOLOR;
    }else if ([currentThemeName isEqualToString:WINTER]){
        return WINTERCOLOR;
    }else {
        //    关伟洪 2016/08/29 移除
        return SPRINGCOLOR;
        
    }
    
}

@end
