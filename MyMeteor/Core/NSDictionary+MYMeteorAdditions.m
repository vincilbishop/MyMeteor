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

- (NSDictionary*) result
{
    id result = [self valueForKey:@"result"];
    if ([result isKindOfClass:[NSDictionary class]]) {
        return result;
    } else {
        return nil;
    }
}

- (NSArray*) resultArray
{
    id result = [self valueForKey:@"result"];
    if ([result isKindOfClass:[NSArray class]]) {
        return result;
    } else {
        return nil;
    }
}

- (BOOL) responseSuccess
{
    id result = [self valueForKey:@"result"];
    return result != nil;
}


@end
