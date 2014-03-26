//
//  MYMeteorClient.m
//  HereByApp
//
//  Created by Vincil Bishop on 3/5/14.
//  Copyright (c) 2014 Premier Mobile Systems. All rights reserved.
//

#import "MYMeteorClient.h"

@implementation MYMeteorClient

static MYMeteorClient *_sharedClient;
static NSString *_urlString;

+ (MYMeteorClient*) sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [MYMeteorClient new];
    }
    
    return _sharedClient;
}

+ (void) setMeteorURLString:(NSString*)urlString
{
    _urlString = urlString;
}

- (id) init
{
    self = [super init];
    
    if (self) {
        
        NSAssert(_urlString,@"static urlString must be set!");
        
        self.ddp = [[ObjectiveDDP alloc] initWithURLString:_urlString delegate:self];
        [self.ddp connectWebSocket];
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
    }
    
    return self;
}


@end
