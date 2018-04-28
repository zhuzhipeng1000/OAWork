//
//  WScViewController.m
//  OAWork
//
//  Created by james on 2017/12/17.
//  Copyright © 2017年 james. All rights reserved.
//

#import "WScViewController.h"
#import "WSCalendarView.h"
#import "EventListViewController.h"

@interface WScViewController ()<WSCalendarViewDelegate>
{
   
    WSCalendarView *calendarViewEvent;
    NSMutableArray *eventArray;
    
}
@property (nonatomic,strong) NSDate *startDate;
@end

@implementation WScViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    calendarViewEvent = [[[NSBundle mainBundle] loadNibNamed:@"WSCalendarView" owner:self options:nil] firstObject];
    calendarViewEvent.calendarStyle = WSCalendarStyleView;
    calendarViewEvent.isShowEvent=true;
    calendarViewEvent.tappedDayBackgroundColor=[UIColor blackColor];
    calendarViewEvent.frame = CGRectMake(0,TOPBARCONTENTHEIGHT, self.view.frame.size.width, 300*(self.view.frame.size.width/320));
    [calendarViewEvent setupAppearance];
    calendarViewEvent.delegate=self;
    [self.view addSubview:calendarViewEvent];
    
    eventArray=[[NSMutableArray alloc] init];
    NSDate *lastDate;
    NSDateComponents *dateComponent=[[NSDateComponents alloc] init];
    for (int i=0; i<10; i++) {
        
        if (!lastDate) {
            lastDate=[NSDate date];
        }
        else{
            [dateComponent setDay:1];
        }
        NSDate *datein = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponent toDate:lastDate options:0];
        lastDate=datein;
        [eventArray addObject:datein];
    }
    [calendarViewEvent reloadCalendar];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)getNumberOfDaysInMonth
{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian]; // 指定日历的算法 NSGregorianCalendar - ios 8
    NSDate * currentDate = [NSDate date];
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay  //NSDayCalendarUnit - ios 8
                                   inUnit: NSCalendarUnitMonth //NSMonthCalendarUnit - ios 8
                                  forDate:currentDate];
    return range.length;
}
#pragma mark WSCalendarViewDelegate

-(void)changeDate:(NSDate *)startDate{
    _startDate=startDate;
    
}
-(NSArray *)setupEventForDate{
    return eventArray;
}

-(void)didTapLabel:(WSLabel *)lblView withDate:(NSDate *)selectedDate
{
//    EventListViewController *evt=[[EventListViewController alloc]init];
//    [self.navigationController pushViewController:evt animated:YES];
}

-(void)deactiveWSCalendarWithDate:(NSDate *)selectedDate{
    NSDateFormatter *monthFormatter=[[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"dd MMMM yyyy"];
    NSString *str=[monthFormatter stringFromDate:selectedDate];
  
}


- (IBAction)hideKeyboard:(id)sender {
    
    [self.view endEditing:YES];
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
