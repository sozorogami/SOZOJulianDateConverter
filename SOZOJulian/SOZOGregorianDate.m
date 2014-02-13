//
//  SOZOGregorianDate.m
//  TheCalendar
//
//  Created by Tyler Tape on 1/26/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOGregorianDate.h"

@implementation SOZOGregorianDate

//"gregorian-date-difference"
+ (int)daysDifferenceWithDate1:(id)date1 date2:(id)date2
{
    date1 = (SOZOGregorianDate *) date1;
    date2 = (SOZOGregorianDate *) date2;
    return [date2 asFixed] - [date1 asFixed];
}

+ (float)mod:(float)x y:(float)y{
    return x - y * floor(x/y);
}

- (NSString *)description{
    NSString * result = [NSString stringWithFormat:@"%@ %d, %d",[self monthName],[self day],[self year]];
    return result;
}

- (id)initWithYear:(int)year month:(int)month day:(int)day{
    self = [super init];
    
    if (self) {
        [self setNamesOfMonths:@[@"None", @"January ", @"February", @"March", @"April", @"May", @"June", @"July", @"August", @"September", @"October", @"November", @"December"]];
        
        [self setYear:year];
        [self setMonth:month];
        [self setDay:day];
    }
    
    return self;
}

+ (int)epoch{
    return 1;
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
    int daysRemaining = [self mod:daysPassedSinceEpoch y:daysIn400YearCycle];
    
    int cyclesOf100 = floor(daysRemaining/daysIn100YearCycle);
    yearsTotal += cyclesOf100 * 100;
    daysRemaining = [self mod:daysRemaining y:daysIn100YearCycle];
    
    int cyclesOf4 = floor(daysRemaining/daysIn4YearCycle);
    yearsTotal += cyclesOf4 * 4;
    daysRemaining = [self mod:daysRemaining y:daysIn4YearCycle];
    
    int years = floor(daysRemaining/daysIn1Year);
    yearsTotal += years;
    
    //unless fixed_day is the last day of a leap year, it represents a day in the following year
    if (!(cyclesOf100 == 4 || years == 4)) {
        yearsTotal++;
    }
    
    return yearsTotal;
}

+ (id)dateFromFixed:(int)fixedDay{
    int year = [self yearFromFixed:fixedDay];
    id jan1stOfYear = [[self alloc] initWithYear:year
                                                           month:1
                                                             day:1];
    int priorDays = fixedDay - [jan1stOfYear asFixed];
    
    //Correction for the assumption that Februrary has 30 days.
    id mar1stOfYear = [[self alloc] initWithYear:year
                                                           month:3
                                                             day:1];
    int correction;
    if (fixedDay < [mar1stOfYear asFixed]) {
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
    int day = fixedDay - [firstOfTheMonth asFixed] + 1;
    
    return  [[self alloc] initWithYear:year month:month day:day];
}

- (NSString *)monthName{
    return [self.namesOfMonths objectAtIndex:[self month]];
}

- (BOOL)isLeapYear{
    int year_mod4 = [self year] % 4;
    NSNumber *year_mod400 = [NSNumber numberWithInteger:[self year] % 400];
    return year_mod4 == 0 && ![@[@100,@200,@300] containsObject:year_mod400];
}

- (int)daysBeforeStartOfEpoch{
    return [[self class] epoch] - 1;
}

- (int)nonleapDaysSinceEpoch{
    return 365 * ([self year] - 1);
}

- (int)leapDaysSinceEpoch{
    return floor(([self year] - 1) / 4.0) - floor(([self year] - 1) / 100.0) +
        floor(([self year] - 1) / 400.0);
}

- (int)offsetToCorrect30DayFebrurary{
    if ([self month] <= 2) {
        return 0;
    }
    else if ([self isLeapYear]){
        return -1;
    }
    else{
        return -2;
    }
}

- (int)daysInPriorMonths{
    return floor((367 * [self month] - 362) / 12) + [self offsetToCorrect30DayFebrurary];
}

- (int)asFixed{
//    NSLog(@"%d,%d,%d,%d,%d",[self daysBeforeStartOfEpoch] , [self nonleapDaysSinceEpoch] , [self leapDaysSinceEpoch] , [self daysInPriorMonths] , [self day]);
    return [self daysBeforeStartOfEpoch] + [self nonleapDaysSinceEpoch] + [self leapDaysSinceEpoch] + [self daysInPriorMonths] + [self day];
}

@end
