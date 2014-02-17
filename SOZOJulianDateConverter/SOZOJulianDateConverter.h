//
//  SOZODateConverter.h
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef struct {
    NSInteger year;
    NSInteger month;
    NSInteger day;
} SOZOJulianDateComponents;

@interface SOZOJulianDateConverter : NSObject

/**
 Given a year, month and day from the Julian calendar, returns an `NSDate` object representing GMT
 noon of that day.
 */
+ (NSDate *)dateFromJulianYear:(int)year month:(int)month day:(int)day;

/**
 Takes an `NSDate` object and returns a struct holding its year, month, and day on the Julian
 calendar.
 */
+ (SOZOJulianDateComponents)componentsFromDate:(NSDate *)date;

@end
