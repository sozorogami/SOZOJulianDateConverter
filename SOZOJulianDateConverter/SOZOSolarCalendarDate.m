//
//  SOZOSolarCalendarDate.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 2/18/14.
//  Copyright (c) 2014 sozorogami. All rights reserved.
//

#import "SOZOSolarCalendarDate.h"

@implementation SOZOSolarCalendarDate

#pragma mark - Object Initialization

- (id)initWithYear:(int)year month:(int)month day:(int)day{
    self = [super init];
    if (self) {
        _year = year;
        _month = month;
        _day = day;
    }
    return self;
}


#pragma mark - Public Interface

+ (id)dateFromFixed:(int)fixedDay{
    int year = [self yearFromFixed:fixedDay];
    id jan1stOfYear = [[self alloc] initWithYear:year
                                           month:1
                                             day:1];
    int priorDays = fixedDay - [jan1stOfYear daysSinceEpoch];
    
    //Correction for the assumption that Februrary has 30 days.
    id mar1stOfYear = [[self alloc] initWithYear:year
                                           month:3
                                             day:1];
    int correction;
    if (fixedDay < [mar1stOfYear daysSinceEpoch]) {
        correction = 0;
    } else if ([jan1stOfYear isLeapYear]) {
        correction = 1;
    } else {
        correction = 2;
    }
    
    int month = floor((12 * (priorDays + correction) + 373) / 367.0);
    
    id firstOfTheMonth = [[self alloc] initWithYear:year
                                              month:month
                                                day:1];
    int day = fixedDay - [firstOfTheMonth daysSinceEpoch] + 1;
    
    return  [[self alloc] initWithYear:year month:month day:day];
}

- (NSInteger)daysSinceEpoch {
    return [self daysBeforeStartOfEpoch] + [self nonleapDaysSinceEpoch] +
    [self leapDaysSinceEpoch] + [self daysInPriorMonths] + [self day];
}

#pragma mark - NSObject Overrides

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %d, %d", [self monthName], self.day, self.year];
}

#pragma mark - Internal Methods
- (int)daysInPriorMonths{
    return floor((367 * self.month - 362) / 12) + [self offsetToCorrect30DayFebrurary];
}

- (int)offsetToCorrect30DayFebrurary {
    if (self.month <= 2) {
        return 0;
    } else if (self.isLeapYear) {
        return -1;
    } else {
        return -2;
    }
}

+ (void)raiseVirtualMethodException {
    [NSException raise:@"SOZOVirtualMethodException" format:nil];
}

- (NSString *)monthName {
    return [[self class] monthNames][self.month];
}

+ (NSArray *)monthNames {
    return @[@"None", @"January", @"February", @"March", @"April", @"May", @"June",
             @"July", @"August", @"September", @"October", @"November", @"December"];
}

#pragma mark Virtual Methods

- (int)daysBeforeStartOfEpoch {
    return [[self class] epoch] - 1;
}

+ (int)epoch {
    [[self class] raiseVirtualMethodException];
    return NAN;
}

- (int)nonleapDaysSinceEpoch {
    [[self class] raiseVirtualMethodException];
    return NAN;
}

- (int)leapDaysSinceEpoch{
    [[self class] raiseVirtualMethodException];
    return NAN;
}

+ (int)yearFromFixed:(int)fixedDay{
    [self raiseVirtualMethodException];
    return NAN;
}

- (BOOL)isLeapYear{
    [[self class] raiseVirtualMethodException];
    return NAN;
}

#pragma mark - Object Lifecycle


@end
