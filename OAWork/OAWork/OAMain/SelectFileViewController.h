//
//  SelectFileViewController.h
//  图片选择器以及文件选择器上传
//
//  Created by 李骏 on 2018/2/12.
//  Copyright © 2018年 李骏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
@class SelectFileViewController;

@protocol SelectFileViewControllerDelegate <NSObject>

-(void)confirmBtTappedWithFile:(NSArray *)files onController:(SelectFileViewController*)avct ;
@end

@interface SelectFileViewController : BaseViewController
@property (nonatomic,strong) NSString *filePath;
@property (nonatomic,weak) id delegate;

@end
