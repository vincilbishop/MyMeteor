//
//  MYMeteorModelObjectBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/13/14.
//
//

#import "MYMongoModelObjectBase.h"
#import "MyiOSLogicBlocks.h"
#import "MYMeteorableModelObject.h"

@interface MYMeteorModelObjectBase : MYMongoModelObjectBase<MYMeteorableModelObject>

+ (NSArray*) collectionObjects;
+ (NSString*) collectionString;
+ (BOOL) isRegistered;
+ (void) registerModelClass;

+ (MYMeteorModelObjectBase*) objectForId:(NSString*)_id;
+ (NSArray*) objectsForIds:(NSArray*)ids;

- (void) meteorUpsertWithCompletion:(MYCompletionBlock)completionBlock;
- (void) meteorDeleteWithCompletion:(MYCompletionBlock)completionBlock;

@end
