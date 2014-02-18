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

- (id)initWithDate:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:date];

    return [[SOZOGregorianDate alloc] initWithYear:components.year
                                             month:components.month
                                               day:components.day];
}


#pragma mark - Internal Methods

+ (int)epoch {
    return 1;
}

- (int)leapDaysSinceEpoch{
    return floor(([self year] - 1) / 4.0) - floor(([self year] - 1) / 100.0) +
    floor(([self year] - 1) / 400.0);
}

- (int)nonleapDaysSinceEpoch {
    return 365 * (self.year - 1);
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

@end
