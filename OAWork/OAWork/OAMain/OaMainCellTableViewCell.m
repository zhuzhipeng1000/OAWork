//
//  OaMainCellTableViewCell.m
//  OAWork
//
//  Created by james on 2017/11/27.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OaMainCellTableViewCell.h"
#import "Utils.h"

@implementation OaMainCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self addViews];
    // Initialization code
}
//@property (strong, nonatomic)  UILabel *titleLB;
//@property (strong, nonatomic)  UILabel *senderLB;
//@property (strong, nonatomic)  UILabel *curentLB;
//@property (strong, nonatomic)  UILabel *timeLB;
//@property (strong, nonatomic)  UIImageView *headImage;
//@property (strong, nonatomic)  UIButton *returnButton;
//@property (strong, nonatomic)  UIButton *deleteButton;
//@property (strong, nonatomic)  UIButton *seeDetailButton;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addViews];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
       
        [self addViews];
    }
    return self;
}
-(void)addViews{
    self.contentView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    
   _backView=[[UIView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    _backView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview: _backView];
    _headImage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_sina"]];
    _headImage.contentMode=UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:_headImage];
    
    _titleLB=[[UILabel alloc]init];
    _titleLB.font=[UIFont boldSystemFontOfSize:15.0f];
    _titleLB.textColor =[UIColor blackColor];
    _titleLB.numberOfLines=0;
    _titleLB.lineBreakMode=NSLineBreakByWordWrapping;
    [self.contentView addSubview:_titleLB];
    
    _senderLB=[[UILabel alloc]init];
    _senderLB.font=[UIFont boldSystemFontOfSize:14.0f];
    _senderLB.textColor=[Utils colorWithHexString:@"#008fef"];
    _senderLB.text=@"发送人:";
    [self.contentView addSubview:_senderLB];
    
    _senderTitleLB=[[UILabel alloc]init];
    _senderTitleLB.font=[UIFont boldSystemFontOfSize:14.0f];
    _senderTitleLB.textColor=[UIColor lightGrayColor];
    _senderTitleLB.text=@"发送人:";
    _senderTitleLB.frame=CGRectMake(20, 90, 45, 25);
    [self.contentView addSubview:_senderTitleLB];
    
    _currentTitleLB=[[UILabel alloc]init];
    _currentTitleLB.font=[UIFont boldSystemFontOfSize:14.0f];
    _currentTitleLB.textColor=[UIColor lightGrayColor];
    _currentTitleLB.text=@"当前环节:";
    _currentTitleLB.frame=CGRectMake(20, 90, 55 ,25);
    [self.contentView addSubview:_currentTitleLB];
    
    _curentLB=[[UILabel alloc]init];
    _curentLB.font=[UIFont boldSystemFontOfSize:14.0f];
    _curentLB.textColor=[Utils colorWithHexString:@"#08ba06"];;
    _curentLB.text=@"发送人:";
    [self.contentView addSubview:_curentLB];
    
    _timeLB=[[UILabel alloc]init];
    _timeLB.font=[UIFont boldSystemFontOfSize:14.0f];
    _timeLB.textColor=[UIColor lightGrayColor];
    _timeLB.text=@"2017-12-11";
    
    [self.contentView addSubview:_timeLB];
    
    _returnButton=[[UIButton alloc]init];
    [_returnButton setTitle:@"退回" forState:UIControlStateNormal];
    [_returnButton setTitle:@"退回"  forState:UIControlStateHighlighted];
    [_returnButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_returnButton addTarget:self action:@selector(returnButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_returnButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _returnButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    _returnButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    _returnButton.layer.cornerRadius=10;
    _returnButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _returnButton.layer.borderWidth=1.0f;
    [self.contentView addSubview:_returnButton];
    
    _deleteButton=[[UIButton alloc]init];
    [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [_deleteButton setTitle:@"删除"  forState:UIControlStateHighlighted];
    [_deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_deleteButton addTarget:self action:@selector(deleteButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_deleteButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _deleteButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    _deleteButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    _deleteButton.layer.cornerRadius=10;
    _deleteButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _deleteButton.layer.borderWidth=1.0f;
    [self.contentView addSubview:_deleteButton];
    
    _seeDetailButton=[[UIButton alloc]init];
    [_seeDetailButton setTitle:@"查看" forState:UIControlStateNormal];
    [_seeDetailButton setTitle:@"查看"  forState:UIControlStateHighlighted];
    [_seeDetailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_seeDetailButton addTarget:self action:@selector(seeDetailButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [_seeDetailButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    _seeDetailButton.titleLabel.adjustsFontSizeToFitWidth=YES;
    _seeDetailButton.titleLabel.font=[UIFont systemFontOfSize:14.0];
    _seeDetailButton.layer.cornerRadius=10;
    _seeDetailButton.layer.borderColor=[UIColor lightGrayColor].CGColor;
    _seeDetailButton.layer.borderWidth=1.0f;
    [self.contentView addSubview:_seeDetailButton];
}
-(void)returnButtonTapped:(UIButton*)bt{
    
    
}
-(void)deleteButtonTapped:(UIButton*)bt{
    
    
}
-(void)seeDetailButtonTapped:(UIButton*)bt{
    
    
}
- (void)accessButtonTapped:(UIButton*)bt{
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)layoutSubviews{
    _backView.frame=CGRectMake(0,0,self.contentView.width, self.contentView.height-10);
    self.imageView.frame=CGRectMake(self.contentView.width-43,0,33, 39);
    self.titleLB.frame=CGRectMake(10, 0,self.contentView.width-60, 60);
    
    self.senderTitleLB.frame=CGRectMake(self.titleLB.left, self.titleLB.bottom,55, 25);
    self.senderLB.frame=CGRectMake(self.senderTitleLB.right, self.senderTitleLB.top,self.contentView.width-self.senderTitleLB.right-100, 25);
    self.timeLB.frame=CGRectMake(self.contentView.width-100, self.senderTitleLB.top,90, 25);
    
    self.currentTitleLB.frame=CGRectMake(self.titleLB.left, self.senderTitleLB.bottom,65, 25);
    self.curentLB.frame=CGRectMake(self.currentTitleLB.right, self.currentTitleLB.top,self.contentView.width-self.currentTitleLB.right-170, 25);
    _seeDetailButton.frame=CGRectMake(self.contentView.width-55, _currentTitleLB.top,50, 25);
    _deleteButton.frame=CGRectMake(_seeDetailButton.left-55, _currentTitleLB.top, 50, 25);
    _returnButton.frame=CGRectMake(_deleteButton.left-55, _currentTitleLB.top, 50, 25);
}

@end
