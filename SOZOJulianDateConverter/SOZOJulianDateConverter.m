//
//  SOZODateConverter.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOJulianDateConverter.h"
#import "SOZOJulianDate.h"
#import "SOZOGregorianDate.h"

@implementation SOZOJulianDateConverter

#pragma mark - Public Interface

+ (NSDate *)dateFromJulianYear:(int)year month:(int)month day:(int)day {
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

    return converted;
}

+ (SOZOJulianDateComponents)componentsFromDate:(NSDate *)date {
    SOZOGregorianDate *gregorianDate = [[SOZOGregorianDate alloc] initWithDate:date];
    SOZOJulianDate *julianDate = [SOZOJulianDate dateFromFixed:gregorianDate.daysSinceEpoch];

    SOZOJulianDateComponents julianComponents;
    julianComponents.year = julianDate.year;
    julianComponents.month = julianDate.month;
    julianComponents.day = julianDate.day;
    return julianComponents;
}

#pragma mark - Internal Methods

+ (void)checkForZeroYear:(int)year {
    if (year == 0) {
        [NSException raise:@"SOZOJulianZeroYearException"
                    format:@"The Julian calendar does not have a year zero."];
    }
}

@end
