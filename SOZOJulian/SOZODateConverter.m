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

+ (NSException *)zeroYearException{
    return [NSException
            exceptionWithName:@"JulianZeroYearException"
            reason:@"Julian Calendar does not have a year zero."
            userInfo:nil];
}

+ (NSDate*)gregorianDateFromJulianYear:(int)year month:(int)month day:(int)day{
    
    if (year == 0){
        [[self zeroYearException] raise];
    }
    
    SOZOJulianDate *julian = [[SOZOJulianDate alloc] initWithYear:year month:month day:day];
    SOZOGregorianDate *gregorian = [SOZOGregorianDate dateFromFixed:[julian asFixed]];
    
    NSDateComponents* comps = [[NSDateComponents alloc] init];
    
    if (year < 0) {
        //Compensate for missing year 0.
        [comps setYear:[gregorian year] + 1];
    } else  {
        [comps setYear:[gregorian year]];
    }
    
    [comps setDay:[gregorian day]];
    [comps setMonth:[gregorian month]];
    [comps setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [comps setHour:12];
    [comps setMinute:0];
    [comps setSecond:0];
    
    NSCalendar *gregcal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *converted = [gregcal dateFromComponents:comps];
    
    NSLog(@"CONVERTED: %@",converted);
    
    return converted;
    
}

@end
