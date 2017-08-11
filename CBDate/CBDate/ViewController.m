//
//  ViewController.m
//  CBDate
//
//  Created by 崔兵兵 on 16/6/7.
//  Copyright © 2016年 医联通. All rights reserved.
//

#import "ViewController.h"
#import "NSDate+YN.h"
#import "UIPickerView+YLT.h"
#import "PickerCell.h"

@interface ViewController () <UIPickerViewDelegate, UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *myPickerView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@property (strong, nonatomic) NSMutableArray *arrayYears;
@property (strong, nonatomic) NSMutableArray *arrayMonths;
@property (strong, nonatomic) NSMutableArray *arrayDays;

@property (copy, nonatomic) NSString *strYear;      //  年
@property (copy, nonatomic) NSString *strMonth;     //  月
@property (copy, nonatomic) NSString *strDay;       //  日

@property (strong, nonatomic) NSDateFormatter *dateFormatter;

@end

@implementation ViewController

- (NSMutableArray *)arrayYears
{
    if (!_arrayYears) {
        _arrayYears = [NSMutableArray array];
        
        for (int i = 1; i < 10000; i++) {
            NSString *strYear = [NSString stringWithFormat:@"%04i", i];
            [_arrayYears addObject:strYear];
        }
    }
    
    return _arrayYears;
}

- (NSMutableArray *)arrayMonths
{
    if (!_arrayMonths) {
        _arrayMonths = [NSMutableArray array];
        
        for (int i = 1; i <= 12; i++) {
            NSString *str = [NSString stringWithFormat:@"%02i", i];
            [_arrayMonths addObject:str];
        }
    }
    
    return _arrayMonths;
}

- (NSMutableArray *)arrayDays
{
    if (!_arrayDays) {
        _arrayDays = [NSMutableArray array];
    }
    
    return _arrayDays;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyyMM";
    
    NSInteger allDays = [self totaldaysInMonth:[NSDate date]];
    for (int i = 1; i <= allDays; i++) {
        NSString *strDay = [NSString stringWithFormat:@"%02i", i];
        [self.arrayDays addObject:strDay];
    }
    
    self.myPickerView.delegate = self;
    self.myPickerView.dataSource = self;
    
    //  更新年
    NSInteger currentYear = [[NSDate date] getYear];
    NSString *strYear = [NSString stringWithFormat:@"%04li", currentYear];
    NSInteger indexYear = [self.arrayYears indexOfObject:strYear];
    if (indexYear == NSNotFound) {
        indexYear = 0;
    }
    [self.myPickerView selectRow:indexYear inComponent:0 animated:YES];
    self.strYear = self.arrayYears[indexYear];;
    
    //  更新月份
    NSInteger currentMonth = [[NSDate date] getMonth];
    NSString *strMonth = [NSString stringWithFormat:@"%02li", currentMonth];
    NSInteger indexMonth = [self.arrayMonths indexOfObject:strMonth];
    if (indexMonth == NSNotFound) {
        indexMonth = 0;
    }
    [self.myPickerView selectRow:indexMonth inComponent:1 animated:YES];
    self.strMonth = self.arrayMonths[indexMonth];
    
    //  更新日
    NSInteger currentDay = [[NSDate date] getDay];
    NSString *strDay = [NSString stringWithFormat:@"%02li", currentDay];
    NSInteger indexDay = [self.arrayDays indexOfObject:strDay];
    if (indexDay == NSNotFound) {
        indexDay = 0;
    }
    [self.myPickerView selectRow:indexDay inComponent:2 animated:YES];
    self.strDay = self.arrayDays[indexDay];
    
    [self updateLabelText];
    [self.myPickerView clearSpearatorLine];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 计算出当月有多少天
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInOfMonth.length;
}

#pragma mark - UIPickerView DataSource and Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.arrayYears.count;
    } else if (component == 1) {
        return self.arrayMonths.count;
    } else {
        return self.arrayDays.count;
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 60;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    if (component == 0) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayYears[row]];
        return cell;
    } else if (component == 1) {
        PickerCell *cell = [PickerCell cellWithName:self.arrayMonths[row]];
        return cell;
    } else {
        PickerCell *cell = [PickerCell cellWithName:self.arrayDays[row]];
        return cell;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) {
        self.strYear = self.arrayYears[row];
    } else if (component == 1) {
        self.strMonth = self.arrayMonths[row];
    } else {
        self.strDay = self.arrayDays[row];
    }
   
    [self updateLabelText];
    
    if (component != 2) {
        NSString *strDate = [NSString stringWithFormat:@"%@%@", self.strYear, self.strMonth];
        [self upDateCurrentAllDaysWithDate:[self.dateFormatter dateFromString:strDate]];
    }
}

#pragma mark - 更新当前label的日期
- (void)updateLabelText
{
    self.dateLabel.text = [NSString stringWithFormat:@"%@年%@月%@日", self.strYear, self.strMonth, self.strDay];
}

#pragma mark - 更新选中的年、月份时的日期
- (void)upDateCurrentAllDaysWithDate:(NSDate *)currentDate
{
    [self.arrayDays removeAllObjects];
    
    NSInteger allDays = [self totaldaysInMonth:currentDate];
    for (int i = 1; i <= allDays; i++) {
        NSString *strDay = [NSString stringWithFormat:@"%02i", i];
        [self.arrayDays addObject:strDay];
    }
    
    [self.myPickerView reloadComponent:2];

    //  更新日
    NSInteger indexDay = [self.arrayDays indexOfObject:self.strDay];
    if (indexDay == NSNotFound) {
        indexDay = (self.arrayDays.count - 1) > 0 ? (self.arrayDays.count - 1) : 0;
    }
    [self.myPickerView selectRow:indexDay inComponent:2 animated:YES];
    self.strDay = self.arrayDays[indexDay];
    
    [self updateLabelText];
}

@end
