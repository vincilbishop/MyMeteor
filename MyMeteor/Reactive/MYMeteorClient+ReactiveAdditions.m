//
//  MYMeteorClient+ReactiveAdditions.m
//  Pods
//
//  Created by Vincil Bishop on 5/7/14.
//
//

#import "MYMeteorClient+ReactiveAdditions.h"

@implementation MYMeteorClient (ReactiveAdditions)

- (void) connectionReadyBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], connected) subscribeNext:^(NSNumber *connected) {
            
            if ([connected boolValue]) {
                [subscriber sendNext:@[subscriber,connected]];
                
                [subscriber sendCompleted];
            }
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *connected = result[1];
        if (block) {
            block(subscriber,YES,nil,connected);
        }
    }];
    
}

- (void) webSocketReadyBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], websocketReady) subscribeNext:^(NSNumber *websocketReady) {
            
            if ([websocketReady boolValue]) {
                [subscriber sendNext:@[subscriber,websocketReady]];
                
                [subscriber sendCompleted];
            }
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *websocketReady = result[1];
        if (block) {
            block(subscriber,YES,nil,websocketReady);
        }
    }];

}

- (void) observeConnectionStateWithBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], connected) subscribeNext:^(NSNumber *connected) {
            
            [subscriber sendNext:@[subscriber,connected]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *connected = result[1];
        if (block) {
            block(subscriber,YES,nil,connected);
        }
    }];
    
}


- (void) observeWebSocketStateWithBlock:(MYCompletionBlock)block
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], websocketReady) subscribeNext:^(NSNumber *websocketReady) {
            
            [subscriber sendNext:@[subscriber,websocketReady]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSNumber *websocketReady = result[1];
        if (block) {
            block(subscriber,YES,nil,websocketReady);
        }
    }];

}

- (void) observeChangesForCollection:(NSString*)collectionString onChangeBlock:(MYCompletionBlock)onChangeBlock
{
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        return [RACObserve([MYMeteorClient sharedClient], collections[collectionString]) subscribeNext:^(NSArray *collection) {
            
            [subscriber sendNext:@[subscriber,collection]];
        }];
    }];
    
    [signal subscribeNext:^(NSArray *result) {
        
        id<RACSubscriber> subscriber = result[0];
        NSArray *collection = result[1];
        if (onChangeBlock) {
            onChangeBlock(subscriber,YES,nil,collection);
        }
    }];
}

@end
