//
//  MYMeteorClient.m
//  HereByApp
//
//  Created by Vincil Bishop on 3/5/14.
//  Copyright (c) 2014 Premier Mobile Systems. All rights reserved.
//

#import "MYMeteorClient.h"
#import "MeteorClient+Private.h"

@interface MeteorClient ()

- (BOOL)_rejectIfNotConnected:(MeteorClientMethodCallback)responseCallback;

@end

@implementation MYMeteorClient

static MYMeteorClient *_sharedClient;
static NSString *_urlString;
static NSString *_ddpVersion;

+ (MYMeteorClient*) sharedClient
{
    if (!_sharedClient) {
        _sharedClient = [[MYMeteorClient alloc] init];
    }
    
    return _sharedClient;
}

+ (void) setMeteorURLString:(NSString*)urlString
{
    _urlString = urlString;
}

+ (void) setDDPVersion:(NSString*)ddpVersion
{
    _ddpVersion = ddpVersion;
}

- (id) init
{
    return [self initWithDDPVersion:_ddpVersion];
}

- (id) initWithDDPVersion:(NSString *)ddpVersion
{
    if (!ddpVersion) {
        ddpVersion = @"pre2";
    }
    
    self = [super initWithDDPVersion:ddpVersion];
    
    if (self) {
        
        NSAssert(_urlString,@"static urlString must be set!");
        
        self.ddp = [[ObjectiveDDP alloc] initWithURLString:_urlString delegate:self];
        [self.ddp connectWebSocket];
        //[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:10]];
    }
    
    return self;
}

#pragma mark - Login -

/*
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
 */

#pragma mark - Messages -

- (void) didReceiveMessage:(NSDictionary *)message
{
    [super didReceiveMessage:message];
}

#pragma mark - Connection -

- (BOOL)_rejectIfNotConnected:(MeteorClientMethodCallback)responseCallback {
    
    for (int i = 0; i < 3; i++) {
        // Let's try to connect if we aren't connected...
        if (!self.connected) {
            
            DDLogVerbose(@"Whoah...seems like we lost our meteor connection...Let's try to reconnect on a background thread and then back off for a few seconds to see if it was successful...we have tried this %i times", i + 1);
            
            [[NSOperationQueue backgroundQueue] addOperationWithBlock:^{
                @try {
                    [self.ddp connectWithSession:nil version:self.ddpVersion support:nil];
                }
                @catch (NSException *exception) {
                    DDLogVerbose(@"exception when trying to connect: %@",exception);
                }
                @finally {
                    //
                }
                
            }];
            
            // Wait a half a second
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
        }
    }
    
    return [super _rejectIfNotConnected:responseCallback];
}

@end
