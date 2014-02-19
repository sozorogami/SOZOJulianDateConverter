//
//  SOZOMathTests.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "SOZOMath.h"

@interface SOZOMathTests : SenTestCase
@property (nonatomic, assign) float accuracy;

@end

@implementation SOZOMathTests

- (void)setUp {
    self.accuracy = 0.0000001;
}

- (void)testModuloWithNegatives {
    STAssertEquals(modulo(9, 5), 4.0f, nil);
    STAssertEquals(modulo(-9, 5), 1.0f, nil);
    STAssertEquals(modulo(9, -5), -1.0f, nil);
    STAssertEquals(modulo(-9, -5), -4.0f, nil);
}

- (void)testModuloWithFractions {
    STAssertEqualsWithAccuracy(modulo(5.0 / 3.0, 3.0 / 4.0), (float) (1.0 / 6.0), self.accuracy, nil);
    STAssertEqualsWithAccuracy(modulo(5.0 / 3.0, 1), (float) (2.0 / 3.0), self.accuracy, nil);
}

@end
