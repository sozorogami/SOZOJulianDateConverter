//
//  SOZOGregorianDate.h
//  TheCalendar
//
//  Created by Tyler Tape on 1/26/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOZOGregorianDate : NSObject

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;

@property (nonatomic, readonly) NSString *monthName;

- (id)initWithYear:(int)year month:(int)month day:(int)day;

+ (NSArray *)monthNames;
+ (int)yearFromFixed:(int)fixedDay;
+ (id)dateFromFixed:(int)fixed_day;
- (BOOL)isLeapYear;
- (int)daysBeforeStartOfEpoch;
- (int)nonleapDaysSinceEpoch;
- (int)leapDaysSinceEpoch;
- (int)offsetToCorrect30DayFebrurary;
- (int)daysInPriorMonths;
- (NSInteger)asFixed;

@end
