//
//  AppDelegate.h
//  OAWork
//
//  Created by james on 2017/11/23.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic ) UINavigationController *navi;
+ (AppDelegate *) shareAppDeleage;
@end

