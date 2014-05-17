//
//  MYMeteorUserObjectBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/19/14.
//
//

#import "MYMeteorModelObjectBase.h"
#import "MYMeteorUserEmail.h"

@interface MYMeteorUserObjectBase : MYMeteorModelObjectBase

/**
 *  The date the object was creatd.
 */
@property (nonatomic,strong) NSDate *createdAt;

/**
 *  Emails associated with the object.
 */
@property (nonatomic,strong) NSArray *emails;

/**
 *  A dictionary representation of the user's profile field in meteor.
 */
@property (nonatomic,strong) NSDictionary *profileDictionary;

/**
 *  The username assocaiated with the object.
 */
@property (nonatomic,strong) NSString *username;

/**
 *  Convenience method to return the current user logged in to Meteor.
 *
 *  @return The logged in meteor user.
 */
+ (MYMeteorUserObjectBase*) currentMeteorUser;

/**
 *  The first email address in the user's email collection.
 *
 *  @return The user's first email address.
 */
- (NSString*) email;

/**
 *  An object representing a meteor email record.
 *
 *  @param index The ordinal for the email record to return.
 *
 *  @return A strongly types record representing a Meteor email address.
 */
- (MYMeteorUserEmail*) emailAtIndex:(NSUInteger)index;

/**
 *  A standard convenience method to register a new user on the server. This method must be overridden.
 *
 *  @param parameters      Key value pairs with the data needed to register a user in meteor.
 *  @param completionBlock The block to call on completion with results of thge Meteor server transaction.
 */
+ (void) meteorRegisterUserWithParameters:(NSDictionary*)parameters completion:(MYCompletionBlock)completionBlock;

/**
 *  A standard convenience method to update a new user on the server. This method must be overridden.
 *
 *  @param parameters      Key value pairs with the data needed to update a user in meteor.
 *  @param completionBlock The block to call on completion with results of thge Meteor server transaction.
 */
- (void) meteorUpdateUserWithParameters:(NSDictionary*)parameters completion:(MYCompletionBlock)completionBlock;

@end