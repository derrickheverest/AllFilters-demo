//
//  TheJulianFilterViewController.m
//  AllFilters
//
//  Created by dho_everest on 6/17/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "TheJulianFilterViewController.h"
#import "TheJulianFilter_mark1.h"

enum SliderStates{
    CONTRAST=0,
    BRIGHT=1,
    SATURATION=2,
    SHARPNESS=3,
    RED=4,
    GREEN=5,
    BLUE=6,
    ALPHA=7,
    VIBRANCE=8,
    GAMMA=9,
    HUE=10
}SliderState;
@interface TheJulianFilterViewController ()

@end

@implementation TheJulianFilterViewController

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
#warning preload "last" with default values
    
    // 1
    NSString *filePath =
    [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    // 2
    CIImage *beginImage =
    [CIImage imageWithContentsOfURL:fileNameAndPath];
    
    // 3
    CIFilter *filter = [CIFilter filterWithName:@"TheJulianFilter_mark1"
                                  keysAndValues: kCIInputImageKey, beginImage, nil];
    [filter setValue:@(0.0) forKey:@"inputSharpness"];
    [filter setValue:[CIColor colorWithString:@"0.8 0.0 1.0 1"] forKey:@"inputColor"];
    CIImage *outputImage = [filter outputImage];
    
    // 4
    UIImage *newImage = [UIImage imageWithCIImage:outputImage];
    self.FacePic.image = newImage;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)SliderChange:(id)sender {
#warning needs implementing
    switch (SliderState) {
        case CONTRAST:
        case BRIGHT:
            break;
        case SATURATION:
            break;
        case SHARPNESS:
            break;
        case RED:
            break;
        case GREEN:
            break;
        case BLUE:
            break;
        case ALPHA:
            break;
        case VIBRANCE:
            break;
        case GAMMA:
            break;
        default:
            break;
    }

}

- (IBAction)button:(id)sender {
    //Change sliders to correspond to new key
    //Set Min/max value of slider
    //set value to last value
    //change a text label
    switch ([sender tag]) {
        case CONTRAST:
            SliderState = CONTRAST;
            [[self label] setText:@"Contrast"];
            break;
        case BRIGHT:
            SliderState = BRIGHT;
            [[self label] setText:@"Brightness"];
            break;
        case SATURATION:
            SliderState = SATURATION;
           [[self label] setText:@"Saturation"];
            break;
        case SHARPNESS:
            SliderState = SHARPNESS;
            [[self label] setText:@"Sharpness"];
            break;
        case RED:
            SliderState = RED;
            [[self label] setText:@"Red"];
            break;
        case GREEN:
            SliderState = GREEN;
           [[self label] setText:@"Green"];
            break;
        case BLUE:
            SliderState = BLUE;
           [[self label] setText:@"blue"];
            break;
        case ALPHA:
            SliderState = ALPHA;
           [[self label] setText:@"alpha"];
            break;
        case VIBRANCE:
            SliderState = VIBRANCE;
           [[self label] setText:@"Vibrance"];
            break;
        case GAMMA:
            SliderState = GAMMA;
            [[self label] setText:@"Gamma"];
            break;
        default:
            break;
    }
}
-(void) reapplyFilterToImage{
    
}
@end
