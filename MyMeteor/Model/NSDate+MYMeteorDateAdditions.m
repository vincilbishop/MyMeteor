//
//  NSDate+MYMeteorDateAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 6/16/14.
//
//

#import "NSDate+MYMeteorDateAdditions.h"

@implementation NSDate (MYMeteorDateAdditions)

- (NSDictionary*) ejsonDate
{
    return [self ejsonDateLocal];
}

- (NSDictionary*) ejsonDateLocal
{
    return [NSDate ejsonDateWithTimeIntervalSince1970:[self timeIntervalSince1970]];
}


- (NSDictionary*) ejsonDateUTC
{
    return [NSDate ejsonDateWithTimeIntervalSince1970:[self UTCTimeIntervalSince1970]];
}

+ (NSDictionary*) ejsonDateWithTimeIntervalSince1970:(NSTimeInterval)timeIntervalSince1970
{
    float ticks = timeIntervalSince1970 * 1000;
    NSDictionary *ejsonDate = @{
                                @"$date": [NSNumber numberWithFloat:ticks]
                                };
    
    return ejsonDate;
}

@end
