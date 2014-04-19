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

- (void) configureWithClass:(Class<MYMeteorableModelObject>)modelClass;
- (void) configureForCollection:(NSString *)collectionName;
- (void) configureForCollection:(NSString *)collectionName prameters:(NSArray*)parameters subscribe:(BOOL)subscribe;

- (void) reloadTableViewCollection;

@end
