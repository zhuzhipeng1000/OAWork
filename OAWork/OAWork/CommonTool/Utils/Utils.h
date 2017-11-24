//
//  Utils.h
//  Infinitus
//
//  Created by issuser on 13-10-28.
//  Copyright (c) 2013年 zhangli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CommonCrypto/CommonCryptor.h>


@interface Utils : NSObject

+ (NSString *)appVersion;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIImage *)createImageWithColor:(UIColor *)color;

//获取一个随机整数
+(NSString *)getRandomCode;

//获取当前日期，时间
+(NSDate *)getCurrentDate;

//判断两个日期是否相同
+(BOOL)isSameDateBetweenLastDate:(NSDate *)lastDate
                  andCurrentDate:(NSDate *)currentDate;

// 转换字符串日期为NSDate
+ (NSDate *)convertStringDate:(NSString *)stringDate format:(NSString *)format;

+(UIImage *)resizeImage:(UIImage *)image width:(CGFloat)width height:(CGFloat)height;


+(int)dayInWeekOfDate:(NSDate*)date;

+(NSString*)deviceString;



/**
 * 把字典转成url参数，如key1=value1&key2=value2
 */
+ (NSString *)URLParamWithDict:(NSDictionary *)param;

#pragma mark - Memory cache

+ (void)saveMemory:(NSString *)sKey content:(id)content;

+ (id)readMemory:(NSString *)sKey;


/**
 * 获取模块标识，当iPad时传入的标识追加“.hd”
 */
+ (NSString *)getModuleIdentifier:(NSString *)identifier;

/**
 *  获取当前屏幕显示的viewcontroller
 *
 *  
 */
+ (UIViewController *)getCurrentVC;

/**
 * null对象时返回nil
 */
+ (id)convertNull:(id)value;


#pragma mark - 教育网
//截取字符串
+(NSString*)trim:(NSString*)value;

//是否有效email
+(BOOL)isValidateEmail:(NSString *)email;

//判断是否ipad
+(BOOL)isIPAD;


//判断是否ios7以上版本
+(BOOL)isIOS7;

//判断是否ios8以上版本
+(BOOL)isIOS8;

//判断是否ios6以上版本
+(BOOL)isIOS6;

//md5编码一个字符串
+ (NSString *)md5:(NSString*)str;

//返回中文的多少分钟前
+(NSString*)compareNowWithChineseString:(NSTimeInterval)thisTime;

// 是否开启wifi
+ (BOOL)isEnbaleWifi;

// 是否开启gprs
+ (BOOL)isEnbaleGprs;

// 是否开启网络
+ (BOOL)isEnbaleNetwork;

// 应用版本
//+ (NSString *)appVersion;

// 屏幕分辨率
+ (NSString *)deviceScreen;

// 设备型号
//+(NSString*)deviceString;

// 文字大小
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;

// UUID 随机标识
+(NSString *)UUID;

+(NSString*)randomUUID;

+ (BOOL) isBlankString:(NSString *)string;

+(NSString *)trimStr:(NSString *)str;

+(bool)isEmpty:(NSString *)str;

+(bool)isNotEmpty:(NSString *)str;

+(NSString*)getSavedInfoByDocumentExtension:(NSString*)pathExtenstion;//获取初始话接口保存的数据

+(NSString *)platformString;

+(NSString *)lastDealerNo;

+(NSString *)dateStringFromTimeSt:(NSString*)timeSpace;
+(id)getNotNullNotNill:(id)objc;
+(NSMutableArray *)reGetSearchArrayOfArray:(NSArray*)anArray AndKey:(NSString*)key andSearchString:(NSString*)searchString;
/**
 *  检查网络
 *  creat by 关伟洪 2016/09/07
 *  @param haveNetwork 回调
 *
 *  @return BOOL 有网络 ：true 否则 false
 */
+ (BOOL)checkNetwork:(void(^)())haveNetwork;

+ (UIImage*)GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height;
@end
