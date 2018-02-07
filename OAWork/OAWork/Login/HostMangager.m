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


// 8、新建子项目
+(NSString*)projectNewUrl{
    return @"/mobile/project/submit.jhtml";
}
// 9、新建阶段
+(NSString*)progressNewUrl{
    return @"/mobile/stage/submit.jhtml";
}
// 10、关闭阶段
+(NSString*)progressStageCloseUrl{
    return @"/mobile/stage/close.jhtml";
}
//11、删除项目

+(NSString*)projectDeleteUrl{
    return @"/mobile/project/delete.jhtml";
}
//12、项目成员列表
+(NSString*)projectPersonUrl{
    return @"/mobile/user/list.jhtml";
}
//13、项目应答
+(NSString*)projectResponseUrl{
    return @"/mobile/interaction/submit.jhtml";
}
//14、附件上传接口
+(NSString*)attachUploadUrl{
    return @"/mobile/file/upload.jhtml";
}
//15、查看附件
+(NSString*)attachDetailUrl{
    return @"/mobile/interaction/listAttch.jhtml";
}
//16、新建日志
+(NSString*)projectLogNewUrl{
    return @"/mobile/log/submit.jhtml";
}
//17、查看日志列表
+(NSString*)projectLogListUrl{
    return @"/mobile/log/list.jhtml";
}
//18、查看日志详情
+(NSString*)projectLogDetailUrl{
    return @"/mobile/log/details.jhtml";
}
//19、关注接口
+(NSString*)attentionAddUrl{
    return @"/mobile/attention/submit.jhtml";
}
//20、消息列表

+(NSString*)messageListUrl{
    return @"/mobile/message/list.jhtml";
}
//21、消息状态变更
+(NSString*)messageStatueChangeUrl{
    return @"/mobile/message/edit.jhtml";
}
//22、修改个人信息
+(NSString*)infoEditUrl{
    return @"/mobile/user/edit.jhtml";
}
//23、修改密码
+(NSString*)passwdRessetUrl{
    return @"/mobile/user/resetPasswd.jhtml";
}
//24、设备信息采集
+(NSString*)deviceGetUrl{
    return @"/mobile/user/collection.jhtml";
}
//25、消息推送
+(NSString*)infoPushUrl{
    return @"/mobile/user/collection.jhtml";
}
//26版本升级接口
+(NSString*)appUpdatehUrl{
    return @"/mobile/version/update.jhtml";
}
//27帮助反馈接口
+(NSString*)apphelpRevertUrl{
    return @"/mobile/feedback/submit.jhtml";
}
@end
