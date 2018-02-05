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
// 8、新建子项目
+(NSString*)projectNewUrl;
// 9、新建阶段
+(NSString*)progressNewUrl;
// 10、关闭阶段
+(NSString*)progressStageCloseUrl;
//11、删除项目
+(NSString*)projectDeleteUrl;
//12、项目成员列表
+(NSString*)projectPersonUrl;
//13、项目应答
+(NSString*)projectResponseUrl;
//14、附件上传接口
+(NSString*)attachUploadUrl;
//15、查看附件
+(NSString*)attachDetailUrl;
//16、新建日志
+(NSString*)projectLogNewUrl;
//17、查看日志列表
+(NSString*)projectLogListUrl;
//18、查看日志详情
+(NSString*)projectLogDetailUrl;
//19、关注接口
+(NSString*)attentionAddUrl;
//20、消息列表
+(NSString*)messageListUrl;
//21、消息状态变更
+(NSString*)messageStatueChangeUrl;
//22、修改个人信息
+(NSString*)infoEditUrl;
//23、修改密码
+(NSString*)passwdRessetUrl;
//24、设备信息采集
+(NSString*)deviceGetUrl;
//25、消息推送
+(NSString*)infoPushUrl;
//26版本升级接口
+(NSString*)appUpdatehUrl;
//27帮助反馈接口
+(NSString*)apphelpRevertUrl;

@end
