//
//  OAJobDetailViewController.m
//  OAWork
//
//  Created by james on 2017/11/30.
//  Copyright © 2017年 james. All rights reserved.
//

#import "OAJobDetailViewController.h"
#import <RadioButton/RadioButton.h>
#import "ITTPickView.h"
#import "YZNavigationMenuView.h"
#import "NHPopoverViewController.h"
#import "HWDownSelectedView.h"

@interface OAJobDetailViewController ()<ITTPickViewDelegate,HWDownSelectedViewDelegate,UITableViewDelegate,UITableViewDataSource,YZNavigationMenuViewDelegate>
{
    ITTPickView *_datePicker;
//    ListSelectView *_listView;
    UITableView *_aaaatableView;
    UIButton *_bar;
    YZNavigationMenuView *_menuView;
    NHPopoverViewController *ReBacInfoView;
    
}
@end

@implementation OAJobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.title=@"新建公文";
    self.view.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    NSURL *dect=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL * documentProtocolUrl =  [dect URLByAppendingPathComponent:@"www/aa.tt"];
    
    NSString* jsonS=[NSString stringWithContentsOfURL:documentProtocolUrl encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"jsonS%@",jsonS);
    NSDictionary *dic=[jsonS objectFromCTJSONString];
//    self.title=dic[@"result"][@"docName"];
    NSArray *viewInfoArray=dic[@"result"][@"formData"];
    int topHeight=TOPBARCONTENTHEIGHT;
    
    for (int d=0; d<viewInfoArray.count; d++) {
        NSDictionary *detaiDic=viewInfoArray[d];
//        input 普通输入框
//        date 时间控件(提交的时候提交 毫秒数)
//        spin 下拉选择控件（下拉选项在options参数中测试）
//        spinInput 下拉选择类型再加text 输入框（例如：选择身份证、户照之后再输证件号码）
//        dateInput 时间+输入框的组合控件，请假单中有（时间/地点），复核控件在接口中用逗号隔开，具体在新建公文接口示例。
//        attach 附件
//        radioButton 单项列表
//        "name": "姓名",
//        "type": "input",
//        "inputType": "text",
//        "requestKey": "userName",
//        "default": {
//            "k": "1234（userid）",
//            "v": "王小二"
//        }
        UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(0,topHeight, SCREEN_WIDTH, 30)];

        areaView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:areaView];
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"name"];
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        [areaView addSubview:titleLB];
        CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(areaView.width, 30)];
        
        titleLB.frame=CGRectMake(20,0, textSize.width+10, 30);
        CGRect nextFrame=CGRectMake(titleLB.right, titleLB.top, areaView.width-titleLB.right-20, titleLB.height);
        
        if ([detaiDic[@"type"] isEqualToString:@"area"]) {
            titleLB.backgroundColor=[UIColor clearColor];
            titleLB.numberOfLines=0;
            titleLB.font=[UIFont systemFontOfSize:18.0f];
            titleLB.lineBreakMode=NSLineBreakByWordWrapping;
            areaView.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
            textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(SCREEN_WIDTH-40, 30)];
            if ([detaiDic[@"name"] isEqualToString:@""]||[detaiDic[@"name"] isKindOfClass:[NSNull class]]) {
                textSize.height=20;
            }else{
                textSize.height += textSize.height+10;
                titleLB.frame=CGRectMake(20,0,SCREEN_WIDTH-40,textSize.height);
            }
            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, textSize.height);
           
        }else if ([detaiDic[@"type"] isEqualToString:@"spin"]) {
            HWDownSelectedView *aVie=[[HWDownSelectedView alloc]initWithFrame:nextFrame];
            aVie.placeholder = @"spin";
            aVie.listArray = @[@"22", @"23", @"24", @"25", @"26"];
            [areaView addSubview:aVie];

//            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
//            lb.text=@"spin";
//            lb.textColor=[UIColor blackColor];
//            lb.tag=102;
//            lb.font=[UIFont systemFontOfSize:14.0f];
//            lb.userInteractionEnabled=true;
//            [areaView addSubview:lb];
//
//            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
//            im.frame=CGRectMake(lb.width-10, (lb.height-5)/2, 8, 5);
//            [lb addSubview:im];
//
//
//            UIButton *bt=[[UIButton alloc]initWithFrame:lb.bounds];
//            [lb addSubview:bt];
//            bt.backgroundColor=[UIColor clearColor];
//            [bt addTarget:self action:@selector(listBtTapped:) forControlEvents:UIControlEventTouchUpInside];
//            ListSelectView *aList=[[ListSelectView alloc]];
//            if ([detaiDic[@"type"] isEqualToString:@"spinInput"]) {
//                aList.listViewType=ListViewTextField;
//            }
//            [areaView addSubview:aList];
//            aList.titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
        }else if ([detaiDic[@"type"] isEqualToString:@"spinInput"]) {
            
            HWDownSelectedView *aVie=[[HWDownSelectedView alloc]initWithFrame:nextFrame];
            aVie.placeholder = @"spinInput";
            aVie.listArray = @[@"22", @"23", @"24", @"25", @"26"];
            aVie.type=HWDownTypeCanEdit;
            [areaView addSubview:aVie];

//            UITextField *tf=[[UITextField alloc]initWithFrame:nextFrame];
//            tf.font=[UIFont systemFontOfSize:15.0f];
//            tf.text=@"spinInput";
//            tf.tag=102;
//            tf.font=[UIFont systemFontOfSize:14.0f];
//            tf.userInteractionEnabled=true;
//            [areaView addSubview:tf];
//
//            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
//            im.frame=CGRectMake(tf.width-10, (tf.height-5)/2, 8, 5);
//            [tf addSubview:im];
//
//
//            UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(tf.width-tf.height,0, tf.height, tf.height)];
//            [tf addSubview:bt];
//            bt.backgroundColor=[UIColor clearColor];
//            [bt addTarget:self action:@selector(listBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if ([detaiDic[@"type"] isEqualToString:@"input"]) {
            UITextField *tf=[[UITextField alloc]init];
            tf.accessibilityHint=detaiDic[@"default"];
            tf.textColor=[UIColor blackColor];
            tf.font=[UIFont systemFontOfSize:14.0f];
            tf.frame=nextFrame;
            [areaView addSubview:tf];
            
        }else if ([detaiDic[@"type"] isEqualToString:@"text"]) {
            UITextView *tf=[[UITextView alloc]init];
            int line=1;
            if ([[detaiDic allKeys] containsObject:@"lines"]) {
                line=[detaiDic[@"lines"] intValue];
            }
            tf.font=[UIFont systemFontOfSize:14.0f];
            tf.accessibilityHint=detaiDic[@"default"][@"v"];
            tf.textColor=[UIColor blackColor];
            tf.frame=CGRectMake(nextFrame.origin.x, nextFrame.origin.y, nextFrame.size.width, nextFrame.size.height+25*(line-1));
            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, tf.bottom);
            [areaView addSubview:tf];
            
        }else if ([detaiDic[@"type"] isEqualToString:@"date"]) {
            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
            lb.font=[UIFont systemFontOfSize:14.0f];
            lb.userInteractionEnabled=true;
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString=[dateFormatter stringFromDate:date];
            lb.text=dateString;
            UIButton *bt=[[UIButton alloc]initWithFrame:lb.bounds];
            [lb addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(dateBtTapped:) forControlEvents:UIControlEventTouchUpInside];
             [areaView addSubview:lb];
        }else if ([detaiDic[@"type"] isEqualToString:@"dateInput"]) {
            UITextField *lb=[[UITextField alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
            lb.font=[UIFont systemFontOfSize:14.0f];
            lb.userInteractionEnabled=true;
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString=[dateFormatter stringFromDate:date];
            lb.text=dateString;
            [areaView addSubview:lb];
            
            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
            im.frame=CGRectMake(lb.width-10, (lb.height-5)/2, 8, 5);
            [lb addSubview:im];
            
            
            UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(lb.width-lb.height,0, lb.height, lb.height)];
            [lb addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(dateBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }else  if ([detaiDic[@"type"] isEqualToString:@"radioButton"]) {
            NSMutableArray* buttons = [NSMutableArray arrayWithCapacity:3];
            CGRect btnRect = CGRectMake(nextFrame.origin.x, nextFrame.origin.x, 100, nextFrame.size.height);
            for (NSString* optionTitle in @[@"Red", @"Green", @"Blue"]) {
                RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
                [btn addTarget:self action:@selector(onRadioButtonValueChanged:) forControlEvents:UIControlEventValueChanged];
                btnRect.origin.x += 20;
                if ((btnRect.origin.x+100)>areaView.width) {
                    btnRect.origin.x=titleLB.right+10;
                    btnRect.origin.y += 40;
                }
                [btn setTitle:optionTitle forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
                btn.titleLabel.font = [UIFont systemFontOfSize:14];
                [btn setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
                [btn setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
                btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
                btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
                [areaView addSubview:btn];
                 areaView.frame=CGRectMake(20,topHeight, SCREEN_WIDTH-20, btn.bottom);
                [buttons addObject:btn];
              
            }
            
            [buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
            
            [buttons[0] setSelected:YES];
        }else if ([detaiDic[@"type"] isEqualToString:@"attach"]){
            

        }
        UIView *bottomLineView=[[UIView alloc]init];
        bottomLineView.backgroundColor=[Utils colorWithHexString:@"#e4e4e4"];
        [areaView addSubview:bottomLineView];
        topHeight=areaView.bottom+1;
       
    }

    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_bar) {
        _bar=[[UIButton alloc]init];
        [_bar setTitle:@"+" forState: UIControlStateNormal];
        [_bar setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateNormal];
        [_bar setTitle:@"+" forState: UIControlStateHighlighted];
        _bar.titleLabel.font=[UIFont boldSystemFontOfSize:24];
        [_bar setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateHighlighted];
        [_bar addTarget:self action:@selector(editTapped:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem* barButton = [[UIBarButtonItem alloc] initWithCustomView:_bar];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    
    
}
- (void)showReBacInfoView{
    if (!ReBacInfoView) {
        UIView *aView= [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-40, 240)];
        aView.backgroundColor=[UIColor whiteColor];
        
        UILabel *titleLb=[[UILabel alloc]initWithFrame:CGRectMake(20, 0, aView.width-80, 40)];
        titleLb.text=@"退回理由";
        titleLb.textColor=[UIColor lightGrayColor];
        [aView addSubview:titleLb];
        
        UIImageView *imv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"x"]];
  
        imv.frame=CGRectMake(aView.width-16-titleLb.left,titleLb.top+(titleLb.height-16)/2 , 16, 16);
        [aView addSubview:imv];
        
        UIButton *bt=[[UIButton alloc]init];
//        [bt setImage:[UIImage imageNamed:@"x"]  forState: UIControlStateNormal];
//        [bt setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateNormal];
//        [bt setImage:[UIImage imageNamed:@"x"]  forState: UIControlStateHighlighted];
//        bt.titleLabel.font=[UIFont boldSystemFontOfSize:24];
//        [bt setTitleColor:[Utils colorWithHexString:@"#008fef"] forState:UIControlStateHighlighted];
        [bt addTarget:self action:@selector(showReBacInfeoViewDissMiss:) forControlEvents:UIControlEventTouchUpInside];
        bt.frame=CGRectMake(titleLb.right, titleLb.top, aView.width-titleLb.right, titleLb.height);
        [aView addSubview:bt];
        
        UITextView *tf=[[UITextView alloc]init];
        tf.font=[UIFont systemFontOfSize:14.0f];
        tf.textColor=[UIColor blackColor];
        tf.layer.cornerRadius=5.0f;
        tf.layer.borderWidth=0.5;
        tf.layer.borderColor=[Utils colorWithHexString:@"#b7b7b7"].CGColor;
        tf.frame=CGRectMake(titleLb.left, titleLb.bottom, aView.width-2*(titleLb.left), 100);
        [aView addSubview:tf];
        
        UIButton *confirmBt=[[UIButton alloc]init];
        [confirmBt setTitle:@"确认退回" forState: UIControlStateNormal];
        [confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmBt setTitle:@"确认退回" forState: UIControlStateHighlighted];
        confirmBt.titleLabel.font=[UIFont boldSystemFontOfSize:16];
        [confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateNormal];
        [confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateHighlighted];
        [confirmBt addTarget:self action:@selector(showReBacInfeoViewDissMiss:) forControlEvents:UIControlEventTouchUpInside];
        confirmBt.layer.cornerRadius=titleLb.height/2;
        confirmBt.clipsToBounds=true;
        confirmBt.frame=CGRectMake(tf.left+20, tf.bottom+20, aView.width-2*(tf.left+20), titleLb.height);
        [aView addSubview:confirmBt];
        ReBacInfoView = [[NHPopoverViewController alloc] initWithView:aView contentSize:aView.frame.size autoClose:FALSE];
    }
    
    [ReBacInfoView show];
    
}
-(void)showReBacInfeoViewDissMiss:(UIButton*)BT{
    
    [ReBacInfoView dismiss];
}
- (void)editTapped:(UIButton*)bt{
    if (!_menuView) {
        //        NSArray *imageArray = @[@"newInfo_whiteBack",@"newPro_whiteBack",@"edit_whiteBack"];
        NSArray *imageArray = @[@"liuchengjiankong",@"baocun"];
        
        _menuView= [[YZNavigationMenuView alloc] initWithPositionOfDirection:CGPointMake(SCREEN_WIDTH -34,BOTTOMBARHEIGHT+25) images:imageArray titleArray:@[@"流程监控",@"保存"] andType :0];
        _menuView.cellColor=[UIColor whiteColor];
        _menuView.delegate = self;
        _menuView.textLabelTextAlignment=NSTextAlignmentLeft;
    }
    [self.view addSubview:_menuView];
    
    _menuView.hidden=!_menuView.isHidden;
    
    [self showReBacInfoView];
    
}
-(void) dateBtTapped:(UIButton*)bt{
    
    if (!_datePicker) {
        _datePicker = [[ITTPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:NO];
    }
    _datePicker.defaulDate=[NSDate date];
    _datePicker.delegate=self;
    _datePicker.textView=(UILabel*)bt.superview;
    [_datePicker showView];
    [self textFieldUserEnable:false OfView:self.view];
    
}
//-(void) listBtTapped:(UIButton*)bt{
//    UIView *aView=bt.superview;
//    CGPoint convertpoint=[aView convertPoint:CGPointZero toView:self.view ];
//     CGRect frame=CGRectMake(convertpoint.x, convertpoint.y+aView.height,aView.width,100);
//    _aaaatableView=[[UITableView alloc]initWithFrame:frame];
//    _aaaatableView.dataSource=self;
//    _aaaatableView.delegate=self;
//    _aaaatableView.backgroundColor=[UIColor whiteColor];
//    _aaaatableView.separatorStyle=UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_aaaatableView];
//
//
//}

-(void)textFieldUserEnable:(BOOL)userEnable OfView:(UIView*)aView{
    for (UIView  *Aview in aView.subviews) {
        if ([Aview isKindOfClass:[UITextField class]]||[Aview isKindOfClass:[UITextView class]]) {
            Aview.userInteractionEnabled=userEnable;
            
        }else{
            [self textFieldUserEnable:userEnable OfView:Aview];
        }
    }
}
-(void)onRadioButtonValueChanged:(UIButton*)BT{
    
    
}
#pragma  mark DataPickDelgate
-(void)toobarDonBtnHaveClick:(ITTPickView *)pickView resultString:(NSString *)resultString{
    //    dateInterval=datePicker.date.timeIntervalSinceReferenceDate;
    pickView.textView.text=resultString;
     [self textFieldUserEnable:true OfView:self.view];
    
}
#pragma mark HWDownDelegate
- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath{
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
     NSArray* _titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
    return _titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        UILabel *aLabel=[[UILabel alloc]initWithFrame:CGRectMake(5, 0, 70, 28)];
        aLabel.textAlignment=NSTextAlignmentLeft;
        aLabel.tag=10000;
        aLabel.textColor=[UIColor blackColor];
        [cell.contentView addSubview:aLabel];
        aLabel.font = [UIFont systemFontOfSize:15.0];
        
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(0,29, 85, 1)];
        lineView.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:lineView];
    }
    UILabel *aLabel=[cell viewWithTag:10000];
    NSArray* _titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
    aLabel.text = [_titleArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selected = NO;
    
    
    [tableView removeFromSuperview];
}
#pragma mark -YZNavigationMenuViewDelegate
- (void)navigationMenuView:(YZNavigationMenuView *)menuView clickedAtIndex:(NSInteger)index{
    
   
    switch (index) {
           
        case 0:
        {
           
        }
            break;
        case 1:
        {
           
        }
            break;
            
            
        default:
            break;
    }
    _menuView.hidden=YES;
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
