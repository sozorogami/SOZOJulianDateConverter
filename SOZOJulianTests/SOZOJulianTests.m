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

- (void)testExample {
    SOZOGregorianDate *bc = [[SOZOGregorianDate alloc] initWithYear:-586 month:7 day:24];
    SOZOJulianDate *converted = [SOZOJulianDate dateFromFixed:[bc asFixed]];
    STAssertEquals([converted year], -587, @"Year is wrong.");
}

@end
