//
//  PersonTableViewCell.h
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *infoLb;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UILabel *arrowLb;

@end
