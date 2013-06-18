//
//  TheJulianFilterViewController.h
//  AllFilters
//
//  Created by dho_everest on 6/17/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import <UIKit/UIKit.h>

/*This was meant to be a view that would exclusively use the juilian filter.
 
 but since the project was placed on the shelf, this view remains incomplete*/


@interface TheJulianFilterViewController : UIViewController
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIImage *beginImage;
@property (strong, nonatomic) CIContext *context;


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *FacePic;
@property (weak, nonatomic) IBOutlet UISlider *Slider;
- (IBAction)SliderChange:(id)sender;
- (IBAction)button:(id)sender;

//
@property float
lastContrast, lastBrightness, lastSaturation,
lastSharpness, lastVibrance, lastGamma,
lastRed, lastGreen, lastBlue, lastAlpha;



@end
