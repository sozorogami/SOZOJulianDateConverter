//
//  SOZODateConverterTests.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SOZOJulianDateConverter.h"

@interface SOZODateConverterTests : SenTestCase
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation SOZODateConverterTests

- (void)setUp {
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd GG HH:mm:ss"];
}

- (void)testConvertingNSDateToJulianForPreGregorianDates {
    NSDate  *date = [self.dateFormatter dateFromString:@"1436-02-03 AD 12:00:00"];
    SOZOJulianDateComponents components = [SOZOJulianDateConverter componentsFromDate:date];
    STAssertEquals(components.year, 1436, nil);
    STAssertEquals(components.month, 1, nil);
    STAssertEquals(components.day, 25, nil);
}

- (void)testConvertingJulianToGregorianForPreGregorianDates {
    STAssertEqualObjects([SOZOJulianDateConverter dateFromJulianYear:1436 month:1 day:25],
                         [self.dateFormatter dateFromString:@"1436-02-03 AD 12:00:00"],
                         nil);
}

- (void)testConvertingJulianToGregorianForBC {
    STAssertEqualObjects([SOZOJulianDateConverter dateFromJulianYear:-587 month:7 day:30],
                         [self.dateFormatter dateFromString:@"0586-7-24 BC 12:00:00"],
                         @"Expected Julian date of 1/25/1436 to be converted to Gregorian 2/3/1436.");
}

- (void)testConvertingJulianToGregorianNearGregorianChange {
    STAssertEqualObjects([SOZOJulianDateConverter dateFromJulianYear:1582 month:10 day:4],
                         [self.dateFormatter dateFromString:@"1582-10-14 AD 12:00:00"],
                         @"Expected Julian date of 10/4/1582 to be converted to Gregorian 10/14/1582.");
}

- (void)testJulianDateBeforeGregorianEraChangeover {
    STAssertEqualObjects([SOZOJulianDateConverter dateFromJulianYear:-1 month:1 day:2],
                         [self.dateFormatter dateFromString:@"0001-12-31 BC 12:00:00"],
                         @"Given Julian date should represent the first day before the Gregorian epoch.");
}

- (void)testJulianDateAfterGregorianEraChangeover {
    STAssertEqualObjects([SOZOJulianDateConverter dateFromJulianYear:-1 month:1 day:3],
                         [self.dateFormatter dateFromString:@"0001-01-01 AD 12:00:00"],
                         @"Given Julian date should represent the first day of the Gregorian epoch.");
}

- (void)testZeroYear {
    STAssertThrows([SOZOJulianDateConverter dateFromJulianYear:0 month:1 day:1],
                   @"Should not accept year zero input.");
}

@end