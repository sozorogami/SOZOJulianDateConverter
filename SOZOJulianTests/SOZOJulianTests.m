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

@interface SOZOJulianTests ()
@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@end

@implementation SOZOJulianTests

- (void)setUp {
    self.dateFormatter = [NSDateFormatter new];
}

- (void)testExample {
    SOZOGregorianDate *bc = [[SOZOGregorianDate alloc] initWithYear:-586 month:7 day:24];
    SOZOJulianDate *converted = [SOZOJulianDate dateFromFixed:[bc asFixed]];
    STAssertEquals([converted year], -587, @"Year is wrong.");
}

- (void)testConvertingGregorianToJulian {
    STAssertEquals([SOZODateConverter gregorianDateFromJulianYear:1436 month:1 day:5],
                   [self.dateFormatter dateFromString:@"February 3rd, 1436"],
                   @"Expected Julian date of 1/5/1436 to be converted to Gregorian 2/3/1436.");
}

@end
