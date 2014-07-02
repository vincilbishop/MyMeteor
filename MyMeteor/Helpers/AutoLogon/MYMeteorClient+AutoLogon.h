//
//  MYMeteorClient+AutoLogon.h
//  Pods
//
//  Created by Vincil Bishop on 4/19/14.
//
//

#import "MYMeteorClient.h"

@interface MYMeteorClient (AutoLogon)

- (void) clearDefaultCredentials;

- (void) logonAndSetDefaultCredentialsWithEmail:(NSString *)username password:(NSString *)password responseCallback:(MeteorClientMethodCallback)responseCallback;

- (void) logonWithDefaultCredentialsAndResponseCallback:(MeteorClientMethodCallback)responseCallback;

- (void) logoutAndClearDefaultCredentials;

- (BOOL) hasDefaultCredentials;

- (NSString*) defaultUsername;

- (NSString*) defaultPassword;

- (void) setDefaultUsername:(NSString*)username;

- (void) setDefaultPassword:(NSString*)password;

@end
