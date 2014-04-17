//
//  MYMeteorClient+ModelAdditions.h
//  Pods
//
//  Created by Vincil Bishop on 4/16/14.
//
//

#import "MYMeteorClient.h"

@protocol MYMeteorableModelObject;

typedef void (^MYMeteorObjectBlock)(NSArray *objects);



@interface MYMeteorClient (ModelAdditions)

- (NSArray*) collectionForClass:(Class<MYMeteorableModelObject>)modelClass;

- (BOOL) isRegistered:(Class<MYMeteorableModelObject>)modelClass;

- (void) registerModelClass:(Class<MYMeteorableModelObject>)modelClass;

- (void) registerModelClass:(Class<MYMeteorableModelObject>)modelClass forCollection:(NSString*)collectionString;

@end
