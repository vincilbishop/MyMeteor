//
//  MEViewController.m
//  MyMeteorExample
//
//  Created by Vincil Bishop on 4/11/14.
//  Copyright (c) 2014 Premier Mobile Systems. All rights reserved.
//

#import "MEViewController.h"
#import "MELoginViewController.h"

@interface MEViewController ()

@end

@implementation MEViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
}
-(void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // Do any additional setup after loading the view, typically from a nib.
    if ([[MYMeteorClient sharedClient] userId]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didReceiveCarUpdate:)
                                                     name:@"car_added"
                                                   object:nil];
        
        [[MYMeteorClient sharedClient] addSubscription:@"car" withParameters:@[@"Ford"]];
        
        [[MYMeteorClient sharedClient] callMethodName:@"testMethod" parameters:@[@"myParameter"] responseCallback:^(NSDictionary *response, NSError *error) {
            
            if ([response result]) {
                NSLog(@"result: %@",[response result]);
            }
            
        }];
        
    } else {
        UIStoryboard *mainStorboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
        MELoginViewController *controller = [mainStorboard instantiateViewControllerWithIdentifier:@"MELoginViewController"];
        [self presentViewController:controller animated:YES completion:NULL];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didReceiveCarUpdate:(NSNotification*)notification
{
    NSLog(@"notification.userInfo: %@",notification.userInfo);
    NSLog(@"Cars Collection: %@",[MYMeteorClient sharedClient].collections[@"car"]);
}

@end