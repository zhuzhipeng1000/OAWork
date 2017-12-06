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
#import "ListSelectView.h"
#import "ITTPickView.h"


@interface OAJobDetailViewController ()<ITTPickViewDelegate,ListSelectViewDelegate>
{
    ITTPickView *_datePicker;
    ListSelectView *_listView;
    
}
@end

@implementation OAJobDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSString* jsonS=[NSString stringWithContentsOfURL:[[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"aa.Json"] encoding:NSUTF8StringEncoding error:nil];
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
        UIView *areaView=[[UIView alloc] initWithFrame: CGRectMake(20,topHeight, SCREEN_WIDTH-40, 30)];
        areaView.backgroundColor=[UIColor whiteColor];
        [self.view addSubview:areaView];
        
        UILabel *titleLB=[[UILabel alloc]init];
        titleLB.text=detaiDic[@"name"];
        titleLB.font=[UIFont systemFontOfSize:14.0F];
        titleLB.textColor=[UIColor blackColor];
        [areaView addSubview:titleLB];
       CGSize textSize=  [Utils sizeWithText:titleLB.text font:titleLB.font maxSize:CGSizeMake(SCREEN_WIDTH, 30)];
        titleLB.frame=CGRectMake(0,0, textSize.width+10, 30);
        CGRect nextFrame=CGRectMake(titleLB.right, titleLB.top, areaView.width-titleLB.right, titleLB.height);

        if ([detaiDic[@"type"] isEqualToString:@"spin"]) {
            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
            lb.font=[UIFont systemFontOfSize:15.0f];
            lb.text=@"spin";
            lb.textColor=[UIColor blackColor];
            lb.tag=102;
            lb.userInteractionEnabled=true;
            [areaView addSubview:lb];
            
            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
            im.frame=CGRectMake(lb.width-10, (lb.height-5)/2, 8, 5);
            [lb addSubview:im];
            
            
            UIButton *bt=[[UIButton alloc]initWithFrame:lb.bounds];
            [lb addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(listBtTapped:) forControlEvents:UIControlEventTouchUpInside];
//            ListSelectView *aList=[[ListSelectView alloc]];
//            if ([detaiDic[@"type"] isEqualToString:@"spinInput"]) {
//                aList.listViewType=ListViewTextField;
//            }
//            [areaView addSubview:aList];
//            aList.titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
        }else if ([detaiDic[@"type"] isEqualToString:@"spinInput"]) {
            UITextField *tf=[[UITextField alloc]initWithFrame:nextFrame];
            tf.font=[UIFont systemFontOfSize:15.0f];
            tf.text=@"spinInput";
            tf.tag=102;
            tf.userInteractionEnabled=true;
            [areaView addSubview:tf];
            
            UIImageView *im=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"arrow_down"]];
            im.frame=CGRectMake(tf.width-10, (tf.height-5)/2, 8, 5);
            [tf addSubview:im];
            
            
            UIButton *bt=[[UIButton alloc]initWithFrame:CGRectMake(tf.width-tf.height,0, tf.height, tf.height)];
            [tf addSubview:bt];
            bt.backgroundColor=[UIColor clearColor];
            [bt addTarget:self action:@selector(listBtTapped:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if ([detaiDic[@"type"] isEqualToString:@"input"]) {
            UITextField *tf=[[UITextField alloc]init];
            tf.accessibilityHint=detaiDic[@"default"];
            tf.textColor=[UIColor blackColor];
            tf.frame=nextFrame;
            [areaView addSubview:tf];
            
        }else if ([detaiDic[@"type"] isEqualToString:@"text"]) {
            UITextView *tf=[[UITextView alloc]init];
            int line=1;
            if ([[detaiDic allKeys] containsObject:@"lines"]) {
                line=[detaiDic[@"lines"] intValue];
            }
            tf.accessibilityHint=detaiDic[@"default"][@"v"];
            tf.textColor=[UIColor blackColor];
            tf.frame=CGRectMake(nextFrame.origin.x, nextFrame.origin.y, nextFrame.size.width, nextFrame.size.height+25*(line-1));
            areaView.frame=CGRectMake(20,topHeight, SCREEN_WIDTH-20, tf.bottom);
            [areaView addSubview:tf];
            
        }else if ([detaiDic[@"type"] isEqualToString:@"date"]) {
            UILabel *lb=[[UILabel alloc]initWithFrame:nextFrame];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            NSDate *date = [NSDate date];
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
                btn.titleLabel.font = [UIFont boldSystemFontOfSize:17];
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
        topHeight=areaView.bottom+1;
       
    }
    // Do any additional setup after loading the view from its nib.
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
-(void) listBtTapped:(UIButton*)bt{
    UIView *aView=bt.superview;
    if (!_listView) {
        _listView = [[ListSelectView alloc]initWithSize:CGSizeMake(aView.width,100) OfViewPoint:aView onView:self.view];
    }else{
        [_listView showSize:aView.frame.size OfViewPoint:aView onView:self.view];
    }
    _listView.titleArray=@[@"全部",@"工程审计",@"跟踪审计",@"专项审计"];
    _listView.delegate=self;
    _listView.labelField=(UILabel*)aView;
    _listView.hidden=false;
    [self textFieldUserEnable:false OfView:self.view];
    
}

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
#pragma mark listViewDelegate
- (void)ListSelectView:(ListSelectView*)listSelectView didSelecteText:(NSString*)text andIndex:(NSInteger)index{
    
    listSelectView.hidden=YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
