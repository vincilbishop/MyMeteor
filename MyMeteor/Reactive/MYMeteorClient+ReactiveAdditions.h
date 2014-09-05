//
//  MYMeteorClient+ReactiveAdditions.h
//  Pods
//
//  Created by Vincil Bishop on 5/7/14.
//
//

#import "MYMeteorClient.h"

@interface MYMeteorClient (ReactiveAdditions)

- (void) authenticatedBlock:(MYCompletionBlock)block;
- (void) connectWithCompletion:(MYCompletionBlock)completion;
- (void) connectionReadyBlock:(MYCompletionBlock)block;
- (void) webSocketReadyBlock:(MYCompletionBlock)block;
- (void) observeConnectionStateWithBlock:(MYCompletionBlock)block;
- (void) observeWebSocketStateWithBlock:(MYCompletionBlock)block;
- (void) observeCollectionChangesWithBlock:(MYCompletionBlock)block;
- (void) observeChangesForCollection:(NSString*)collection withBlock:(MYCompletionBlock)block;

@end
