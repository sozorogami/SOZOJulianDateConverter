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
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd GG HH:mm:ss"];
}

- (void)testExample {
    SOZOGregorianDate *bc = [[SOZOGregorianDate alloc] initWithYear:-586 month:7 day:24];
    SOZOJulianDate *converted = [SOZOJulianDate dateFromFixed:[bc asFixed]];
    STAssertEquals([converted year], -587, @"Year is wrong.");
}

- (void)testConvertingJulianToGregorian {
    STAssertTrue([[SOZODateConverter gregorianDateFromJulianYear:1436 month:1 day:25] isEqualToDate:[self.dateFormatter dateFromString:@"1436-02-03 AD 12:00:00"]], @"Expected Julian date of 1/25/1436 to be converted to Gregorian 2/3/1436.");
    STAssertTrue([[SOZODateConverter gregorianDateFromJulianYear:1582 month:10 day:4] isEqualToDate:[self.dateFormatter dateFromString:@"1582-10-14 AD 12:00:00"]], @"Expected Julian date of 10/4/1582 to be converted to Gregorian 10/14/1582.");
    STAssertTrue([[SOZODateConverter gregorianDateFromJulianYear:-587 month:7 day:30] isEqualToDate:[self.dateFormatter dateFromString:@"0586-7-24 BC 12:00:00"]], @"Expected Julian date of 7/30/587 BC to be converted to Gregorian 7/24/586 BC.");
}

- (void)testDatesNearEraChangeover {
    STAssertTrue([[SOZODateConverter gregorianDateFromJulianYear:-1 month:1 day:3] isEqualToDate:[self.dateFormatter dateFromString:@"0001-01-01 AD 12:00:00"]], @"Julian date 1/3/1 BC represents the first day of the Gregorian calendar (1/1/1 AD)");
    STAssertTrue([[SOZODateConverter gregorianDateFromJulianYear:-1 month:1 day:2] isEqualToDate:[self.dateFormatter dateFromString:@"0001-12-31 BC 12:00:00"]], @"Julian date 1/2/1 BC represents the first day before the Gregorian calendar (12/31/1 BC)");
}

- (void)testZeroYear {
    STAssertThrows([SOZODateConverter gregorianDateFromJulianYear:0 month:1 day:1], @"Should not accept year zero.");
}

@end
