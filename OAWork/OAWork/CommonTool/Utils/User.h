//
//  User.h
//  ProductAduit
//
//  Created by james on 2017/3/17.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
+(User*)shareUser;
@property (nonatomic,strong) NSString *userID;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userType;
@property (nonatomic,strong) NSString *userSex;
@property (nonatomic,strong) NSString *userEmail;
@property (nonatomic,strong) NSString *userWechat;
@property (nonatomic,strong) NSString *responseProjectCount;
@property (nonatomic,strong) NSString *execuProjectCount;
@property (nonatomic,strong) NSString *handleProjectCount;
@property (nonatomic,strong) NSString *attenProectCount;
@property (nonatomic,strong) NSString *icon;
-(void)setInfoOfDic:(NSDictionary*)dic;
@end
