//
//  MYMeteorTableViewControllerBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/2/14.
//
//

#import "MYModelObjectTableViewControllerBase.h"

@protocol MYMeteorableModelObject;

@interface MYMeteorTableViewControllerBase : MYModelObjectTableViewControllerBase

@property (nonatomic) BOOL dontSubscribeToMeteorNotifications;

- (void) configureWithClass:(Class<MYMeteorableModelObject>)modelClass;
- (void) configureSection:(NSUInteger)section withClass:(Class<MYMeteorableModelObject>)modelClass;

- (void) reloadTableViewCollection;
- (void) reloadTableViewCollectionInSection:(NSUInteger)section;
- (void) subscribeToNotifications;
- (void) unSubscribeFromNotifications;

@end
