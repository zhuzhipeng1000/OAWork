//
//  MyRequest.h
//  ProductAduit
//
//  Created by JIME on 2017/3/14.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRequest : NSObject
#define kTimeOutInterval 3 // 请求超时的时间
typedef void (^SuccessBlock)(NSDictionary *dict, BOOL success); // 访问成功block
typedef void (^AFNErrorBlock)(NSError *error); // 访问失败block
+ (void)getRequestWithUrl:(NSString *)url andPara:(NSDictionary*)para isAddUserId:(BOOL)isAddUserID Success:(SuccessBlock)success fail:(AFNErrorBlock)fail;
+ (NSString*)getURLOfOriginalUrl:(NSString*)url andPara:(NSDictionary*)para shouldEncrypt:(BOOL)shouldEncrypt;
+(NSString*)pinUlrOfDic:(NSDictionary*)para;
@end
