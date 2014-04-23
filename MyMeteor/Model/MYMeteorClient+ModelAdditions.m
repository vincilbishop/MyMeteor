//
//  MYMeteorClient+ModelAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 4/16/14.
//
//

#import "MYMeteorClient+ModelAdditions.h"
#import "MYMeteorModelObjectBase.h"

static NSMutableDictionary *_collectionClasses;

@implementation MYMeteorClient (ModelAdditions)

- (NSArray*) collectionForClass:(Class<MYMeteorableModelObject>)modelClass
{
    NSString *collectionString = [self collectionStringForClass:modelClass];
    
    if (collectionString) {
        NSArray *objects = [[modelClass parser] parseArray:[MYMeteorClient sharedClient].collections[collectionString]];
        
        return objects;
    
    } else {
        return nil;
    }
}

- (NSString*) collectionStringForClass:(Class<MYMeteorableModelObject>)modelClass
{
    NSString *collectionString = _collectionClasses[NSStringFromClass(modelClass)];
    
    if (!collectionString) {
        [self registerModelClass:modelClass];
        collectionString = [modelClass collectionString];
    }
    
    return collectionString;
}

- (BOOL) isRegistered:(Class<MYMeteorableModelObject>)modelClass
{
    if (!_collectionClasses) {
        _collectionClasses = [NSMutableDictionary new];
    }
    
    NSString *collectionName = [self collectionStringForClass:modelClass];
    BOOL isRegistered = collectionName != nil;
    return isRegistered;
}

- (void) registerModelClass:(Class<MYMeteorableModelObject>)modelClass
{
    NSString *classString = NSStringFromClass(modelClass);
    
    // Have to make an exception because meteor does not follow our naming convention :(
    //if ([classString isEqualToString:@"users"]) {
        //classString = @"user";
    //}
    
    NSString *collectionName = [[classString lowercaseString] substringFromIndex:2];
    [self registerModelClass:modelClass forCollection:collectionName];
}

- (void) registerModelClass:(Class<MYMeteorableModelObject>)modelClass forCollection:(NSString*)collectionString
{
    if (!_collectionClasses) {
        _collectionClasses = [NSMutableDictionary new];
    }
    
    [_collectionClasses setValue:collectionString forKey:NSStringFromClass(modelClass)];
}

@end
