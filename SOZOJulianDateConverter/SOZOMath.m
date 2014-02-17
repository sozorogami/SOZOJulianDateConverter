//
//  SOZOMath.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOMath.h"

float moduloTowardsFloor(float numerator, float denominator) {
    return numerator - denominator * floorf(numerator/denominator);
}
