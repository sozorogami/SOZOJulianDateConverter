//
//  SOZOJulianDate.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOJulianDate.h"
#import "SOZOGregorianDate.h"
#import "SOZOMath.h"

@implementation SOZOJulianDate

#pragma mark - Internal Methods

+ (int)epoch {
    return [[[SOZOGregorianDate alloc] initWithYear:0 month:12 day:30] daysSinceEpoch];
}

- (int)leapDaysSinceEpoch{
    return floor(([self adjustedYear] - 1) / 4.0);
}

- (int)nonleapDaysSinceEpoch {
    return 365 * ([self adjustedYear] - 1);
}

- (BOOL)isLeapYear{
    float remainder = modulo(self.year, 4);
    return self.year > 0 ? remainder == 0 : remainder == 3;
}

+ (int)yearFromFixed:(int)fixedDay{
    int approx = floor((4 * (fixedDay - [self epoch]) + 1464) / 1461.0);
    return approx <= 0 ? approx - 1 : approx;
}

//Adjustment for lack of year 0
- (int)adjustedYear{
    return [self year] < 0 ? [self year] + 1 : [self year];
}

@end
