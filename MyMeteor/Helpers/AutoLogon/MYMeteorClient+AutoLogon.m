//
//  MYMeteorClient+AutoLogon.m
//  Pods
//
//  Created by Vincil Bishop on 4/19/14.
//
//

#import "MYMeteorClient+AutoLogon.h"
#import "NSString+MyNilOrEmpty.h"
#import "NSError+MyAdditions.h"

#define kMYMeteorClient_DefaultUsername_Key @"kMYMeteorClient_DefaultUsername_Key"
#define kMYMeteorClient_DefaultPassword_Key @"kMYMeteorClient_DefaultPassword_Key"

@implementation MYMeteorClient (AutoLogon)

- (void) clearDefaultCredentials
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMYMeteorClient_DefaultUsername_Key];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kMYMeteorClient_DefaultPassword_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) logonAndSetDefaultCredentialsWithEmail:(NSString *)username password:(NSString *)password responseCallback:(MeteorClientMethodCallback)responseCallback
{
    [self logonWithEmail:username password:password responseCallback:^(NSDictionary *response, NSError *error) {
        
        if (!error) {
            
            [self setDefaultUsername:username];
            [self setDefaultPassword:password];
            
            if (responseCallback) {
                responseCallback(response,error);
            }
            
        } else {
            if (responseCallback) {
                responseCallback(nil,error);
            }
        }
    }];
}

- (void) logonWithDefaultCredentialsAndResponseCallback:(MeteorClientMethodCallback)responseCallback
{
    if ([self hasDefaultCredentials]) {
        
        if ([MYMeteorClient sharedClient].authState == AuthStateLoggedIn || [MYMeteorClient sharedClient].authState == AuthStateLoggingIn) {
            [[MYMeteorClient sharedClient] logout];
        }
        
        
        [self logonWithEmail:[self defaultUsername] password:[self defaultPassword] responseCallback:responseCallback];
    } else {
        if (responseCallback) {
            responseCallback(nil,[NSError genericErrorWithLocalizedDescription:@"Default credentials are not set."]);
        }
    }
}

- (void) logoutAndClearDefaultCredentials
{
    [self clearDefaultCredentials];
    [self logout];
}

- (BOOL) hasDefaultCredentials
{
    BOOL hasDefaultUsername = ![NSString isNilOrEmpty:[self defaultUsername]];
    BOOL hasDefaultPassword = ![NSString isNilOrEmpty:[self defaultPassword]];
    return hasDefaultUsername && hasDefaultPassword;
}

- (NSString*) defaultUsername
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    return [[NSUserDefaults standardUserDefaults] valueForKey:kMYMeteorClient_DefaultUsername_Key];
}

- (NSString*) defaultPassword
{
    [[NSUserDefaults standardUserDefaults] synchronize];
    return [[NSUserDefaults standardUserDefaults] valueForKey:kMYMeteorClient_DefaultPassword_Key];
}

- (void) setDefaultUsername:(NSString*)username
{
    [[NSUserDefaults standardUserDefaults] setValue:username forKey:kMYMeteorClient_DefaultUsername_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) setDefaultPassword:(NSString*)password
{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:kMYMeteorClient_DefaultPassword_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
