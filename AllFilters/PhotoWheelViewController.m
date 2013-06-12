//
//  PhotoWheelViewController.m
//  AllFilters
//
//  Created by dho_everest on 6/12/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "PhotoWheelViewController.h"

@interface PhotoWheelViewController ()

@end

@implementation PhotoWheelViewController

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
    //_AllFilterNames = [CIFilter filterNamesInCategory:kCICategoryBuiltIn];
    _AllFilterNames = [self filtersThatWorkWithDefaults];
       
    //loading default image of flowers
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"png"];// takes about 7 seconds on simulator
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"JPG"];//too large and slow.  takes several minutes to do anything on my iPhone 3gs, takes about 7 seconds on sim
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    [self setBeginImage:[CIImage imageWithContentsOfURL:fileNameAndPath]];
    
    
    //context determines if it is using cpu or gpu.  nil for default settings
    [self setContext:[CIContext contextWithOptions:nil]];
    
    [self setFilter:[CIFilter filterWithName:@"CIColorControls"]];
    [[self filter] setValuesForKeysWithDictionary:@{kCIInputImageKey:[self beginImage]}];

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
#pragma mark - buttons
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
#pragma  mark - Photo Library handling
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    /**change current image*/
    //get a new reference to the image we just picked
    UIImage *gotImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    //convert UIImage into CGImage then to CIImage
    [self setBeginImage:[CIImage imageWithCGImage:[gotImage CGImage]]];
    //update the uiimageview with new photo
    [[self filter] setValue:[self beginImage] forKey:kCIInputImageKey];
 
    //
    [self reapplyFiltersToCurrentImage];
    
}
-(void) imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES
                             completion:NULL];
}
- (void) reapplyFiltersToCurrentImage{
    CIImage *outputImage = [[self filter] outputImage];
    CGImageRef cgimg = [[self context] createCGImage:outputImage
                                            fromRect:[outputImage extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgimg];
    /**show new pic upfront*/
    [[self FacePic] setImage:newImage];
    CGImageRelease(cgimg);
}


#pragma mark - PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//sets the number of columns
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _AllFilterNames.count;//sets the number of rows
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _AllFilterNames[row];//returns the corresponding filter name
}
#pragma mark - PickerView delegate
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    //    [_WildCard.titleLabel setText:_AllFilterNames[row]];//changes text but text is truncated
   // NSString *newButtonTitle = [NSString stringWithFormat:@"%@ [%d/%d]",
    //                            _AllFilterNames[row],
    //                            row,
    //                            _AllFilterNames.count-1];
    //[_WildCard setTitle:newButtonTitle forState:UIControlStateNormal];//works better. don't know why
    //        NSString *WheelSelection = @"";//todo
    
    //        [destination setFilter:[CIFilter filterWithName:WheelSelection]];
    //        [[destination filter] setValuesForKeysWithDictionary:
    //         @{kCIInputImageKey:[destination beginImage]
    //         }];
    
    [self changeFilter2:_AllFilterNames[row]];
}

#pragma mark - other
- (void) changeFilter2:(NSString *)FilterName{
    //[self setBeginImage:[CIImage imageWithContentsOfURL:fileNameAndPath]];
    
    
    //context determines if it is using cpu or gpu.  nil for default settings
    [self setContext:[CIContext contextWithOptions:nil]];
    
    [self setFilter:[CIFilter filterWithName:FilterName]];
    [[self filter] setValuesForKeysWithDictionary:@{kCIInputImageKey:[self beginImage]}];
    
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

-(NSArray *)filtersThatWorkWithDefaults{
    /**All 90+ filters should techically work. In the worse case it will
     crash.  In the disappointing case, it wil show white.  
     
     below is an array of filters that either show a good picture or a moded picture*/
    return @[
             /*W*///@"CIAdditionCompositing",
             /*W*///@"CIAffineClamp",
             /*W*///@"CIAffineTile",
             @"CIAffineTransform",
             @"CIBarsSwipeTransition",
             /*W*///@"CIBlendWithMask",
             @"CIBloom",
             @"CIBumpDistortion",
             @"CIBumpDistortionLinear",
             /*C*///@"CICheckerboardGenerator",
             /*W*///@"CICircleSplashDistortion",
             @"CICircularScreen",
             @"CIColorBlendMode",
             @"CIColorBurnBlendMode",
             @"CIColorControls",
             @"CIColorCube",
             @"CIColorDodgeBlendMode",
             @"CIColorInvert",
             /*W*///@"CIColorMap",
             @"CIColorMatrix",
             @"CIColorMonochrome",
             @"CIColorPosterize",
             /*C*///@"CIConstantColorGenerator",
             /*W*///@"CICopyMachineTransition",
             @"CICrop",
             @"CIDarkenBlendMode",
             @"CIDifferenceBlendMode",
             /*W*///@"CIDisintegrateWithMaskTransition",
             @"CIDissolveTransition",
             @"CIDotScreen",
             /*W*///@"CIEightfoldReflectedTile",
             @"CIExclusionBlendMode",
             @"CIExposureAdjust",
             @"CIFalseColor",
             @"CIFlashTransition",//it shows white...it might be working properly
             /*W*///@"CIFourfoldReflectedTile",
             /*W*///@"CIFourfoldRotatedTile",
             /*W*///@"CIFourfoldTranslatedTile",
             @"CIGammaAdjust",
             @"CIGaussianBlur",
             /*C*///@"CIGaussianGradient",
             /*W*///@"CIGlideReflectedTile",
             @"CIGloom",
             @"CIHardLightBlendMode",
             @"CIHatchedScreen",
             @"CIHighlightShadowAdjust",
             @"CIHoleDistortion",
             @"CIHueAdjust",
             @"CIHueBlendMode",
             @"CILanczosScaleTransform",
             @"CILightenBlendMode",
             /*W*///@"CILightTunnel",
             /*C*///@"CILinearGradient",
             @"CILineScreen",
             @"CILuminosityBlendMode",
             /*W*///@"CIMaskToAlpha",
             @"CIMaximumComponent",
             /*W*///@"CIMaximumCompositing",
             @"CIMinimumComponent",
             /*W*///@"CIMinimumCompositing",
             /*W*///@"CIModTransition",
             @"CIMultiplyBlendMode",
             /*W*///@"CIMultiplyCompositing",
             @"CIOverlayBlendMode",
             @"CIPinchDistortion",
             @"CIPixellate",
             /*C*///@"CIRadialGradient",
             /*C*///@"CIRandomGenerator",
             @"CISaturationBlendMode",
             @"CIScreenBlendMode",
             @"CISepiaTone",
             @"CISharpenLuminance",
             /*W*///@"CISixfoldReflectedTile",
             /*W*///@"CISixfoldRotatedTile",
             /*C*///@"CISmoothLinearGradient",
             @"CISoftLightBlendMode",
             /*W*///@"CISourceAtopCompositing",
             /*W*///@"CISourceInCompositing",
             /*W*///@"CISourceOutCompositing",
             /*W*///@"CISourceOverCompositing",
             /*C*///@"CIStarShineGenerator",
             @"CIStraightenFilter",
             /*C*///@"CIStripesGenerator",
             /*W*///@"CISwipeTransition",
             @"CITemperatureAndTint",
             @"CIToneCurve",
             /*W*///@"CITriangleKaleidoscope",
             /*W*///@"CITwelvefoldReflectedTile",
             @"CITwirlDistortion",
             @"CIUnsharpMask",
             @"CIVibrance",
             @"CIVignette",
             @"CIVortexDistortion",
             @"CIWhitePointAdjust"];
    
}
@end
