//
//  MYMeteorModelControllerBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/18/14.
//
//

#import <Foundation/Foundation.h>

@protocol MYMeteorableModelObject;

@interface MYMeteorModelControllerBase : NSObject

@property (nonatomic,strong) NSString *collectionName;

- (id) initWithClass:(Class<MYMeteorableModelObject>)modelClass;

- (void) handleCollectionUpdated:(NSNotification*)notification;

@end
