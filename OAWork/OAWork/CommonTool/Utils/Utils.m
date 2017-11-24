//
//  Utils.m
//  Infinitus
//
//  Created by issuser on 13-10-28.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import "Utils.h"

#import <sys/utsname.h>

#include <sys/sysctl.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <CommonCrypto/CommonDigest.h>
//#import "Reachability.h"
#import "NSFileManager+Extra.h"

#define BundleIdentifier  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]

@implementation Utils

+ (NSString *)appVersion {
    NSString *appVersion = nil;
    NSString *marketingVersionNumber = kBundleShortVersionString;
    NSString *developmentVersionNumber = kBundleVersionString;
    if (marketingVersionNumber && developmentVersionNumber) {
        if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
            appVersion = marketingVersionNumber;
        } else {
            appVersion = [NSString stringWithFormat:@"%@",marketingVersionNumber];
        }
    } else {
        appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
    }
    return appVersion;
}


+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


//+ (NSString *)getImageTitleWithTitle:(NSString *)title color:(NSInteger)colorTag
//{
//
//}

//获取一个随机整数
+(NSString *)getRandomCode
{
    int randomCode = (int)(1000 + (arc4random()%(10000 - 1000 + 1)));
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",randomCode] forKey:@"randomCode"];
    NSLog(@"randomCode : %d",randomCode);
    
    return [NSString stringWithFormat:@"%d",randomCode];
}

//获取当前日期，时间
+(NSDate *)getCurrentDate{
    NSDate *now = [NSDate date];
    return now;
}

//判断两个日期是否相同
+(BOOL)isSameDateBetweenLastDate:(NSDate *)lastDate
                  andCurrentDate:(NSDate *)currentDate
{
    BOOL isSame = NO;
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *lastDateString = [formatter stringFromDate:lastDate];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    if ([lastDateString isEqualToString:currentDateString]) {
        isSame = YES;
    }
//    [formatter release];
    
    return isSame;
}

+ (NSDate *)convertStringDate:(NSString *)stringDate format:(NSString *)format
{
    NSDate *date = nil;
    
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    date = [formatter dateFromString:stringDate];
//    [formatter release];
    
    return date;
}
+(NSString *)dateStringFromTimeSt:(NSString*)timeSpace{
    NSDate *date=[NSDate dateWithTimeIntervalSince1970:([[Utils convertNull:timeSpace] longLongValue]/1000)];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    return dateStr;
}
+(id)getNotNullNotNill:(id)objc{
    if (!objc) {
        objc= @"";
    }
    if ([objc isKindOfClass:[NSNull class]]) {
        objc=@"";
    }
    return objc;
}
+(NSMutableArray *)reGetSearchArrayOfArray:(NSArray*)anArray AndKey:(NSString*)key andSearchString:(NSString*)searchString{
    if (!searchString||[searchString isKindOfClass:[NSNull class]]||[searchString isEqualToString:@""]) {
        return   [NSMutableArray arrayWithArray:anArray];
    }
//     NSPredicate *preicate = [NSPredicate predicateWithFormat:@"%@ CONTAINS %@",key,searchString];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"content CONTAINS %@", searchString];
    //过滤数据
    NSMutableArray * searchedArray= [NSMutableArray arrayWithArray:[anArray filteredArrayUsingPredicate:preicate]];
    
    return  searchedArray;
};

// Returns a copy of the image that has been transformed using the given affine transform and scaled to the new size
// The new image's orientation will be UIImageOrientationUp, regardless of the current image's orientation
// If the new size is not integral, it will be rounded up
+(UIImage *)resizeImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height
{
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, width, height));
    //CGRect transposedRect = CGRectMake(0, 0,image.size.height, image.size.width);
    CGImageRef imageRef = image.CGImage;
    
    // Build a context that's the same dimensions as the new size
    CGContextRef bitmap = CGBitmapContextCreate(NULL,
                                                newRect.size.width,
                                                newRect.size.height,
                                                CGImageGetBitsPerComponent(imageRef),
                                                0,
                                                CGImageGetColorSpace(imageRef),
                                                CGImageGetBitmapInfo(imageRef));
    
    // Rotate and/or flip the image if required by its orientation
    //CGContextConcatCTM(bitmap, transform);
    
    // Set the quality level to use when rescaling
    // CGContextSetInterpolationQuality(bitmap, quality);
    
    // Draw into the context; this scales the image
    //CGContextDrawImage(bitmap, transpose ? transposedRect : newRect, imageRef);
    CGContextDrawImage(bitmap, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(bitmap);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    // Clean up
    CGContextRelease(bitmap);
    CGImageRelease(newImageRef);
    
    return newImage;
}
+(int)dayInWeekOfDate:(NSDate*)date{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
//    [_comps setDay:23];
//    [_comps setMonth:3];
//    [_comps setYear:2014];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
//    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSCalendarUnitWeekday fromDate:date];
    int _weekday = [weekdayComponents weekday];
    NSLog(@"_weekday::%d",_weekday);
    return _weekday;
}



+(NSString*)deviceString
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    NSLog(@"deviceString : %@",deviceString);
    
    //    //iPhone
    //    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    //    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    //    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    //    if ([deviceString hasPrefix:@"iPhone3"])            return @"iPhone 4";
    //    if ([deviceString hasPrefix:@"iPhone4"])            return @"iPhone 4S";
    //    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    //    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    //    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5c";
    //    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5c";
    //    if ([deviceString hasPrefix:@"iPhone6"])            return @"iPhone 5s";
    //
    //    //iPod Touch
    //    if ([deviceString hasPrefix:@"iPod1"])              return @"iPod Touch 1";
    //    if ([deviceString hasPrefix:@"iPod2"])              return @"iPod Touch 2";
    //    if ([deviceString hasPrefix:@"iPod3"])              return @"iPod Touch 3";
    //    if ([deviceString hasPrefix:@"iPod4"])              return @"iPod Touch 4";
    //    if ([deviceString hasPrefix:@"iPod5"])              return @"iPod Touch 5";
    //
    //    //iPad
    //    if ([deviceString hasPrefix:@"iPad1"])              return @"iPad 1";
    //    if ([deviceString isEqualToString:@"iPad2,1"])      return @"iPad 2 (WiFi)";
    //    if ([deviceString isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    //    if ([deviceString isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    //    if ([deviceString isEqualToString:@"iPad2,4"])      return @"iPad 2";
    //    if ([deviceString isEqualToString:@"iPad2,5"])      return @"iPad Mini";
    //    if ([deviceString isEqualToString:@"iPad2,6"])      return @"iPad Mini";
    //    if ([deviceString isEqualToString:@"iPad2,7"])      return @"iPad Mini";
    //    if ([deviceString isEqualToString:@"iPad3,1"])      return @"iPad 3";
    //    if ([deviceString isEqualToString:@"iPad3,2"])      return @"iPad 3";
    //    if ([deviceString isEqualToString:@"iPad3,3"])      return @"iPad 3";
    //    if ([deviceString isEqualToString:@"iPad3,4"])      return @"iPad 4";
    //    if ([deviceString isEqualToString:@"iPad3,5"])      return @"iPad 4";
    //    if ([deviceString isEqualToString:@"iPad3,6"])      return @"iPad 4";
    //    if ([deviceString isEqualToString:@"iPad4,1"])      return @"iPad Air";
    //    if ([deviceString isEqualToString:@"iPad4,2"])      return @"iPad Air";
    //    if ([deviceString isEqualToString:@"iPad4,4"])      return @"iPad Mini 2";
    //    if ([deviceString isEqualToString:@"iPad4,5"])      return @"iPad Mini 2";
    
    //Simulator
    //    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    //    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}



+ (NSString *)URLParamWithDict:(NSDictionary *)param
{
    NSMutableString *result = [NSMutableString string];
    
    for (NSString *key in param)
    {
        [result appendFormat:@"%@=%@&", key, [param objectForKey:key]];
    }
    if ([result length] > 0)
    {
        [result deleteCharactersInRange:NSMakeRange([result length] - 1, 1)];
    }
    
    return result;
}
+ (NSString *)URLEncode:(NSString *)originalString stringEncoding:(NSStringEncoding)stringEncoding
{
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:
                            @";", @"/", @"?", @":",
                            @"@", @"&", @"=", @"+", @"$", @",",
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:
                             @"%3B", @"%2F", @"%3F", @"%3A",
                             @"%40", @"%26", @"%3D", @"%2B", @"%24", @"%2C",
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    int len = [escapeChars count];
    
    NSMutableString *outStr = [NSMutableString stringWithString:[originalString stringByAddingPercentEscapesUsingEncoding:stringEncoding]];
    
    int i;
    for (i = 0; i < len; i++)
    {
        [outStr replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                                withString:[replaceChars objectAtIndex:i]
                                   options:NSLiteralSearch
                                     range:NSMakeRange(0, [outStr length])];
    }
    
    return outStr;
}

#pragma mark - Memory cache

static NSMutableDictionary *_theWebDataToRam = nil;
+ (void)saveMemory:(NSString *)sKey content:(id)content
{
    if (_theWebDataToRam == nil)
    {
        _theWebDataToRam = [[NSMutableDictionary alloc] init];
    }
    [_theWebDataToRam setObject:content forKey:sKey];
}

+ (id)readMemory:(NSString *)sKey
{
    return [_theWebDataToRam objectForKey:sKey];
}



+ (NSString *)getModuleIdentifier:(NSString *)identifier
{
#ifdef IOS_DEVICE_PAD
    identifier = [identifier stringByAppendingString:@".hd"];
#endif
    return identifier;
}

/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  @return
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

+ (id)convertNull:(id)value
{
    if (value != [NSNull null])
        return value;
    return nil;
}







+(NSString*)trim:(NSString*)value{
    return [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet] ];
}

+(BOOL)isValidateEmail:(NSString *)email {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)isIPAD{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}


+(BOOL)isIOS7{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0f);
}

+(BOOL)isIOS8{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0f);
}

+(BOOL)isIOS6{
    return ([[[UIDevice currentDevice] systemVersion] floatValue]>5.9f);
   
}

+ (NSString *)md5:(NSString*)str{
    
    if([str length]<1)
        return nil;
    
    const char *value = [str UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return [outputString lowercaseString];
}

+(NSString*)compareNowWithChineseString:(NSTimeInterval)thisTime{
    NSTimeInterval now=[[NSDate date] timeIntervalSince1970];
    if(now<thisTime){
        NSDateFormatter* formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy/MM/dd"];
        return [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:thisTime]];
    }
    else{
        NSInteger com=now-thisTime;
        if(com<3600){  //1小时前
            com=com/60;
            if(com<1)com=1;
            return [NSString stringWithFormat:@"%ld分钟前",(long)com];
        }
        else if(com<3600*24){     //1天前
            com=com/3600;
            if(com<1)com=1;
            return [NSString stringWithFormat:@"%ld小时前",(long)com];
        }
        else if(com<3600*24*7){     //1天前
            com=com/(3600*24);
            
            return [NSString stringWithFormat:@"%ld天前",(long)com];
        }else{
            NSDate *date=[NSDate dateWithTimeIntervalSince1970:thisTime];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setLocale:[NSLocale currentLocale]];
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStr = [dateFormatter stringFromDate:date];
            return dateStr;
        }
    }
}

//+ (BOOL)isEnbaleWifi
//{
//    return ([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable);
//}
//
//+ (BOOL)isEnbaleGprs
//{
//    return ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable);
//}
//
//+ (BOOL)isEnbaleNetwork
//{
//    if (([[Reachability reachabilityForLocalWiFi] currentReachabilityStatus] != NotReachable) || ([[Reachability reachabilityForInternetConnection] currentReachabilityStatus] != NotReachable) ) {
//        return YES;
//    }
//    
//    return NO;
//}

//+ (NSString *)appVersion {
//    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
//    NSString *appVersion = nil;
//    NSString *marketingVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
//    NSString *developmentVersionNumber = [bundle objectForInfoDictionaryKey:@"CFBundleVersion"];
//    if (marketingVersionNumber && developmentVersionNumber) {
//        if ([marketingVersionNumber isEqualToString:developmentVersionNumber]) {
//            appVersion = marketingVersionNumber;
//        } else {
//            appVersion = [NSString stringWithFormat:@"%@",marketingVersionNumber];
//        }
//    } else {
//        appVersion = (marketingVersionNumber ? marketingVersionNumber : developmentVersionNumber);
//    }
//    return appVersion;
//}

// 屏幕分辨率
+ (NSString *)deviceScreen
{
    
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)]) {
        CGSize result = [[UIScreen mainScreen] bounds].size;
        int width = (int)(result.width * [UIScreen mainScreen].scale);
        int height = (int)(result.height * [UIScreen mainScreen].scale);
        return  [NSString stringWithFormat:@"%dx%d",width,height];
    }
    return @"320x480";
}

//+(NSString*)deviceString
//{
//    struct utsname systemInfo;
//    uname(&systemInfo);
//    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
//
//    return deviceString;
//}

// 文字大小
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

// UUID 随机标识
+(NSString *)UUID
{
    NSString *UUID=[[NSUserDefaults standardUserDefaults] objectForKey:@"UUID"];
    if ([UUID isKindOfClass:[NSString class]]&&UUID.length>0) {
        return UUID;
    }else{
        CFUUIDRef uuidRef =CFUUIDCreate(NULL);
        
        CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
        
        CFRelease(uuidRef);
        
        UUID = [(__bridge NSString *)uuidStringRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
        
        CFRelease(uuidStringRef);
        [[NSUserDefaults standardUserDefaults] setObject:UUID forKey:@"UUID"];
        [[NSUserDefaults standardUserDefaults]  synchronize];
        
    }
    
    return UUID;
    
}
+(NSString*)randomUUID{
    NSString *UUID=@"";
    CFUUIDRef uuidRef =CFUUIDCreate(NULL);
    
    CFStringRef uuidStringRef =CFUUIDCreateString(NULL, uuidRef);
    
    CFRelease(uuidRef);
    
    UUID = [(__bridge NSString *)uuidStringRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    CFRelease(uuidStringRef);
    return UUID;
}



+ (BOOL) isBlankString:(NSString *)string
{
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+(NSString *)trimStr:(NSString *)str {
    return [[str stringByReplacingOccurrencesOfString:@"\r\n" withString:@"\n"] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

+(bool)isEmpty:(NSString *)str {
    if ([str isKindOfClass:[NSNumber class]]) {
        return NO;
    }
    if (str==nil || [str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self trimStr:str].length==0) {
        return YES;
    }
    return NO;
}

+(bool)isNotEmpty:(NSString *)str {
    return ![self isEmpty:str];
}

+(NSString*)getSavedInfoByDocumentExtension:(NSString*)pathExtenstion{//
    
    NSString *jsonPath = [[[NSFileManager applicationDocumentsDirectory] path] stringByAppendingPathComponent:pathExtenstion];
    BOOL isExist = [FS fileExistsAtPath:jsonPath];
    
    if (!isExist) {
        
        return nil;
    }else{
        NSString *strFuns = [NSString stringWithContentsOfFile:jsonPath encoding:NSUTF8StringEncoding error:nil];
        return strFuns;
    }
}
+(NSString *)platformString{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    
    return platform;
}
+(NSString *)lastDealerNo{
    
    NSString *dearNo = [[NSUserDefaults standardUserDefaults] objectForKey:@"dealerNo"];
    if([dearNo isKindOfClass:[NSString class]]&&[dearNo isEqualToString:@"ANONYMOUS"])
    {
        dearNo=@"";
    }
    if (!dearNo||(![dearNo isKindOfClass:[NSString class]])) {
        dearNo=@"";
    }
    return dearNo;
}

#pragma mark - 检查网络
//static dispatch_source_t _timer;
//+ (BOOL)checkNetwork:(void(^)())haveNetwork
//{
//    
//    Reachability *reachable = [Reachability reachabilityForInternetConnection];
//    
//    if (![reachable isReachable]) {
//        
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:KTitle message:kNotNetwork_New delegate:self cancelButtonTitle:@"去设置" otherButtonTitles:@"取消", nil];
//        [alertView show];
//        
//        if (_timer) dispatch_source_cancel(_timer);
//        
//        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
//        _timer = timer;
//        
//        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 5 * NSEC_PER_SEC, 5 * NSEC_PER_SEC);
//        
//        dispatch_source_set_event_handler(timer, ^{
//            if([reachable isReachable]){
//                if(alertView)[alertView dismissWithClickedButtonIndex:0 animated:YES];
//                if(haveNetwork)haveNetwork();
//                dispatch_source_cancel(timer);
//            }
//            NSLogD(@"我在运行！");
//        });
//        
//        dispatch_source_set_cancel_handler(timer, ^{
//            NSLogD(@"cancel");
//            _timer = nil;
//        });
//        //启动
//        dispatch_resume(timer);
//    }else if(haveNetwork)haveNetwork();
//    
//    return [reachable isReachable];
//}
+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}
@end
