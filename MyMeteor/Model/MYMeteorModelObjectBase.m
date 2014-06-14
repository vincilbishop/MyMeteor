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

+ (NSString*) collectionString
{
    return [[MYMeteorClient sharedClient] collectionStringForClass:self];
}

+ (BOOL) isRegistered
{
    return [[MYMeteorClient sharedClient] isRegistered:self];
}

+ (void) registerModelClass
{
    [[MYMeteorClient sharedClient] registerModelClass:self];
}

#pragma mark - Convenience Methods -

+ (MYMeteorModelObjectBase*) objectForId:(NSString*)_id
{
    id object = _.find([self collectionObjects], ^BOOL (MYMeteorModelObjectBase *candidate) {
        
        BOOL result = [candidate._id isEqualToString:_id];
        return result;
    });
    
    return object;
}


+ (NSArray*) objectsForIds:(NSArray*)ids
{
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    
    [ids enumerateObjectsUsingBlock:^(NSString *_id, NSUInteger idx, BOOL *stop) {
        
        id object = [self objectForId:_id];
        
        if (object) {
            [objects addObject:object];
        }
    }];
    
    return objects;
}

+ (NSArray*) objectsForPredicate:(NSPredicate*)predicate
{
    NSArray *objects = [[self collectionObjects] filteredArrayUsingPredicate:predicate];
    
    return objects;
}

+ (MYModelObjectBase*) objectForPredicate:(NSPredicate*)predicate
{
    NSArray *objects = [self objectsForPredicate:predicate];
    
    if (objects.count == 1) {
        
        return objects[0];
        
    } else {
        
        return nil;
    }
}


#pragma mark - CRUD -

- (void) meteorInsertWithCompletion:(MYCompletionBlock)completionBlock
{
    // TODO: Add generic code here that will map the current model object
    // with a collection, and save to the server
    NSString *message = [NSString stringWithFormat:@"Must override: %s",__PRETTY_FUNCTION__];
    NSAssert([self respondsToSelector:_cmd],message);
}

- (void) meteorUpdateWithCompletion:(MYCompletionBlock)completionBlock
{
    // TODO: Add generic code here that will map the current model object
    // with a collection, and save to the server
    NSString *message = [NSString stringWithFormat:@"Must override: %s",__PRETTY_FUNCTION__];
    NSAssert([self respondsToSelector:_cmd],message);
}

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