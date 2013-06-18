//
//  ViewController.m
//  AllFilters
//
//  Created by dho_everest on 6/10/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
      
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)unwindToFilterTableViewController:(UIStoryboardSegue *)segue{
    
}

#pragma mark - Preset Filters
-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
       
}
#pragma mark - Respond to buttons
- (IBAction)Button:(id)sender {
    if ([[sender restorationIdentifier] isEqualToString:@"AllTheSingleFilters"]) {
        [self performSegueWithIdentifier:@"segue2AllTheSingleFilters"
                                  sender:sender];
    }else if ([[sender restorationIdentifier] isEqualToString:@"JulianFilter"]){
        [self performSegueWithIdentifier:@"segue2JulianFilter"
                                  sender:sender];
    }
}
@end
