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
        
        [[NSOperationQueue currentQueue] tryOperationWithBlock:^{
            [self.ddp connectWebSocket];
        } successTest:^BOOL{
            return self.connected;
        } repeatCount:30 waitBetweenTries:1];
        
        if (self.connected) {
            DDLogVerbose(@"Connected To: %@",_urlString);
        }
        
        
    }
    
    return self;
}

#pragma mark - Login -

- (void) logonWithFacebookData:(NSDictionary*)fbData accessToken:(NSString*)accessToken completion:(MYCompletionBlock)completionBlock
{
    NSDictionary *parameters = @{@"fbData":fbData,@"accessToken":accessToken};
    [[MYMeteorClient sharedClient] callMethodName:@"login" parameters:@[parameters] responseCallback:^(NSDictionary *response, NSError *error) {
        
        DDLogVerbose(@"Result: %@",response);
        
        /*
         {
         id = 1;
         msg = result;
         result =     {
         id = jhb255NjvEWjCW5Hr;
         token = "TzxtMyH-x8TsX5ZljZvdKPpC4OpHDy_Y_EM039bRGjZ";
         tokenExpires =         {
         "$date" = 1411144402240;
         };
         };
         }
         */
        [MYMeteorClient sharedClient].userId = [response valueForKeyPath:@"result.id"];
        [MYMeteorClient sharedClient]->_sessionToken = [response valueForKeyPath:@"result.token"];
        [[MYMeteorClient sharedClient] _setAuthStateToLoggedIn];
        
        if(completionBlock){
            completionBlock(self,error == nil,error,response);
        }
        
    }];
}


#pragma mark - Messages -

- (void) didReceiveMessage:(NSDictionary *)message
{
    [super didReceiveMessage:message];
}

#pragma mark - Connection -

- (BOOL)_rejectIfNotConnected:(MeteorClientMethodCallback)responseCallback {
    
    [[NSOperationQueue backgroundQueue] tryOperationWithBlock:^{
        [self.ddp connectWithSession:nil version:self.ddpVersion support:@[self.ddpVersion]];
    } successTest:^BOOL{
        return self.connected;
    } repeatCount:30 waitBetweenTries:1];

    
    /*
    for (int i = 0; i < 30; i++) {
        // Let's try to connect if we aren't connected...
        if (!self.connected) {
            
            DDLogVerbose(@"Whoah...seems like we lost our meteor connection...Let's try to reconnect on a background thread and then back off for a few seconds to see if it was successful...we have tried this %i times", i + 1);
            
            [[NSOperationQueue backgroundQueue] addOperationWithBlock:^{
                @try {
                    [self.ddp connectWithSession:nil version:self.ddpVersion support:@[self.ddpVersion]];
                }
                @catch (NSException *exception) {
                    DDLogVerbose(@"exception when trying to connect: %@",exception);
                }
                @finally {
                    //
                }
                
            }];
            
            // Wait a second
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
            
        }
    }
    */
    
    return [super _rejectIfNotConnected:responseCallback];
}

@end
