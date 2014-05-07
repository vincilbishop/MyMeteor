//
//  MYMeteorClient+ReactiveAdditions.h
//  Pods
//
//  Created by Vincil Bishop on 5/7/14.
//
//

#import "MYMeteorClient.h"

@interface MYMeteorClient (ReactiveAdditions)

- (void) webSocketReadyBlock:(MYCompletionBlock)block;
- (void) observeWebSocketStateWithBlock:(MYCompletionBlock)block;

@end
