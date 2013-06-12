//
//  PhotoLeverViewController.m
//  AllFilters
//
//  Created by dho_everest on 6/10/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

/**The purpose of modifiers.  
 Use the key in order to label the name
 The value should be a selector object.  that will call a method such as
 inputIntensity.  It will take in one value from the sliders.
 */

#import "PhotoLeverViewController.h"
#import "DHPairOfKeyAndValue.h"


@interface PhotoLeverViewController () 
@end

@implementation PhotoLeverViewController

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
    
    /**preset sliders*/
    if (_willPresetSliders) {
        [[self GetSliderValue_0] setMaximumValue:_MaxSliderVal0];
        [[self GetSliderValue_0] setMinimumValue:_MinSliderVal0];
        [[self GetSliderValue_0] setValue:_NewSliderVal0];
        
        [[self GetSliderValue_1] setMaximumValue:_MaxSliderVal1];
        [[self GetSliderValue_1] setMinimumValue:_MinSliderVal1];
        [[self GetSliderValue_1] setValue:_NewSliderVal1];
        
        [[self GetSliderValue_2] setMaximumValue:_MaxSliderVal2];
        [[self GetSliderValue_2] setMinimumValue:_MinSliderVal2];
        [[self GetSliderValue_2] setValue:_NewSliderVal2];
        
        [[self GetSliderValue_3] setMaximumValue:_MaxSliderVal3];
        [[self GetSliderValue_3] setMinimumValue:_MinSliderVal3];
        [[self GetSliderValue_3] setValue:_NewSliderVal3];
        
        [[self GetSliderValue_4] setMaximumValue:_MaxSliderVal4];
        [[self GetSliderValue_4] setMinimumValue:_MinSliderVal4];
        [[self GetSliderValue_4] setValue:_NewSliderVal4];
        
        [self ChangeSliderValue_0:[self GetSliderValue_0]];
        [self ChangeSliderValue_1:[self GetSliderValue_1]];
        [self ChangeSliderValue_2:[self GetSliderValue_2]];
        [self ChangeSliderValue_3:[self GetSliderValue_3]];
        [self ChangeSliderValue_4:[self GetSliderValue_4]];
    }
    
    if (_lastColor == nil) {
        _lastColor = [CIColor colorWithString:@"0.5 0.5 0.5 1.0"];
    }
    
    /**Set labels and connect modifiers*/
    if ([self modifier_0]) {
        [[self NameSlider_0] setText:[[self modifier_0] getKey]];
    }else{
        [[self NameSlider_0] setText:@""];
    }
    if ([self modifier_1]) {
        [[self NameSlider_1] setText:[[self modifier_1] getKey]];
    }else{
         [[self NameSlider_1] setText:@""];
    }
    if ([self modifier_2]) {
        [[self NameSlider_2] setText:[[self modifier_2] getKey]];
    }else{
         [[self NameSlider_2] setText:@""];
    }
    if ([self modifier_3]) {
        [[self NameSlider_3] setText:[[self modifier_3] getKey]];
    }else{
         [[self NameSlider_3] setText:@""];
    }
    if ([self modifier_4]) {
        [[self NameSlider_4] setText:[[self modifier_4] getKey]];
    }else{
         [[self NameSlider_4] setText:@""];
    }
    
    /**this is done here as opposed to prepareforsegue because here,things
     the image is susceptible to being set.*/
    
    //convert CIImage to CGImage because CIImage can't go directly to UIImage
    CIImage *outputImage = [[self filter] outputImage];
    CGImageRef cgimg =
    [[self context] createCGImage:outputImage
                                fromRect:[outputImage extent]];
    
    //CGImage to UIimage
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    [[self FacePic] setImage:newImage];
    
    //house keeping
    CGImageRelease(cgimg);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)ChooseNewPhoto_b:(id)sender {
    UIImagePickerController *pickerC = [UIImagePickerController new];
    [pickerC setDelegate:self];
    [self presentViewController:pickerC
                       animated:YES
                     completion:NULL];
}

- (IBAction)Choose2SavePhoto:(id)sender {
    /**Only works on real device*/
    
    // 1
    CIImage *saveToSave = [[self filter] outputImage];
    // 2
    CIContext *softwareContext = [CIContext
                                  contextWithOptions:@{kCIContextUseSoftwareRenderer : @(YES)} ];
    // 3
    CGImageRef cgImg = [softwareContext createCGImage:saveToSave
                                             fromRect:[saveToSave extent]];
    // 4
    ALAssetsLibrary* library = [[ALAssetsLibrary alloc] init];
    [library writeImageToSavedPhotosAlbum:cgImg
                                 metadata:[saveToSave properties]
                          completionBlock:^(NSURL *assetURL, NSError *error) {
                              // 5
                              CGImageRelease(cgImg);
                          }];
}

- (IBAction)back:(id)sender {
}

- (IBAction)ChangeSliderValue_0:(UISlider *)sender {
    if (_modifier_0 == nil) return;
    [self performSelector:[_modifier_0 sel] withObject:@(sender.value)];
    //[self modInputIntensityByThisValue:@(sender.value)];
    [self reapplyFiltersToCurrentImage];
}
- (IBAction)ChangeSliderValue_1:(UISlider *)sender{
    if (_modifier_1 == nil) return;
    [self performSelector:[_modifier_1 sel] withObject:@(sender.value)];
    [self reapplyFiltersToCurrentImage];
}

- (IBAction)ChangeSliderValue_2:(UISlider *)sender{
    if (_modifier_2 == nil) return;
    [self performSelector:[_modifier_2 sel] withObject:@(sender.value)];
    [self reapplyFiltersToCurrentImage];
}

- (IBAction)ChangeSliderValue_3:(UISlider *)sender{
    if (_modifier_3 == nil) return;
    [self performSelector:[_modifier_3 sel] withObject:@(sender.value)];
    [self reapplyFiltersToCurrentImage];
}

- (IBAction)ChangeSliderValue_4:(UISlider *)sender{
    if (_modifier_4 == nil) return;
    [self performSelector:[_modifier_4 sel] withObject:@(sender.value)];
    [self reapplyFiltersToCurrentImage];
}

- (void) reapplyFiltersToCurrentImage{
    /**This should happen inside a slider  It reapplys the filter*/
    CIImage *outputImage = [[self filter] outputImage];
    CGImageRef cgimg = [[self context] createCGImage:outputImage
                                            fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    /**show new pic upfront*/
    [[self FacePic] setImage:newImage];
    CGImageRelease(cgimg);
}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    //NSLog(@"%@", info);
    /**change current image*/
    //get a new reference to the image we just picked
    UIImage *gotImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //convert UIImage into CGImage then to CIImage
    [self setBeginImage:[CIImage imageWithCGImage:[gotImage CGImage]]];
    //update the uiimageview with new photo
    [[self filter] setValue:[self beginImage] forKey:kCIInputImageKey];
       
    
    //apply values of sliders onto filter
    [self ChangeSliderValue_0:[self GetSliderValue_0]];
    [self ChangeSliderValue_1:[self GetSliderValue_1]];
    [self ChangeSliderValue_2:[self GetSliderValue_2]];
    [self ChangeSliderValue_3:[self GetSliderValue_3]];
    [self ChangeSliderValue_4:[self GetSliderValue_4]];
    
    //
    [self reapplyFiltersToCurrentImage];
    
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}

- (void) modInputIntensityByThisValue:(NSNumber *)val{
     [[self filter] setValue:val forKey:@"inputIntensity"];
}
- (void) modInputColorRedByThisValue:(NSNumber *)val
{
    CIColor *color = [CIColor colorWithRed:val.floatValue
                                     green:_lastColor.green
                                      blue:_lastColor.blue];
    [[self filter] setValue:color forKey:@"inputColor"];
    _lastColor = color;
}
- (void) modInputColorGreenByThisValue:(NSNumber *)val
{
    CIColor *color = [CIColor colorWithRed:_lastColor.red
                                     green:val.floatValue
                                      blue:_lastColor.blue];
    [[self filter] setValue:color forKey:@"inputColor"];
    _lastColor = color;
}
- (void) modInputColorBlueByThisValue:(NSNumber *)val
{
    CIColor *color = [CIColor colorWithRed:_lastColor.red
                                     green:_lastColor.green
                                      blue:val.floatValue];
    [[self filter] setValue:color forKey:@"inputColor"];
    _lastColor = color;
}
- (void) modInputSaturationByThisValue:(NSNumber *)val
{
    [[self filter] setValue:val forKey:@"inputSaturation"];
}
- (void) modInputBrightnessByThisValue:(NSNumber *)val
{
    [[self filter] setValue:val forKey:@"inputBrightness"];
}
- (void) modInputContrastByThisValue:(NSNumber *)val
{
    [[self filter] setValue:val forKey:@"inputContrast"];
}
@end
