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

@implementation SOZOJulianTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    SOZOGregorianDate *bc = [[SOZOGregorianDate alloc] initWithYear:-586 month:7 day:24];
    SOZOGregorianDate *ad = [[SOZOGregorianDate alloc] initWithYear:2094 month:7 day:18];
    SOZOGregorianDate *leap = [[SOZOGregorianDate alloc] initWithYear:400 month:1 day:1];
    SOZOJulianDate *converted = [SOZOJulianDate dateFromFixed:[bc asFixed]];
    STAssertEquals([converted year], -587, @"Year is wrong.");
}

@end
