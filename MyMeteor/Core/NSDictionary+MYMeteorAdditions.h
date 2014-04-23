//
//  NSDictionary+MYMeteorAdditions.h
//  Pods
//
//  Created by Vincil Bishop on 3/9/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MYMeteorAdditions)

- (BOOL) logonSuccess;
- (NSDictionary*) result;
- (NSArray*) resultArray;
- (BOOL) responseSuccess;

@end
