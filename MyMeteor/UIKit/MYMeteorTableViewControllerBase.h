//
//  MYMeteorTableViewControllerBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/2/14.
//
//

#import "MYModelObjectTableViewControllerBase.h"

@interface MYMeteorTableViewControllerBase : MYModelObjectTableViewControllerBase

- (void) configureForCollection:(NSString *)collectionName prameters:(NSArray*)parameters;

- (void) reloadTableViewCollection;

@end
