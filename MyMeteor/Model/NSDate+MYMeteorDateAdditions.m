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
    float ticks = [self timeIntervalSince1970] * 1000;
    NSDictionary *ejsonDate = @{
                                @"$date": [NSNumber numberWithFloat:ticks]
                                };
    
    return ejsonDate;
}

@end
