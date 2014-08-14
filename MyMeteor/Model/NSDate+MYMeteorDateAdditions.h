//
//  NSDate+MYMeteorDateAdditions.h
//  Pods
//
//  Created by Vincil Bishop on 6/16/14.
//
//

#import <Foundation/Foundation.h>

@interface NSDate (MYMeteorDateAdditions)

- (NSDictionary*) ejsonDate;
- (NSDictionary*) ejsonDateLocal;
- (NSDictionary*) ejsonDateUTC;
+ (NSDictionary*) ejsonDateWithTimeIntervalSince1970:(NSTimeInterval)timeIntervalSince1970;

@end
