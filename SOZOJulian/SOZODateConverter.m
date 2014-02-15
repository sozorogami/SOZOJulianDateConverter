//
//  SOZODateConverter.m
//  SOZOJulian
//
//  Created by Tyler Tape on 2/14/14.
//  Copyright (c) 2014 sozorogami. All rights reserved.
//

#import "SOZODateConverter.h"
#import "SOZOJulianDate.h"
#import "SOZOGregorianDate.h"

@implementation SOZODateConverter

#pragma mark - Public Interface

+ (NSDate*)gregorianDateFromJulianYear:(int)year month:(int)month day:(int)day {
    [self checkForZeroYear:year];
    
    SOZOJulianDate *julian = [[SOZOJulianDate alloc] initWithYear:year month:month day:day];
    SOZOGregorianDate *gregorian = [SOZOGregorianDate dateFromFixed:[julian daysSinceEpoch]];

    NSDateComponents *components = [[NSDateComponents alloc] init];

    if (year < 0) {
        //Compensate for missing year 0.
        [components setYear:[gregorian year] + 1];
    } else  {
        [components setYear:[gregorian year]];
    }
    
    [components setDay:[gregorian day]];
    [components setMonth:[gregorian month]];
    [components setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [components setHour:12];
    [components setMinute:0];
    [components setSecond:0];
    
    NSCalendar *gregcal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *converted = [gregcal dateFromComponents:components];
    
    NSLog(@"CONVERTED: %@",converted);
    
    return converted;
    
}

#pragma mark - Internal Methods

+ (void)checkForZeroYear:(int)year {
    if (year == 0) {
        [NSException raise:@"SOZOJulianZeroYearException"
                    format:@"The Julian calendar does not have a year zero."];
    }
}

@end
