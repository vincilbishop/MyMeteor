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

//@property (nonatomic,strong) NSString *collectionName;
@property (nonatomic,strong) NSMutableArray *collectionNames;


@end

@implementation MYMeteorTableViewControllerBase

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.collectionNames = [NSMutableArray new];
    }
    return self;
}

#pragma mark - Subscription Methods -

- (void) configureWithClass:(Class<MYMeteorableModelObject>)modelClass
{
    [self configureSection:0 withClass:modelClass];
}

- (void) configureSection:(NSUInteger)section withClass:(Class<MYMeteorableModelObject>)modelClass
{
    [self configureSection:section forCollection:[modelClass collectionString] prameters:nil subscribe:NO];
    
    NSString *className = NSStringFromClass(modelClass);
    if (self.modelClassNames.count <= section) {
        [self.modelClassNames addObject:className];
    } else {
        [self.modelClassNames replaceObjectAtIndex:section withObject:className];
    }    //self.modelClass = modelClass;
}

- (void) configureSection:(NSUInteger)section forCollection:(NSString *)collectionName prameters:(NSArray*)parameters subscribe:(BOOL)subscribe
{
    if (self.collectionNames.count <= section) {
        [self.collectionNames addObject:collectionName];
    } else {
        [self.collectionNames replaceObjectAtIndex:section withObject:collectionName];
    }
    
    if (subscribe) {
        [[MYMeteorClient sharedClient] addSubscription:self.collectionNames[section] withParameters:parameters];
    }
    
    if (!self.dontSubscribeToMeteorNotifications) {
        [self subscribeToNotifications];
    }
    
    [self reloadTableViewCollectionInSection:section];
}

- (void) subscribeToNotifications
{
    self.dontSubscribeToMeteorNotifications = NO;
    
    [self.collectionNames enumerateObjectsUsingBlock:^(NSString *collectionName, NSUInteger idx, BOOL *stop) {
        
        NSString *notificationName = nil;
        notificationName = [NSString stringWithFormat:@"%@_added",collectionName];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAdded:) name:notificationName object:nil];
        
        notificationName = [NSString stringWithFormat:@"%@_removed",collectionName];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRemoved:) name:notificationName object:nil];
        
        notificationName = [NSString stringWithFormat:@"%@_changed",collectionName];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChanged:) name:notificationName object:nil];
    }];
}

- (void) unSubscribeFromNotifications
{
    self.dontSubscribeToMeteorNotifications = YES;
    
    [self.collectionNames enumerateObjectsUsingBlock:^(NSString *collectionName, NSUInteger idx, BOOL *stop) {
        
        NSString *notificationName = nil;
        notificationName = [NSString stringWithFormat:@"%@_added",collectionName];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
        
        notificationName = [NSString stringWithFormat:@"%@_removed",collectionName];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
        
        notificationName = [NSString stringWithFormat:@"%@_changed",collectionName];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notificationName object:nil];
    }];
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
    [self.collectionNames enumerateObjectsUsingBlock:^(NSString *collectionName, NSUInteger idx, BOOL *stop) {

        [self reloadTableViewCollectionInSection:idx];
    }];
}

- (void) reloadTableViewCollectionInSection:(NSUInteger)section
{
    NSString *collectionName = self.collectionNames[section];
    
    [self reloadSection:section withDictionaries:[MYMeteorClient sharedClient].collections[collectionName]];
}


- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end