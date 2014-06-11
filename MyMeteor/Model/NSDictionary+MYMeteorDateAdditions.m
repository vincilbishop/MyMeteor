//
//  NSDictionary+MYMeteorDateAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 6/9/14.
//
//

#import "NSDictionary+MYMeteorDateAdditions.h"

@implementation NSDictionary (MYMeteorDateAdditions)

#pragma mark - Date Helpers -

- (NSDate*) meteorDate
{
    NSString *ticks = self[@"$date"];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[ticks doubleValue]/1000];
    return date;
}

@end
