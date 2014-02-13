//
//  SOZOGregorianDate.h
//  TheCalendar
//
//  Created by Tyler Tape on 1/26/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOZOGregorianDate : NSObject{
}

@property (strong, nonatomic) NSArray *namesOfMonths;
@property (nonatomic) int year;
@property (nonatomic) int month;
@property (nonatomic) int day;

+ (int)daysDifferenceWithDate1:(id)date1 date2:(id)date2;
+ (float)mod:(float)x y:(float)y;
- (id)initWithYear:(int)year month:(int)month day:(int)day;
+ (int)yearFromFixed:(int)fixedDay;
+ (id)dateFromFixed:(int)fixed_day;
- (NSString *)monthName;
- (BOOL)isLeapYear;
- (int)daysBeforeStartOfEpoch;
- (int)nonleapDaysSinceEpoch;
- (int)leapDaysSinceEpoch;
- (int)offsetToCorrect30DayFebrurary;
- (int)daysInPriorMonths;
- (int)asFixed;

@end
