//
//  CTJSONKit.m
//  Frank
//
//  Created by FanFrank on 16/7/31.
//  Copyright © 2016年 com.frankfan. All rights reserved.
//

#import "CTJSONKit.h"

@implementation CTJSONKit

@end

@implementation NSString (CTJSONKitDeserializing)

- (id)objectFromCTJSONString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] objectFromCTJSONData];
}

@end


@implementation NSArray (CTJSONKitDeserializing)

- (NSString *)JSONStringFromCT {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSData *)JSONDataFromCT
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}

@end


@implementation NSDictionary (CTJSONKitSerializing)

- (NSString *)JSONStringFromCT {
    
    return [[NSString alloc] initWithData:[self JSONDataFromCT] encoding:NSUTF8StringEncoding];
}
- (NSData *)JSONDataFromCT
{
    return [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:nil];
}

@end

@implementation NSData (CTJSONKitSerializing)

- (id)objectFromCTJSONData {
    return [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableLeaves error:nil];
}

@end
