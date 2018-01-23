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
#import "OAprogressMonitorViewController.h"

@interface OAJobDetailViewController ()<ITTPickViewDelegate,HWDownSelectedViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>
{
    ITTPickView *_datePicker;
//    ListSelectView *_listView;
    UITableView *_aaaatableView;
    UIButton *_bar;
    YZNavigationMenuView *_menuView;

    UIScrollView *_scrollView;
    UIButton *_confirmBt;
    int type;
    NSMutableArray *viewInfoArray;
}
@end

@implementation OAJobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
      self.title=_categoryDic[@"DOCTYPENAME"];
    if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"通知"]) {
        type=2;
    }else if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"互相交流"]) {
        type=1;
    }else if ([_categoryDic[@"DOCTYPENAME"] isEqualToString:@"会议室预约登记表"]) {
        type=3;
    }
    [self getData];
    
    self.view.backgroundColor=[Utils colorWithHexString:@"#f7f7f7"];
    NSURL *dect=[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    NSURL * documentProtocolUrl =  [dect URLByAppendingPathComponent:@"www/aa.tt"];
    
    NSString* jsonS=[NSString stringWithContentsOfURL:documentProtocolUrl encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"jsonS%@",jsonS);
    NSDictionary *dic=[jsonS objectFromCTJSONString];
//    self.title=dic[@"result"][@"docName"];
   

    
    // Do any additional setup after loading the view from its nib.
}
-(void)initView{
//    NSArray *viewInfoArray=dic[@"result"][@"formData"];
    int topHeight=0;
    _scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, TOPBARCONTENTHEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TOPBARCONTENTHEIGHT)];
    _scrollView.showsVerticalScrollIndicator=false;
    [self.view addSubview:_scrollView];
    NSString *headText=[NSString stringWithFormat:@"广州市教育评估和教师继续教育指导中心%@",self.title];
    NSDictionary *dic=@{@"TYPE":@"150",@"name":headText,@"BINDING_DATA_NAME":headText};
    [viewInfoArray insertObject:dic atIndex:0];
    
    for (int d=0; d<viewInfoArray.count; d++) {
        NSDictionary *detaiDic=viewInfoArray[d];
        if ([detaiDic[@"TYPE"] intValue]==6) {
            continue;
        }
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
        areaView.tag=1000+d;
        areaView.accessibilityHint=[detaiDic JSONStringFromCT];
        areaView.backgroundColor=[UIColor whiteColor];
        [_scrollView addSubview:areaView];
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"BINDING_DATA_NAME"];
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        [areaView addSubview:titleLB];
        CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(areaView.width, 30)];
        
        titleLB.frame=CGRectMake(20,0, textSize.width+10, 30);
        CGRect nextFrame=CGRectMake(titleLB.right, titleLB.top, areaView.width-titleLB.right-20, titleLB.height);
        
        if ([detaiDic[@"TYPE"] intValue]==150) {
            titleLB.backgroundColor=[UIColor clearColor];
            titleLB.numberOfLines=0;
            titleLB.font=[UIFont systemFontOfSize:18.0f];
            titleLB.lineBreakMode=NSLineBreakByWordWrapping;
            titleLB.textAlignment=NSTextAlignmentCenter;
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
            aVie.delegate=self;
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
            aVie.delegate=self;
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
            
        }else if ([detaiDic[@"TYPE"] intValue]==1) {
            
            UITextField *tf=[[UITextField alloc]init];
            tf.accessibilityHint=detaiDic[@"default"];
            tf.textColor=[UIColor blackColor];
            tf.font=[UIFont systemFontOfSize:14.0f];
            tf.frame=nextFrame;
            tf.tag=2000+d;
            [areaView addSubview:tf];
            if ([titleLB.text isEqualToString:@"拟稿部门"]) {
                tf.text=[User shareUser].ORG_NAME;
            }
            
        }else if ([detaiDic[@"TYPE"] intValue]==6) {//text
            UITextView *tf=[[UITextView alloc]init];
            int line=1;
            if ([[detaiDic allKeys] containsObject:@"lines"]) {
                line=[detaiDic[@"lines"] intValue];
            }
            tf.font=[UIFont systemFontOfSize:14.0f];
            tf.accessibilityHint=detaiDic[@"default"];
            tf.textColor=[UIColor blackColor];
            tf.tag=2000+d;
            tf.frame=CGRectMake(nextFrame.origin.x, nextFrame.origin.y, nextFrame.size.width, nextFrame.size.height+25*(line-1));
            areaView.frame=CGRectMake(0,topHeight, SCREEN_WIDTH, tf.bottom);
            [areaView addSubview:tf];
            
        }else if ([detaiDic[@"TYPE"] intValue]==16) {//日期类
            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
            lb.font=[UIFont systemFontOfSize:14.0f];
            lb.userInteractionEnabled=true;
           
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString=[dateFormatter stringFromDate:date];
            lb.text=dateString;
           lb.text=@"请选择日期";
            lb.tag=2000+d;
            UIButton *bt=[[UIButton alloc]initWithFrame:lb.bounds];
            [lb addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(dateBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            [areaView addSubview:lb];
        }else if ([detaiDic[@"TYPE"] intValue]==160) { //日期输入框
            UITextField *lb=[[UITextField alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
            lb.font=[UIFont systemFontOfSize:14.0f];
            lb.userInteractionEnabled=true;
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            NSString *dateString=[dateFormatter stringFromDate:date];
            lb.text=dateString;
             lb.tag=2000+d;
            lb.text=@"请选择日期";
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
    _confirmBt=[[UIButton alloc]init];
    [_confirmBt setTitle:@"发送" forState: UIControlStateNormal];
    [_confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBt setTitle:@"发送" forState: UIControlStateHighlighted];
    _confirmBt.titleLabel.font=[UIFont boldSystemFontOfSize:16];
    [_confirmBt setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateNormal];
    [_confirmBt setBackgroundImage:[Utils createImageWithColor:[Utils colorWithHexString:@"#008fef"]] forState:UIControlStateHighlighted];
    [_confirmBt addTarget:self action:@selector(confirmBtTapped:) forControlEvents:UIControlEventTouchUpInside];
    _confirmBt.layer.cornerRadius=40/2;
    _confirmBt.clipsToBounds=true;
    _confirmBt.frame=CGRectMake(20, topHeight+20,SCREEN_WIDTH-40, 40);
    [_scrollView addSubview:_confirmBt];
    _scrollView.contentSize=CGSizeMake(SCREEN_WIDTH, _confirmBt.bottom+20);
}
-(void)confirmBtTapped:(UIButton*)bt{
    
    NSMutableArray *arr=[NSMutableArray array];
   
    for (UIView *areaView in _scrollView.subviews) {
    
        if (areaView.tag>1000&& areaView.subviews.count>1) {
             NSMutableDictionary *mudic=[NSMutableDictionary dictionary];
            NSDictionary *detaiDic =[areaView.accessibilityHint objectFromCTJSONString];
            [mudic setObject:detaiDic[@"BINDING_DATA_NAME"] forKey:@"BINDING_DATA_NAME"];
             [arr addObject:mudic];
            UILabel *valueView=[areaView viewWithTag:(1000+areaView.tag)];
                BOOL shouldAlert=false;
                if ([detaiDic[@"TYPE"]  intValue]==16&&([valueView isKindOfClass:[UILabel class]]||[valueView isKindOfClass:[UITextField class]])) {
                    UITextField *textView=(UITextField*)valueView;
                    if (textView.accessibilityHint.length<1) {
                        shouldAlert=true;
                    }else{
                    NSString *timeInterval=textView.accessibilityHint;;
                    [mudic setObject:timeInterval forKey:@"value"];
                    
                   }
                }else if ([valueView isKindOfClass:[UITextField class]]||[valueView isKindOfClass:[UITextView class]]) {
                    UITextField *textView=(UITextField*)valueView;
                    if (!textView.text||textView.text.length<1) {
                        shouldAlert=true;
                    }else{
                        [mudic setObject:textView.text forKey:@"value"];
                        
                    }
                }else if ([valueView isKindOfClass:[RadioButton class]]){
                    
                }else if ([valueView isKindOfClass:[HWDownSelectedView class]]){
                    
                }
                if (shouldAlert) {
                    UIAlertController *al=[UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"请输入%@",detaiDic[@"BINDING_DATA_NAME"]] preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:al animated:YES completion:nil];
                    return;
                }
            
        }
    }
    
    NSDictionary *para=@{@"docId":_categoryDic[@"DOCID"],@"formDatas":arr,@"sendFlag":@true,@"userId":[User shareUser].ID};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"提交数据中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest postRequestWithUrl:[HostMangager submitOptionUrl] andPara:@{@"flowRequestInfo":[para JSONStringFromCT]} isAddUserId:false Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0) {
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"提交成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
        }else{
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
    }];
    
}
-(void)getData{
    
    NSDictionary *parameters =@{@"docType":[NSNumber numberWithInt:type]};
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //    _hud.mode = MBProgressHUDModeAnnularDeterminate;
    self.hud.labelText = @"数据获取中";
    __weak __typeof(self) weakSelf = self;
    [MyRequest getRequestWithUrl:[HostMangager newOaUrl] andPara:parameters isAddUserId:true Success:^(NSDictionary *dict, BOOL success) {
        [weakSelf.hud hide:YES];
        if ([dict isKindOfClass:[NSDictionary class]]&& [dict[@"code"] intValue]==0) {
            viewInfoArray=[dict[@"result"] mutableCopy];
            [self initView];
        }else{
            
            UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [al show];
            
        }
        
    } fail:^(NSError *error) {
        [weakSelf.hud hide:YES];
        UIAlertView *al=[[UIAlertView alloc]initWithTitle:nil message:@"数据获取失败，请重试" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [al show];
    }];
    
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


- (void)editTapped:(UIButton*)bt{
    
    if (!_menuView) {
        //        NSArray *imageArray = @[@"newInfo_whiteBack",@"newPro_whiteBack",@"edit_whiteBack"];
        NSArray *imageArray = @[@"liuchengjiankong",@"baocun"];
        
        _menuView= [[YZNavigationMenuView alloc] initWithPositionOfDirection:CGPointMake(SCREEN_WIDTH -34,BOTTOMBARHEIGHT+25) images:imageArray titleArray:@[@"流程监控",@"保存"] andType :0];
        _menuView.cellColor=[UIColor whiteColor];
        _menuView.delegate = self;
        _menuView.textLabelTextAlignment=NSTextAlignmentLeft;
    }else{
      _menuView.hidden=!_menuView.isHidden;
    }
    [self.view addSubview:_menuView];
       
    
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
  
    if (resultString.length) {
        pickView.textView.text=resultString;
        pickView.textView.accessibilityHint=[NSString stringWithFormat:@"%.0lf000", pickView.datePicker.date.timeIntervalSince1970];
    }
    [self textFieldUserEnable:true OfView:self.view];
    
}
#pragma mark HWDownDelegate
- (void)downSelectedView:(HWDownSelectedView *)selectedView didSelectedAtIndex:(NSIndexPath *)indexPath{
    
    
}
-(void)downSelectedView:(UIView *)aView WillShow:(BOOL)show orClose:(BOOL)close{
    if (show) {
        _scrollView.scrollEnabled=false;
          [self textFieldUserEnable:false OfView:self.view];
        
    }else{
        _scrollView.scrollEnabled=true;
          [self textFieldUserEnable:true OfView:self.view];
    }    
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
            OAprogressMonitorViewController *moct=[[OAprogressMonitorViewController alloc]init];
            [self.navigationController pushViewController:moct animated:YES];
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
#pragma mark - alertdelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   [self.navigationController popViewControllerAnimated:YES];
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
