//
//  MYMeteorUserObjectBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/19/14.
//
//

#import "MYMeteorUserObjectBase.h"
#import "MYMeteorUserEmail.h"
#import "MYMeteorClient.h"

@implementation MYMeteorUserObjectBase

#pragma mark - KeyValueObjectMapping -

+ (DCParserConfiguration*) configuration
{
    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[MYMeteorUserEmail class] forAttribute:@"emails" onClass:self];
    
    DCParserConfiguration *config = [super configuration];
    [config addArrayMapper:mapper];
    
    return config;
}

#pragma mark - MYMeteorModelObjectBase Overrides

+ (NSString*) collectionString
{
    return @"users";
}

#pragma mark - Convenience Methods -

+ (MYMeteorUserObjectBase*) currentMeteorUser
{
    MYMeteorUserObjectBase *currentUser = [MYMeteorUserObjectBase objectForId:[[MYMeteorClient sharedClient] userId]];
    
    return currentUser;
}

- (NSString*) email
{
    MYMeteorUserEmail *meteorUserEmail = [self emailAtIndex:0];
    NSString *email = meteorUserEmail.address;
    return email;
}

- (MYMeteorUserEmail*) emailAtIndex:(NSUInteger)index
{
    return self.emails[index];
}

+ (void) meteorRegisterUserWithParameters:(NSDictionary*)parameters completion:(MYCompletionBlock)completionBlock
{
    NSString *message = [NSString stringWithFormat:@"Must override: %s",__PRETTY_FUNCTION__];
    NSAssert([self respondsToSelector:_cmd],message);
}

- (void) meteorUpdateUserWithParameters:(NSDictionary*)parameters completion:(MYCompletionBlock)completionBlock
{
    NSString *message = [NSString stringWithFormat:@"Must override: %s",__PRETTY_FUNCTION__];
    NSAssert([self respondsToSelector:_cmd],message);
}

@end