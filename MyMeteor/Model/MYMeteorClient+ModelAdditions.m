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
    NSString *classString = NSStringFromClass(modelClass);
    NSString *collectionString = [_collectionClasses objectForKey:classString];
    
    NSAssert(collectionString,@"Must first register model class using: - (void) registerModelClass:(Class<MYMeteorableModelObject>)modelClass forCollection:(NSString*)collectionString");
    
    if (collectionString) {
        NSArray *objects = [[modelClass parser] parseArray:[MYMeteorClient sharedClient].collections[collectionString]];
        
        return objects;
    
    } else {
        return nil;
    }
}

- (NSString*) collectionStringForClass:(Class<MYMeteorableModelObject>)modelClass
{
    NSString *collectionName = _collectionClasses[NSStringFromClass(modelClass)];
    return collectionName;
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
    //NSRange range = NSMakeRange(2, classString.length - 1);
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
