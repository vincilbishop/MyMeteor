//
//  MYMeteorModelObjectBase+ReactiveAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 6/11/14.
//
//

#import "MYMeteorModelObjectBase+ReactiveAdditions.h"
#import "MYMeteorClient+ReactiveAdditions.h"

@implementation MYMeteorModelObjectBase (ReactiveAdditions)

/*
+ (void) observeCollectionObjects:(MYCompletionBlock)onChangeBlock
{
    if (onChangeBlock) {
        [[MYMeteorClient sharedClient] observeChangesForCollection:[self collectionString] onChangeBlock:^(id sender, BOOL success, NSError *error, id result) {
            
            onChangeBlock(self,YES,nil,[self collectionObjects]);
            
        }];
    }
}
 */

@end
