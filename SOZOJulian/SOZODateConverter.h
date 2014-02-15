//
//  SOZODateConverter.h
//  SOZOJulian
//
//  Created by Tyler Tape on 2/14/14.
//  Copyright (c) 2014 sozorogami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SOZODateConverter : NSObject

+ (NSDate *)gregorianDateFromJulianYear:(int)year month:(int)month day:(int)day;

@end
