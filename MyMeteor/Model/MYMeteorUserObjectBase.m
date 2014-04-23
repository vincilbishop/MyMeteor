//
//  MYMeteorUserObjectBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/19/14.
//
//

#import "MYMeteorUserObjectBase.h"
#import "MYMeteorUserEmail.h"

@implementation MYMeteorUserObjectBase

#pragma mark - KeyValueObjectMapping -

+ (DCKeyValueObjectMapping*) parser
{
    DCArrayMapping *mapper = [DCArrayMapping mapperForClassElements:[MYMeteorUserEmail class] forAttribute:@"emails" onClass:self];
    
    DCParserConfiguration *config = [DCParserConfiguration configuration];
    [config addArrayMapper:mapper];
    
    DCKeyValueObjectMapping *parser = [DCKeyValueObjectMapping mapperForClass:self  andConfiguration:config];
                                       
    return parser;
}

#pragma mark - MYMeteorModelObjectBase Overrides

+ (NSString*) collectionString
{
    return @"users";
}

#pragma mark - Convenience Methods -

- (MYMeteorUserEmail*) email
{
    return self.emails[0];
}

- (NSString*) emailAddress
{
    return [self emailAtIndex:0].address;
}

- (MYMeteorUserEmail*) emailAtIndex:(NSUInteger)index
{
    return self.emails[index];
}

@end
