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
    if ([[dic allKeys] indexOfObject:@"id"] != NSNotFound) {
        
        shareUser.userID =[NSString stringWithFormat:@"%@",dic[@"id"]];
    }
    if ([[dic allKeys] indexOfObject:@"name"] != NSNotFound) {
        shareUser.userName = dic[@"name"];
    }
    if ([[dic allKeys] indexOfObject:@"userType"] != NSNotFound) {
        shareUser.userType = dic[@"userType"];
    }
    if ([[dic allKeys] indexOfObject:@"sex"] != NSNotFound) {
        shareUser.userSex = dic[@"sex"];
    }
    if ([[dic allKeys] indexOfObject:@"email"] != NSNotFound) {
        shareUser.userEmail = dic[@"email"];
    }
    if ([[dic allKeys] indexOfObject:@"wechat"] != NSNotFound) {
        shareUser.userWechat = dic[@"wechat"];
    }
    if ([[dic allKeys] indexOfObject:@"responseProjectCount"] != NSNotFound) {
        shareUser.responseProjectCount = dic[@"responseProjectCount"];
    }
    if ([[dic allKeys] indexOfObject:@"execuProjectCount"] != NSNotFound) {
        shareUser.execuProjectCount = dic[@"execuProjectCount"];
    }
    if ([[dic allKeys] indexOfObject:@"handleProjectCount"] != NSNotFound) {
        shareUser.handleProjectCount = dic[@"handleProjectCount"];
    }
    if ([[dic allKeys] indexOfObject:@"attenProectCount"] != NSNotFound) {
        shareUser.attenProectCount = dic[@"attenProectCount"];
    }
    if ([[dic allKeys] indexOfObject:@"icon"] != NSNotFound) {
        shareUser.icon = dic[@"icon"];
    }else{
        shareUser.icon = @"";
    }

}
- (id)convertNull:(id)value
{
    if (value != [NSNull null])
        return value;
    return nil;
}
@end
