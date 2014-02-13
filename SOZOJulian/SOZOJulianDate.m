//
//  SOZOJulianDate.m
//  TheCalendar
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOJulianDate.h"
#import "SOZOGregorianDate.h"

@implementation SOZOJulianDate

- (id)initWithYear:(int)year month:(int)month day:(int)day
{
    self = [super initWithYear:year month:month day:day];
    return self;
}

+ (int)epoch{
    return [[[SOZOGregorianDate alloc] initWithYear:0 month:12 day:30] asFixed];
}

//Adjustment for lack of year 0
- (int)adjustedYear{
    return [self year] < 0 ? [self year] + 1 : [self year];
}

- (int)nonleapDaysSinceEpoch{
    return 365 * ([self adjustedYear] - 1);
}

- (BOOL)isLeapYear{
    return [self year] > 0 ? [[self class] mod:[self year] y:4] == 0 : [[self class] mod:[self year] y:4] == 3;
}

- (int)leapDaysSinceEpoch{
    return floor(([self adjustedYear] - 1) / 4.0);
}

+ (int)yearFromFixed:(int)fixedDay{
    int approx = floor((4 * (fixedDay - [self epoch]) + 1464) / 1461.0);
    return approx <= 0 ? approx - 1 : approx;
}

@end
