//
//  User.m
//  ProductAduit
//
//  Created by james on 2017/3/17.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "User.h"

@implementation User
static User* shareUser = nil;
+(User*)shareUser{
    @synchronized(self){
        if(shareUser == nil) {
            shareUser = [[self alloc] init];// assignment not done here
        }
    }
    return shareUser;
}
-(void)setInfoOfDic:(NSDictionary*)dic{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return;
    }
    if ([[dic allKeys] indexOfObject:@"ACCOUNT"] != NSNotFound) {
        
        shareUser.ACCOUNT =[NSString stringWithFormat:@"%@",dic[@"ACCOUNT"]];
    }
    if ([[dic allKeys] indexOfObject:@"DEGREE_LEVEL"] != NSNotFound) {
        shareUser.DEGREE_LEVEL = [NSString stringWithFormat:@"%@",dic[@"DEGREE_LEVEL"]];
    }
    if ([[dic allKeys] indexOfObject:@"GENDER"] != NSNotFound) {
        shareUser.GENDER =[NSString stringWithFormat:@"%@", dic[@"GENDER"]];
    }
    if ([[dic allKeys] indexOfObject:@"ID"] != NSNotFound) {
        shareUser.ID = [NSString stringWithFormat:@"%@",dic[@"ID"]];
    }
    if ([[dic allKeys] indexOfObject:@"NAME"] != NSNotFound) {
        shareUser.NAME = dic[@"NAME"];
    }
    if ([[dic allKeys] indexOfObject:@"ORG_ID"] != NSNotFound) {
        shareUser.ORG_ID = [NSString stringWithFormat:@"%@",dic[@"ORG_ID"]];
    }
    if ([[dic allKeys] indexOfObject:@"ORG_NAME"] != NSNotFound) {
        shareUser.ORG_NAME = dic[@"ORG_NAME"];
    }
    if ([[dic allKeys] indexOfObject:@"PWD_ERR_LOCK"] != NSNotFound) {
        shareUser.PWD_ERR_LOCK =[NSString stringWithFormat:@"%@", dic[@"PWD_ERR_LOCK"]];
    }
    if ([[dic allKeys] indexOfObject:@"PWD_ERR_NUM"] != NSNotFound) {
        shareUser.PWD_ERR_NUM =[NSString stringWithFormat:@"%@", dic[@"PWD_ERR_NUM"]];
    }
    if ([[dic allKeys] indexOfObject:@"PWD_LIMIT_DATE"] != NSNotFound) {
        shareUser.PWD_LIMIT_DATE =[NSString stringWithFormat:@"%@", dic[@"PWD_LIMIT_DATE"]];
    }
    if ([[dic allKeys] indexOfObject:@"STATUS"] != NSNotFound) {
        shareUser.STATUS =[NSString stringWithFormat:@"%@", dic[@"STATUS"]];
    }

}
- (id)convertNull:(id)value
{
    if (value != [NSNull null])
        return value;
    return nil;
}
@end
