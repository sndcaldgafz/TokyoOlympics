//
//  CountDownViewController.m
//  TokyoOlympics
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "CountDownViewController.h"

@interface CountDownViewController ()

@property (weak, nonatomic) IBOutlet UILabel *lblCountDownPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblCountDownPad;

@end

@implementation CountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:24];
    [comps setMonth:7];
    [comps setYear:2020];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *destinationDate = [calender dateFromComponents:comps];
    NSDate *date = [NSDate date];
    NSDateComponents *components = [calender components:NSCalendarUnitDay fromDate:date toDate:destinationDate options:NSCalendarWrapComponents];
    NSInteger days = [components day];
    
    NSString *strDays = [NSString stringWithFormat:@"%li天",(long)days];
    self.lblCountDownPhone.text = strDays;
    self.lblCountDownPad.text = strDays;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
