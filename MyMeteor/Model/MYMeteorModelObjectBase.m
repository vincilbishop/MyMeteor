//
//  MYMeteorModelObjectBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/13/14.
//
//

#import "MYMeteorModelObjectBase.h"

@implementation MYMeteorModelObjectBase

- (void) meteorSaveWithCompletion:(MYCompletionBlock)completionBlock
{
    // TODO: Add generic code here that will map the current model object
    // with a collection, and save to the server
    NSString *message = [NSString stringWithFormat:@"Must override: %s",__PRETTY_FUNCTION__];
    NSAssert([self respondsToSelector:_cmd],message);
}

- (void) meteorDeleteWithCompletion:(MYCompletionBlock)completionBlock
{
    // TODO: Add generic code here that will map the current model object
    // with a collection, and save to the server
    NSString *message = [NSString stringWithFormat:@"Must override: %s",__PRETTY_FUNCTION__];
    NSAssert([self respondsToSelector:_cmd],message);
}

@end
