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
@property (nonatomic,strong) NSString *ACCOUNT;
@property (nonatomic,strong) NSString *ACCOUNT_LMT_DATE;
@property (nonatomic,strong) NSString *DEGREE_LEVEL;
@property (nonatomic,strong) NSString *GENDER;
@property (nonatomic,strong) NSString *ID;
@property (nonatomic,strong) NSString *NAME;
@property (nonatomic,strong) NSString *ORG_ID;
@property (nonatomic,strong) NSString *ORG_NAME;
@property (nonatomic,strong) NSString *PASSWORD;
@property (nonatomic,strong) NSString *PWD_ERR_LOCK;
@property (nonatomic,strong) NSString *PWD_ERR_NUM;
@property (nonatomic,strong) NSString *PWD_LIMIT_DATE;
@property (nonatomic,strong) NSString *STATUS;
@property (nonatomic,strong) NSString *icon;
@property (nonatomic,strong) NSMutableArray *selectdFiles;
-(void)setInfoOfDic:(NSDictionary*)dic;
@end
