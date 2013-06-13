//
//  ViewController.h
//  AllFilters
//
//  Created by dho_everest on 6/10/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController //<UIPickerViewDataSource, UIPickerViewDelegate>
- (IBAction)Button:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *WildCard;
@property (weak, nonatomic) IBOutlet UIPickerView *WheelOfFilters;
@property (strong, nonatomic) NSArray *AllFilterNames;
@end
