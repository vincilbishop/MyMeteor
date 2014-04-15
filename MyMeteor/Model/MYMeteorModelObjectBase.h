//
//  MYMeteorModelObjectBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/13/14.
//
//

#import "MYMongoModelObjectBase.h"
#import "MyiOSLogicBlocks.h"

@interface MYMeteorModelObjectBase : MYMongoModelObjectBase

- (void) meteorSaveWithCompletion:(MYCompletionBlock)completionBlock;
- (void) meteorDeleteWithCompletion:(MYCompletionBlock)completionBlock;

@end
