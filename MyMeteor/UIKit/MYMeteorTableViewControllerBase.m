//
//  MYMeteorTableViewControllerBase.m
//  Pods
//
//  Created by Vincil Bishop on 4/2/14.
//
//

#import "MYMeteorTableViewControllerBase.h"
#import "MYMeteorClient.h"

@interface MYMeteorTableViewControllerBase ()

@property (nonatomic,strong) NSString *collectionName;

@end

@implementation MYMeteorTableViewControllerBase

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Subscription Methods -

- (void) configureForCollection:(NSString *)collectionName prameters:(NSArray*)parameters
{
    [self configureForCollection:collectionName prameters:parameters subscribe:NO];
}

- (void) configureForCollection:(NSString *)collectionName prameters:(NSArray*)parameters subscribe:(BOOL)subscribe
{
    self.collectionName = collectionName;
    
    if (subscribe) {
        [[MYMeteorClient sharedClient] addSubscription:self.collectionName withParameters:parameters];
    }
    
    NSString *notificationName = nil;
    notificationName = [NSString stringWithFormat:@"%@_added",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAdded:) name:notificationName object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_removed",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRemoved:) name:notificationName object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_changed",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChanged:) name:notificationName object:nil];
    
    [self reloadTableViewCollection];
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
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        [self reloadWithArray:[MYMeteorClient sharedClient].collections[self.collectionName]];
        
        NSLog(@"Collection: %@",[MYMeteorClient sharedClient].collections[self.collectionName]);
    }];
}

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
