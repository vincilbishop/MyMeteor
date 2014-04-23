//
//  MYMeteorTableViewControllerBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/2/14.
//
//

#import "MYMeteorTableViewControllerBase.h"
#import "MYMeteorClient.h"
#import "MYMeteorModelObjectBase.h"

@interface MYMeteorTableViewControllerBase ()

@property (nonatomic,strong) NSString *collectionName;

@end

@implementation MYMeteorTableViewControllerBase

#pragma mark - Subscription Methods -

- (void) configureWithClass:(Class<MYMeteorableModelObject>)modelClass
{
    [self configureForCollection:[modelClass collectionString] prameters:nil subscribe:NO];
    self.modelClass = modelClass;
}

- (void) configureForCollection:(NSString *)collectionName
{
    [self configureForCollection:collectionName prameters:nil subscribe:NO];
}

- (void) configureForCollection:(NSString *)collectionName prameters:(NSArray*)parameters subscribe:(BOOL)subscribe
{
    self.collectionName = collectionName;
    
    if (subscribe) {
        [[MYMeteorClient sharedClient] addSubscription:self.collectionName withParameters:parameters];
    }
    
    if (!self.dontSubscribeToMeteorNotifications) {
        [self subscribeToNotifications];
    }
    
    [self reloadTableViewCollection];
}

- (void) subscribeToNotifications
{
    self.dontSubscribeToMeteorNotifications = NO;
    
    NSString *notificationName = nil;
    notificationName = [NSString stringWithFormat:@"%@_added",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAdded:) name:notificationName object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_removed",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRemoved:) name:notificationName object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_changed",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChanged:) name:notificationName object:nil];
}

- (void) unSubscribeFromNotifications
{
    self.dontSubscribeToMeteorNotifications = YES;
    
    NSString *notificationName = nil;
    notificationName = [NSString stringWithFormat:@"%@_added",self.collectionName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_removed",self.collectionName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_changed",self.collectionName];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
}


- (void) handleCollectionUpdated:(NSNotification*)notification
{
    [self reloadTableViewCollection];
}

- (void) handleAdded:(NSNotification*)notification
{
    [self handleCollectionUpdated:notification];
}

- (void) handleRemoved:(NSNotification*)notification
{
    [self handleCollectionUpdated:notification];
}

- (void) handleChanged:(NSNotification*)notification
{
    [self handleCollectionUpdated:notification];
}

#pragma mark - Helpers -

- (void) reloadTableViewCollection
{
    DDLogVerbose(@"Reloading Collection Named %@: %@",self.collectionName,[MYMeteorClient sharedClient].collections[self.collectionName]);
    
    [self reloadWithDictionaries:[MYMeteorClient sharedClient].collections[self.collectionName]];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
