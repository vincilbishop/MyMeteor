//
//  NSDictionary+MYMeteorAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 3/9/14.
//
//

#import "NSDictionary+MYMeteorAdditions.h"

@implementation NSDictionary (MYMeteorAdditions)

- (BOOL) logonSuccess
{
    NSString *loginResult = [self valueForKey:@"logon"];
    return [loginResult isEqualToString:@"success"];
}

- (id) result
{
    NSString *result = [self valueForKey:@"result"];
    return result;
}

@end
