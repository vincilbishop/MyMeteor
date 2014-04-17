//
//  MYMeteorClient.m
//  HereByApp
//
//  Created by Vincil Bishop on 3/5/14.
//  Copyright (c) 2014 Premier Mobile Systems. All rights reserved.
//

#import "MYMeteorClient.h"
#import "MeteorClient+Private.h"

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

#pragma mark - Login -

- (void)logonWithUserParameters:(NSDictionary *)userParameters username:(NSString *)username password:(NSString *)password responseCallback:(MeteorClientMethodCallback)responseCallback
{
    [super logonWithUserParameters:userParameters username:username password:password responseCallback:^(NSDictionary *response, NSError *error) {
        
        if ([response logonSuccess]) {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kMyMeteor_LogonSuccess_Notification object:response];
            
        } else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kMyMeteor_LogonFailure_Notification object:error];
        }
        
        if (responseCallback) {
            responseCallback(response,error);
        }        
    }];
}

#pragma mark - Messages -

- (void) didReceiveMessage:(NSDictionary *)message
{
    DDLogVerbose(@"MYMeteorClient.didReceiveMessage:\n%@",message);
    //DDLogVerbose(@"Collections: %@",[self collections]);
    DDLogVerbose(@"Subscriptions: %@",_subscriptions);

    [super didReceiveMessage:message];
}

@end
