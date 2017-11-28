//
//  Desthird.h
//  ProductAduit
//
//  Created by james on 2017/3/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Security/Security.h>
#import "GTMBase64.h"

@interface Desthird : NSObject
+ (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt;
@end
