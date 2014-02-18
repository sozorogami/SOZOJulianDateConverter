//
//  SOZOGregorianDate.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOGregorianDate.h"
#import "SOZOMath.h"

@implementation SOZOGregorianDate

#pragma mark - Object Initialization

- (id)initWithYear:(int)year month:(int)month day:(int)day{
    self = [super init];
    if (self) {
        _year = year;  // http://qualitycoding.org/objective-c-init/
        _month = month;
        _day = day;
    }
    return self;
}

- (id)initWithDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:date];

    return [[SOZOGregorianDate alloc] initWithYear:components.year
                                             month:components.month
                                               day:components.day];
}

#pragma mark - NSObject Overrides

- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %d, %d", [self monthName], self.day, self.year];
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

#pragma mark - Internal Methods

- (NSString *)monthName {
    return [[self class] monthNames][self.month];
}

+ (NSArray *)monthNames {
    return @[@"None", @"January", @"February", @"March", @"April", @"May", @"June",
             @"July", @"August", @"September", @"October", @"November", @"December"];
}

+ (int)epoch {
    return 1;
}

- (int)daysBeforeStartOfEpoch {
    return [[self class] epoch] - 1;
}

- (int)leapDaysSinceEpoch{
    return floor(([self year] - 1) / 4.0) - floor(([self year] - 1) / 100.0) +
    floor(([self year] - 1) / 400.0);
}

- (int)nonleapDaysSinceEpoch {
    return 365 * (self.year - 1);
}

- (int)daysInPriorMonths{
    return floor((367 * [self month] - 362) / 12) + [self offsetToCorrect30DayFebrurary];
}

+ (int)yearFromFixed:(int)fixedDay{
    int yearsTotal = 0;
    int daysPassedSinceEpoch = fixedDay - [self epoch];
    
    float daysIn1Year = 365.0;
    float daysIn4YearCycle = daysIn1Year * 4.0 + 1;             // Every 4th year a leap year
    float daysIn100YearCycle = daysIn4YearCycle * 25.0 - 1;     // Century leap year exception
    float daysIn400YearCycle = daysIn100YearCycle * 4.0 + 1;    // Years divisble by 400 are leap years
    
    int cyclesOf400 = floor(daysPassedSinceEpoch/daysIn400YearCycle);
    yearsTotal += cyclesOf400 * 400;
    int daysRemaining = modulo(daysPassedSinceEpoch, daysIn400YearCycle);
    
    int cyclesOf100 = floor(daysRemaining/daysIn100YearCycle);
    yearsTotal += cyclesOf100 * 100;
    daysRemaining = modulo(daysRemaining, daysIn100YearCycle);
    
    int cyclesOf4 = floor(daysRemaining/daysIn4YearCycle);
    yearsTotal += cyclesOf4 * 4;
    daysRemaining = modulo(daysRemaining, daysIn4YearCycle);
    
    int years = floor(daysRemaining/daysIn1Year);
    yearsTotal += years;
    
    //unless fixed_day is the last day of a leap year, it represents a day in the following year
    if (!(cyclesOf100 == 4 || years == 4)) {
        yearsTotal++;
    }
    
    return yearsTotal;
}

- (BOOL)isLeapYear {
    if (self.year % 4 == 0) {
        int remainder = self.year % 400;
        if (remainder != 100 && remainder != 200 && remainder != 300) {
            return YES;
        }
    }
    
    return NO;
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

@end
