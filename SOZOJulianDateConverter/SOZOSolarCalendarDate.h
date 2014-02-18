//
//  SOZOSolarCalendarDate.h
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 2/18/14.
//  Copyright (c) 2014 sozorogami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOZOSolarCalendarDate : NSObject

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;
@property (nonatomic, readonly) NSString *monthName;
@property (nonatomic, readonly) NSInteger daysSinceEpoch;

- (id)initWithYear:(int)year month:(int)month day:(int)day;
+ (id)dateFromFixed:(int)fixedDay;

@end
