//
//  MYMeteorableModelObject.h
//  Pods
//
//  Created by Vincil Bishop on 4/16/14.
//
//

#import <Foundation/Foundation.h>

@protocol MYMeteorableModelObject <NSObject,MYParseableModelObject>

+ (NSArray*) collectionObjects;
+ (NSString*) collectionString;
+ (BOOL) isRegistered;
+ (void) registerModelClass;

- (void) meteorUpsertWithCompletion:(MYCompletionBlock)completionBlock;
- (void) meteorDeleteWithCompletion:(MYCompletionBlock)completionBlock;

@end
