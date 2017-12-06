//
//  ListSelectView.h
//  ProductAduit
//
//  Created by JIME on 2017/1/19.
//  Copyright © 2017年 JIME. All rights reserved.
//
@class ListSelectView;
@protocol ListSelectViewDelegate<NSObject>

- (void)ListSelectView:(ListSelectView*)listSelectView didSelecteText:(NSString*)text andIndex:(NSInteger)index;

@end
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ListViewType) {
    ListViewLabel,
    ListViewTextField,
};
@interface ListSelectView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray* titleArray;
@property (nonatomic,weak) id delegate;
@property (nonatomic,weak)  UILabel *labelField;
@property(nonatomic,assign) ListViewType listViewType;
-(void)hiddenTableView;
- (instancetype)initWithSize:(CGSize)size OfViewPoint:(UIView*)aView onView:(UIView*)onView;
-(void)showSize:(CGSize)size OfViewPoint:(UIView*)aView onView:(UIView*)onView;
@end
