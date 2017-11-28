//
//  HostMangager.m
//  ProductAduit
//
//  Created by james on 2017/3/15.
//  Copyright © 2017年 JIME. All rights reserved.
//

#import "HostMangager.h"

@implementation HostMangager
//#### 1、登录
+(NSString*)loginUrl{
   return @"/mobile/login/submit.jhtml";
}
//2、重置密码

+(NSString*)resetPasswdUrl{
    return @"/mobile/user/resetPasswd.jhtml";
}
//3、获取验证码

+(NSString*)getValidateCodenUrl{
    return @"/mobile/login/getValidateCode.jhtml";
}
//4、项目列表

+(NSString*)projectListUrl{
    return @"/mobile/project/list.jhtml";
}
//5、项目详情

+(NSString*)projectDetailsUrl{
    return @"/mobile/project/details.jhtml";
}
//6、互动列表

+(NSString*)interactionUrl{
    return @"/mobile/interaction/list.jhtml";
}
//7、新建通知
+(NSString*)messgaeNewUrl{
    return @"/mobile/message/submit.jhtml";
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
