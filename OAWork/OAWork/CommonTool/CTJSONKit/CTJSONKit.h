//
//  CTJSONKit.h
//  Frank
//
//  Created by FanFrank on 16/7/31.
//  Copyright © 2016年 com.frankfan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTJSONKit : NSObject

@end

@interface NSString (CTJSONKitDeserializing)

/** 
 * 请使用该方法解析JSON字符串，JSONKit解决方法有Unicode字符\u0000会导致解析出错
 */
- (id)objectFromCTJSONString;

@end

@interface NSArray (CTJSONKitDeserializing)

/**
 * 请使用该方法转义JSON字符串，JSONKit转义某些订单会闪退
 */
- (NSString *)JSONStringFromCT;

- (NSData *)JSONDataFromCT;

@end

@interface NSDictionary (CTJSONKitSerializing)

/**
 * 请使用该方法转义JSON字符串，JSONKit转义某些订单会闪退
 */
- (NSString *)JSONStringFromCT;
- (NSData *)JSONDataFromCT;
@end

@interface NSData (CTJSONKitSerializing)

/**
 * 请使用该方法解析JSON字符串，JSONKit解决方法有Unicode字符\u0000会导致解析出错
 */
- (id)objectFromCTJSONData;

@end
