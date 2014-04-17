//
//  MYMeteorModelObjectBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/13/14.
//
//

#import "MYMeteorModelObjectBase.h"
#import "MYMeteorClient+ModelAdditions.h"
#import "MYMeteorableModelObject.h"

@implementation MYMeteorModelObjectBase

#pragma mark - Model Helpers -

+ (NSArray*) collectionObjects
{
    if (![self isRegistered]) {
        [self registerModelClass];
    }
    return [[MYMeteorClient sharedClient] collectionForClass:self];
}

+ (BOOL) isRegistered
{
    return [[MYMeteorClient sharedClient] isRegistered:self];
}

+ (void) registerModelClass
{
    [[MYMeteorClient sharedClient] registerModelClass:self];
}

#pragma mark - CRUD -

- (void) meteorUpsertWithCompletion:(MYCompletionBlock)completionBlock
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