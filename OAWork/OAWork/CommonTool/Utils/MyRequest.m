//
//  MyRequest.m
//  ProductAduit
//
//  Created by JIME on 2017/3/14.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "MyRequest.h"
#import <AFNetworking.h>
#import "Desthird.h"
#import "User.h"
#import "Utils.h"
#import "CTJSONKit.h"

@implementation MyRequest

+ (void)addHttpRequestHeader:(AFHTTPRequestSerializer *)afRequest{
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    [afRequest setValue:app_Version forHTTPHeaderField:@"version"];
    [afRequest setValue:[Utils UUID] forHTTPHeaderField:@"DeviceId"];
    [afRequest setValue:@"ios" forHTTPHeaderField:@"platform"];
    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([token isKindOfClass:[NSString class]]&&token.length>0) {
        [afRequest setValue:token forHTTPHeaderField:@"token"];
    }
    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
    if ([userId isKindOfClass:[NSString class]]&&userId.length>0) {
        [afRequest setValue:userId forHTTPHeaderField:@"userId"];
    }
    
}
+ (NSDictionary*)commonDic:(NSDictionary *)dic{
    
  
    NSMutableDictionary *Dic=[NSMutableDictionary dictionary];
  
    if (dic&&[dic isKindOfClass:[NSDictionary class]]) {

        Dic=[[NSMutableDictionary alloc]initWithDictionary:dic];
    }
     return Dic;
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
      // app版本
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];

    [Dic setObject:app_Version forKey:@"version"];
    [Dic setObject:[Utils UUID] forKey:@"DeviceId"];
    [Dic setObject:@"ios" forKey:@"platform"];
//    [Dic setObject:@"" forKey:@"paramStr"];

//    NSString *userId=[[NSUserDefaults standardUserDefaults] objectForKey:@"userId"];
//    if ([userId isKindOfClass:[NSString class]]&&userId.length>0) {
//        [Dic setObject:userId forKey:@"userId"];
//    }else{
//        [Dic setObject:@"" forKey:@"userId"];
//    }

    NSString *token=[[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if ([token isKindOfClass:[NSString class]]&&token.length>0) {
       [Dic setObject:token forKey:@"token"];
    }else{
       [Dic setObject:@"" forKey:@"token"];
    }
    
    return Dic;
}
+(AFHTTPSessionManager *)manager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
//    AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
//    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
//    //如果是需要验证自建证书，需要设置为YES
//    securityPolicy.allowInvalidCertificates = YES;
//    //validatesDomainName 是否需要验证域名，默认为YES；
//    //假如证书的域名与你请求的域名不一致，需把该项设置为NO
//    //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
//    securityPolicy.validatesDomainName = NO;
//    //validatesCertificateChain 是否验证整个证书链，默认为YES
//    //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
//    //GeoTrust Global CA
//    //    Google Internet Authority G2
//    //        *.google.com
//    //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
//    //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
////    manager.securityPolicy = securityPolicy;
    
    // 超时时间
    manager.requestSerializer.timeoutInterval = kTimeOutInterval;
    
    // 声明上传的是json格式的参数，需要你和后台约定好，不然会出现后台无法获取到你上传的参数问题
    manager.requestSerializer = [AFHTTPRequestSerializer serializer]; // 上传普通格式
    
    [self addHttpRequestHeader:manager.requestSerializer];
    // 声明获取到的数据格式
    manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
//        manager.responseSerializer = [AFJSONResponseSerializer serializer]; // AFN会JSON解析返回的数据
    // 个人建议还是自己解析的比较好，有时接口返回的数据不合格会报3840错误，大致是AFN无法解析返回来的数据
    return manager;
}
+ (void)getRequestWithUrl:(NSString *)url andPara:(NSDictionary*)para isAddUserId:(BOOL)isAddUserID Success:(SuccessBlock)success fail:(AFNErrorBlock)fail
{

    AFHTTPSessionManager *manager = [self manager];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self addHttpRequestHeader:manager.requestSerializer];
    if (isAddUserID) {
        if ([para isKindOfClass:[NSDictionary class]]&&para.count>0) {
            para=[[NSMutableDictionary alloc]initWithDictionary:para];
        }else{
            para=[NSMutableDictionary dictionary];
        }
        if ([User shareUser].ID) {
          [para setValue:[NSString stringWithFormat:@"%@",[User shareUser].ID] forKey:@"userId"];
        }
      
    }
    
    url=[self getURLOfOriginalUrl:url andPara:para shouldEncrypt:NO];
    [manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
        if(responseObject){
            
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            if ([dict[@"errrorCode"] intValue]==204) {
                [[NSNotificationCenter defaultCenter] postNotificationName:KClickOut object:nil];
                
            }
            success(dict,YES);
            NSLog(@"url:%@ /n success:%@",dict,url );
            
        } else {
           
                success(@{@"msg":@"暂无数据"}, NO);
           
        }
        
       });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"error");
        // 请求失败
        dispatch_async(dispatch_get_main_queue(), ^{
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"请求失败url:%@ /n success:%@",error,url );
            fail(error);
            //            });
            
        });
    }];
    
//    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//        // 这里可以获取到目前数据请求的进度
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        // 请求成功
////        dispatch_async(dispatch_get_main_queue(), ^{
//
//        if(responseObject){
//
//            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//            if ([dict[@"errrorCode"] intValue]==204) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:KClickOut object:nil];
//
//            }
//            success(dict,YES);
//                NSLog(@"url:%@ /n success:%@",dict,url );
//
//        } else {
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                  success(@{@"msg":@"暂无数据"}, NO);
//            });
//        }
////        });
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        // 请求失败
//        dispatch_async(dispatch_get_main_queue(), ^{
////            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                NSLog(@"请求失败url:%@ /n success:%@",error,url );
//                fail(error);
////            });
//
//        });
//    }];
//}
//+ (void)postRequestWithUrl:(NSString *)url andPara:(NSDictionary*)para Success:(SuccessBlock)success fail:(AFNErrorBlock)fail
//{
//    // 将请求参数放在请求的字典里
////    NSDictionary *param = @{@"phoneNumber":account, @"password":@"f379eaf3c831b04de153469d1bec345e"};
//    // 创建请求类
//    AFHTTPSessionManager *manager = [self manager];
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        [manager POST:url parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
//            // 这里可以获取到目前数据请求的进度
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                // 请求成功
//                if(responseObject){
//                    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//
//                    success(dict,YES);
//                } else {
//                    success(@{@"msg":@"暂无数据"}, NO);
//                }
//            });
//
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            // 请求失败
//              dispatch_async(dispatch_get_main_queue(), ^{
//                  fail(error);
//              });
//        }];
//
//    });
    
}
+ (void)postRequestWithUrl:(NSString *)url andPara:(NSDictionary*)para isAddUserId:(BOOL)isAddUserID Success:(SuccessBlock)success fail:(AFNErrorBlock)fail{
  
    AFHTTPSessionManager *manager = [self manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer]; //
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    [self addHttpRequestHeader:manager.requestSerializer];
    if (isAddUserID) {
        if ([para isKindOfClass:[NSDictionary class]]&&para.count>0) {
            para=[[NSMutableDictionary alloc]initWithDictionary:para];
        }else{
            para=[NSMutableDictionary dictionary];
        }
        if ([User shareUser].ID) {
            [para setValue:[NSString stringWithFormat:@"%@",[User shareUser].ID] forKey:@"userId"];
        }
        
    }
    
    url=[self getURLOfOriginalUrl:url andPara:para shouldEncrypt:NO];
    [manager POST:url parameters:para progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if(responseObject){
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                if ([dict[@"errrorCode"] intValue]==204) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:KClickOut object:nil];
                    
                }
                success(dict,YES);
                NSLog(@"url:%@ /n success:%@",dict,url );
                
            } else {
                
                success(@{@"msg":@"暂无数据"}, NO);
                
            }
            
        });
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error");
        // 请求失败
        dispatch_async(dispatch_get_main_queue(), ^{
            //            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSLog(@"请求失败url:%@ /n success:%@",error,url );
            fail(error);
            //            });
            
        });
    }];
}
+ (NSString*)getURLOfOriginalUrl:(NSString*)url andPara:(NSDictionary*)para shouldEncrypt:(BOOL)shouldEncrypt{
    
    NSString *ST=[MyRequest pinUlrOfDic:para];
    NSString *bb=ST;
     DLog(@"加密前参数%@",ST);
    if (shouldEncrypt) {
        bb=[Desthird TripleDES:ST encryptOrDecrypt:0];
    }
   
//    NSString *encodedValue = (NSString*)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil,
//                                                                                                  (CFStringRef)bb, nil,
//                                                                                                  (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
    NSString *encodedValue=bb;
    DLog(@"加密后参数%@",encodedValue);
    
//    url=[NSString stringWithFormat:@"http://120.78.204.130%@?%@",url,encodedValue];
     url=[NSString stringWithFormat:@"http://120.78.204.130%@",url];
    return url;
  
}
+(NSString*)pinUlrOfDic:(NSDictionary*)para{
    NSString* url=@"";
    para=[MyRequest commonDic:para];
    
    NSArray *Arr=para.allKeys;
    for (int d=0; d<Arr.count; d++) {
        if (d==0) {
            url=[NSString stringWithFormat:@"%@%@=%@",url,Arr[d],para[Arr[d]]];
        }else
            url=[NSString stringWithFormat:@"%@&%@=%@",url,Arr[d],para[Arr[d]]];
    }
    
    return  url;


}

@end
