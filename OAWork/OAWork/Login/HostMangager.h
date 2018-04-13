//
//  HostMangager.h
//  ProductAduit
//
//  Created by james on 2017/3/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HostMangager : NSObject
//1、审核公文

+(NSString*)auditOAUrl;
//2、新建公文

+(NSString*)newOaUrl;
//3、公文类型列表

+(NSString*)oaTypeListUrl;
//4、公文列表

+(NSString*)oaListUrl;
//5、公文详细

+(NSString*)oaDetailUrl;
//6、提交公文列表
+(NSString*)submitOptionUrl;
//#### 7、登录
+(NSString*)loginUrl;
//8、重置密码

+(NSString*)resetPasswdUrl;
//9.首页统计接口
+(NSString*)mainIndexUrl;
//10.我的公文数量统计接口
+(NSString*)countMyWorkItems;
//11.搜索公文接口
+(NSString*)searchWorkItems;
//12查看流程接口
+ (NSString*)findFormsetInstFlow;
//资料上传
+ (NSString*)addFile;
//创建文件夹
+ (NSString*)addFolder;
//资料库文件列表
+ (NSString*)findFolder;
//资料库概况
+ (NSString*)findUserDatabanks;
//资料库文件订阅
+ (NSString*)findUserFiles;
//资料库文件操作
+ (NSString*)operateFile;
//文件上传
+ (NSString*)upload;
//公告详细接口
+ (NSString*)noticeDetail;
//公告列表
+ (NSString*)noticeList;
//更新公告查看状态
+ (NSString*)noticeUpdateViewStatus;
//新建日程
+ (NSString*)addSchedule;
//查询日程
+ (NSString*)findSchedule;
//通讯录分组
+ (NSString*)findUserGroup;
//通讯录联系人
+ (NSString*)findUsersByGroup;
//更新编辑日程
+ (NSString*)updateSchedule;
//修改个人资料
+ (NSString*)updaterUserInfo;
//头像上传接口
+ (NSString*)userUpload;

@end
