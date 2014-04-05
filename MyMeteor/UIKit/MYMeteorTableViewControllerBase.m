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
    self.collectionName = [collectionName lowercaseString];
    [[MYMeteorClient sharedClient] addSubscription:self.collectionName withParameters:parameters];
    
    NSString *notificationName = nil;
    notificationName = [NSString stringWithFormat:@"%@_added",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleAdded:) name:nil object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_removed",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleRemoved:) name:nil object:nil];
    
    notificationName = [NSString stringWithFormat:@"%@_changed",self.collectionName];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleChanged:) name:nil object:nil];
    
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
    }];
}

#pragma mark - UITableViewDataSource -


#pragma mark - UITableViewDelgate -


@end
