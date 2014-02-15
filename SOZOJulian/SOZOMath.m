//
//  SOZOMath.m
//  SOZOJulian
//
//  Created by Brian Ivan Gesiak on 2/15/14.
//  Copyright (c) 2014 sozorogami. All rights reserved.
//

#import "SOZOMath.h"

float moduloTowardsFloor(float numerator, float denominator) {
    return numerator - denominator * floorf(numerator/denominator);
}
