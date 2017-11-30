//
//  NeedDoTableViewCell.h
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NeedDoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *senderLb;
@property (weak, nonatomic) IBOutlet UILabel *currentProgressLb;
@property (weak, nonatomic) IBOutlet UIImageView *headImv;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;

@end
