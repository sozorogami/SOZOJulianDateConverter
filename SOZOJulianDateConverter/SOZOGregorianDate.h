//
//  SOZOGregorianDate.h
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOZOGregorianDate : NSObject

@property (nonatomic, assign) int year;
@property (nonatomic, assign) int month;
@property (nonatomic, assign) int day;

@property (nonatomic, readonly) NSString *monthName;
@property (nonatomic, readonly) NSInteger daysSinceEpoch;

- (id)initWithYear:(int)year month:(int)month day:(int)day;
- (id)initWithDate:(NSDate *)date;
+ (id)dateFromFixed:(int)fixedDay;

@end
