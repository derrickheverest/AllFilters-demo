//
//  ViewController.m
//  AllFilters
//
//  Created by dho_everest on 6/10/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "ViewController.h"
#import "PhotoLeverViewController.h"
#import "DHPairOfKeyAndValue.h"

#define mySELInputIntensity @selector(modInputIntensityByThisValue:)
#define mySELInputColorRed @selector(modInputColorRedByThisValue:)
#define mySELInputColorGreen @selector(modInputColorGreenByThisValue:)
#define mySELInputColorBlue @selector(modInputColorBlueByThisValue:)
#define mySELInputSaturation @selector(modInputSaturationByThisValue:)
#define mySELInputBrightness @selector(modInputBrightnessByThisValue:)
#define mySELInputContrast @selector(modInputContrastByThisValue:)

static const NSString *mykInputIntensity = @"inputIntensity";
static const NSString *mykInputColor = @"inputColor";
static const NSString *mykInputSaturation = @"inputSaturation";
static const NSString *mykInputBrightness = @"inputBrightness";
static const NSString *mykInputContrast = @"inputContrast";

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _AllFilterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    
    [self logAllFilters];
	// Do any additional setup after loading the view, typically from a nib.
    //[[self WheelOfFilters] setDelegate:self];
   
}

-(void)logAllFilters {
    NSArray *properties = [CIFilter filterNamesInCategory:
                           kCICategoryBuiltIn];
    //NSLog(@">>Properties<< \n%@", properties);
    for (NSString *filterName in properties) {
        CIFilter *fltr = [CIFilter filterWithName:filterName];
        NSLog(@"\n%@\n>>Attributes<<\n%@", filterName, [fltr attributes]);
    }
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
    PhotoLeverViewController *destination = [segue destinationViewController];
    
    //loading default image of flowers
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"png"];// takes about 7 seconds on simulator
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"JPG"];//too large and slow.  takes several minutes to do anything on my iPhone 3gs, takes about 7 seconds on sim
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    [destination setBeginImage:[CIImage imageWithContentsOfURL:fileNameAndPath]];
    
    
    //context determines if it is using cpu or gpu.  nil for default settings
    [destination setContext:[CIContext contextWithOptions:nil]];
    //--------------------------------------------------
    [destination setWillPresetSliders:YES];
    //choose specific filter based on the button chosen
    //and preset the slider values away from default.
    if ([[sender restorationIdentifier] isEqualToString:@"SepiaTone"]) {
        
        /**decide filter*/
        [destination setFilter:[CIFilter filterWithName:@"CISepiaTone"]];
        [[destination filter] setValuesForKeysWithDictionary:
         @{kCIInputImageKey:[destination beginImage],
                                           mykInputIntensity:@0.8}];
        /**change add label and connect slider to a method*/
        DHPairOfKeyAndValue *m0 = [DHPairOfKeyAndValue new];
        [m0 setKey:@"Input Intensity"
          setSEL:mySELInputIntensity];
        [destination setModifier_0:m0];
        /**preset slider*/
       NSDictionary *filterRanges =[[[CIFilter filterWithName:@"CISepiaTone"] attributes] objectForKey:mykInputIntensity];

        [destination setMinSliderVal0:[filterRanges[@"CIAttributeSliderMin"] floatValue]];
        [destination setMaxSliderVal0:[filterRanges[@"CIAttributeSliderMax"] floatValue]];
        [destination setNewSliderVal0:[filterRanges[@"CIAttributeDefault"] floatValue]];
        
//        [destination setMinSliderVal0:0.0];
//        [destination setMaxSliderVal0:2.0];
//        [destination setNewSliderVal0:1.0];
        
    }else if ([[sender restorationIdentifier] isEqualToString:@"Monochrome"]){
        /**decide filter*/
        [destination setFilter:[CIFilter filterWithName:@"CIColorMonochrome"]];
        [[destination filter] setValuesForKeysWithDictionary:
         @{kCIInputImageKey:[destination beginImage],
                                           mykInputIntensity:@0.8,
                                               mykInputColor: [CIColor colorWithString:@"0.8 0.8 0.8 1.0"],
         }];
        /**change add label and connect slider to a method*/
        DHPairOfKeyAndValue *m0 = [DHPairOfKeyAndValue new];
        [m0 setKey:@"Input Intensity" setSEL:mySELInputIntensity];
        [destination setModifier_0:m0];
        DHPairOfKeyAndValue *m1 = [DHPairOfKeyAndValue new];
        [m1 setKey:@"red" setSEL:mySELInputColorRed];
        [destination setModifier_1:m1];
        DHPairOfKeyAndValue *m2 = [DHPairOfKeyAndValue new];
        [m2 setKey:@"green" setSEL:mySELInputColorGreen];
        [destination setModifier_2:m2];
        DHPairOfKeyAndValue *m3 = [DHPairOfKeyAndValue new];
        [m3 setKey:@"blue" setSEL:mySELInputColorBlue];
        [destination setModifier_3:m3];
        /**preset slider*/
        [destination setMinSliderVal0:0.0];
        [destination setMaxSliderVal0:1.0];
        [destination setNewSliderVal0:0.8];
        
        [destination setMinSliderVal1:0.0];
        [destination setMaxSliderVal1:1.0];
        [destination setNewSliderVal1:0.8];
        
        [destination setMinSliderVal2:0.0];
        [destination setMaxSliderVal2:1.0];
        [destination setNewSliderVal2:0.8];
        
        [destination setMinSliderVal3:0.0];
        [destination setMaxSliderVal3:1.0];
        [destination setNewSliderVal3:0.8];
    }else if([[sender restorationIdentifier] isEqualToString:@"ColorControls"]){
        /**decide filter*/
        [destination setFilter:[CIFilter filterWithName:@"CIColorControls"]];
        [[destination filter] setValuesForKeysWithDictionary:
         @{kCIInputImageKey:[destination beginImage]
         }];
        /**change add label and connect slider to a method*/
        DHPairOfKeyAndValue *m0 = [DHPairOfKeyAndValue new];
        [m0 setKey:@"Input saturation" setSEL:mySELInputSaturation];
        [destination setModifier_0:m0];
        DHPairOfKeyAndValue *m1 = [DHPairOfKeyAndValue new];
        [m1 setKey:@"Input brightness" setSEL:mySELInputBrightness];
        [destination setModifier_1:m1];
        DHPairOfKeyAndValue *m2 = [DHPairOfKeyAndValue new];
        [m2 setKey:@"Input Contrast" setSEL:mySELInputContrast];
        [destination setModifier_2:m2];
        /**preset slider*/
        
        [destination setMinSliderVal0:0.0];
        [destination setMaxSliderVal0:10.0];
        [destination setNewSliderVal0:1.0];

        [destination setMinSliderVal1:0.0];
        [destination setMaxSliderVal1:1.0];
        [destination setNewSliderVal1:0.0];
        
        [destination setMinSliderVal2:0.0];
        [destination setMaxSliderVal2:2.0];
        [destination setNewSliderVal2:1.0];
        


    }
    else if([[sender restorationIdentifier] isEqualToString:@"WildCard"]){
        [destination setWillPresetSliders:NO];
//        NSString *WheelSelection = @"";//todo
        
//        [destination setFilter:[CIFilter filterWithName:WheelSelection]];
//        [[destination filter] setValuesForKeysWithDictionary:
//         @{kCIInputImageKey:[destination beginImage]
//         }];
        
        //if you want, you can link the options to the sliders
    }
    //--------------------------------------------------
}
#pragma mark - Respond to buttons
- (IBAction)Button:(id)sender {
    if ([[sender restorationIdentifier] isEqualToString:@"WildCard"]) {
        [self performSegueWithIdentifier:@"segue2wheeloffilter"
                                  sender:sender];
    }else{
        [self performSegueWithIdentifier:@"segue2uiimageview"
                                  sender:sender];
    }
}
@end
