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

+ (NSDate*)gregorianDateFromJulianYear:(int)year month:(int)month day:(int)day{
    
    SOZOJulianDate *julian = [[SOZOJulianDate alloc] initWithYear:year month:month day:day];
    SOZOGregorianDate *gregorian = [SOZOGregorianDate dateFromFixed:[julian asFixed]];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    [comps setDay:[gregorian day]];
    [comps setMonth:[gregorian month]];
    [comps setYear:[gregorian year]];
    [comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [comps setHour:12];
    [comps setMinute:0];
    [comps setSecond:0];
    
    NSLog(@"Gregorian: %@",gregorian);
    
    NSCalendar *gregcal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *converted = [gregcal dateFromComponents:comps];
    
    NSLog(@"Converted: %@",converted);
    NSDateFormatter *formatter = [NSDateFormatter new];
    NSLog(@"Target: %@",[formatter dateFromString:@"February 3, 1436"]);
    
    return converted;
    
}

@end
