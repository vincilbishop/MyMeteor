//
//  MYMeteorUserObjectBase.h
//  Pods
//
//  Created by Vincil Bishop on 4/19/14.
//
//

#import "MYMeteorModelObjectBase.h"

@interface MYMeteorUserObjectBase : MYMeteorModelObjectBase

@property (nonatomic,strong) NSDate *createdAt;
@property (nonatomic,strong) NSArray *emails;
@property (nonatomic,strong) NSString *username;

@end
