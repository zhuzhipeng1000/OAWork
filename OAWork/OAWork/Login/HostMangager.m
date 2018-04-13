//
//  HostMangager.m
//  ProductAduit
//
//  Created by james on 2017/3/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "HostMangager.h"

@implementation HostMangager
//1、审核公文

+(NSString*)auditOAUrl{
    return @"/flow/audit";
}
//2、新建公文

+(NSString*)newOaUrl{
    return @"/flow/call";
}
//3、公文类型列表

+(NSString*)oaTypeListUrl{
    return @"/flow/category/list";
}
//4、公文列表

+(NSString*)oaListUrl{
    return @"/flow/getMyWorkItem";
}
//5、公文详细

+(NSString*)oaDetailUrl{
    return @"/flow/getDocDetail";
}
//6、提交公文列表
+(NSString*)submitOptionUrl{
    return @"/flow/submit";
}
//#### 7、登录
+(NSString*)loginUrl{
   return @"/oa/user/login";
}
//8、重置密码

+(NSString*)resetPasswdUrl{
    return @"/oa/user/updatePwd";
}
//9.首页统计接口
+(NSString*)mainIndexUrl{
    return @"/flow/indexCount";
}
//10.我的公文数量统计接口
+(NSString*)countMyWorkItems{
    return @"/flow/countMyWorkItems";
}

//11.搜索公文接口
+(NSString*)searchWorkItems{
    return @"/flow/search";
}
//查看流程接口
+ (NSString*)findFormsetInstFlow{
    return @"/flow/findFormsetInstFlow";
}

//资料上传
+ (NSString*)addFile{
    return @"/oa/file/addFile";
}
//创建文件夹
+ (NSString*)addFolder{
    return @"/oa/file/addFolder";
}
//资料库文件列表
+ (NSString*)findFolder{
    return @"/oa/file/findFolder";
}
//资料库概况
+ (NSString*)findUserDatabanks{
    return @"/oa/file/findUserDatabanks";
}
//资料库文件订阅
+ (NSString*)findUserFiles{
    return @"/oa/file/findUserFiles";
}
//资料库文件操作
+ (NSString*)operateFile{
    return @"/oa/file/operateFile";
}
//文件上传
+ (NSString*)upload{
    return @"/oa/file/upload";
}
//公告详细接口
+ (NSString*)noticeDetail{
    return @"/notice/detail";
}
//公告列表
+ (NSString*)noticeList{
    return @"/notice/list";
}
//更新公告查看状态
+ (NSString*)noticeUpdateViewStatus{
    return @"/notice/updateViewStatus";
}
//新建日程
+ (NSString*)addSchedule{
    return @"/oa/user/addSchedule";
}

//查询日程
+ (NSString*)findSchedule{
    return @"/oa/user/findSchedule";
}

//通讯录分组
+ (NSString*)findUserGroup{
    return @"/oa/user/findUserGroup";
}

//通讯录联系人
+ (NSString*)findUsersByGroup{
    return @"/oa/user/findUsersByGroup";
}

//更新编辑日程
+ (NSString*)updateSchedule{
    return @"/oa/user/updateSchedule";
}

//修改个人资料
+ (NSString*)updaterUserInfo{
    return @"/oa/user/updaterUserInfo";
}

//头像上传接口
+ (NSString*)userUpload{
    return @"/oa/user/upload";
}


@end
