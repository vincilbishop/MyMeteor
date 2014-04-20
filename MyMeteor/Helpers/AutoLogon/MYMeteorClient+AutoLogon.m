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

- (void) logonAndSetDefaultCredentialsWithUsername:(NSString *)username password:(NSString *)password responseCallback:(MeteorClientMethodCallback)responseCallback
{
    [self logonWithUsername:username password:password responseCallback:^(NSDictionary *response, NSError *error) {
        
        if ([response logonSuccess]) {
            
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
        [[MYMeteorClient sharedClient] logout];
        [self logonWithUsername:[self defaultUsername] password:[self defaultPassword] responseCallback:responseCallback];
    } else {
        if (responseCallback) {
            responseCallback(nil,[NSError genericErrorWithLocalizedDescription:@"Default credentials are not set."]);
        }
    }
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
