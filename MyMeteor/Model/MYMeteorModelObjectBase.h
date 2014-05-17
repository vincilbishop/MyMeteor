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

/**
 *  All objects in the meteor collection represented by this class.
 *
 *  @return An NSArray with strongly typed objects.
 */
+ (NSArray*) collectionObjects;

/**
 *  The string representing the collection on the meteor server for this class.
 *
 *  @return The collection's string name.
 */
+ (NSString*) collectionString;

/**
 *  A Boolean representing whether the class has been registered with the [MYMeteorClient sharedClient] instance.
 *
 *  @return A Boolean indicating if the class has been registrered or not.
 */
+ (BOOL) isRegistered;
+ (void) registerModelClass;

+ (MYMeteorModelObjectBase*) objectForId:(NSString*)_id;
+ (NSArray*) objectsForIds:(NSArray*)ids;

- (void) meteorUpsertWithCompletion:(MYCompletionBlock)completionBlock;
- (void) meteorDeleteWithCompletion:(MYCompletionBlock)completionBlock;

@end
