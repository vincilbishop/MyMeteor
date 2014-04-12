//
//  MELoginViewController.m
//  HereByApp
//
//  Created by Vincil Bishop on 3/9/14.
//  Copyright (c) 2014 Premier Mobile Systems. All rights reserved.
//

#import "MELoginViewController.h"

@interface MELoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@end

@implementation MELoginViewController

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
- (IBAction)loginPressed:(id)sender {
    [[MYMeteorClient sharedClient] logonWithUsername:self.usernameTextField.text password:self.passwordTextField.text responseCallback:^(NSDictionary *response, NSError *error) {
        
        
        if ([response logonSuccess]) {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                [self dismissViewControllerAnimated:YES completion:NULL];
            }];
        } else {
            
        }
    }];

}

@end
