//
//  SOZOMath.m
//  SOZOJulianDateConverter
//
//  Created by Tyler Tape on 1/27/14.
//  Copyright (c) 2014 Tyler Tape. All rights reserved.
//

#import "SOZOMath.h"


/**
 C does not implement a modulo function for nonintegers, and thus the following definition
 must be used for calendrical calcuations.
 */
float modulo(float numerator, float denominator) {
    return numerator - denominator * floorf(numerator/denominator);
}
