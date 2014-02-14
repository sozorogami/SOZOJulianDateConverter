//
//  SOZOJulianTests.m
//  SOZOJulianTests
//
//  Created by Tyler Tape on 2/13/14.
//  Copyright (c) 2014 sozorogami. All rights reserved.
//

#import "SOZOGregorianDate.h"
#import "SOZOJulianDate.h"
#import "SOZOJulianTests.h"
#import "SOZODateConverter.h"

@interface SOZOJulianTests ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation SOZOJulianTests

- (void)setUp {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
}

- (void)testExample {
    SOZOGregorianDate *bc = [[SOZOGregorianDate alloc] initWithYear:-586 month:7 day:24];
    SOZOJulianDate *converted = [SOZOJulianDate dateFromFixed:[bc asFixed]];
    STAssertEquals([converted year], -587, @"Year is wrong.");
}

- (void)testConvertingJulianToGregorian {
    STAssertTrue([[SOZODateConverter gregorianDateFromJulianYear:1436 month:1 day:25] isEqualToDate:[self.dateFormatter dateFromString:@"1436-02-03 12:00:00"]], @"Expected Julian date of 1/25/1436 to be converted to Gregorian 2/3/1436.");
}

@end
