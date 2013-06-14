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

#define mySELInputIntensity @selector(modInputIntensityByThisValue:)
#define mySELInputColorRed @selector(modInputColorRedByThisValue:)
#define mySELInputColorGreen @selector(modInputColorGreenByThisValue:)
#define mySELInputColorBlue @selector(modInputColorBlueByThisValue:)
#define mySELInputSaturation @selector(modInputSaturationByThisValue:)
#define mySELInputBrightness @selector(modInputBrightnessByThisValue:)
#define mySELInputContrast @selector(modInputContrastByThisValue:)

#define mykInputIntensity @"inputIntensity"
#define mykInputColor @"inputColor"
#define mykInputSaturation @"inputSaturation"
#define mykInputBrightness @"inputBrightness"
#define mykInputContrast @"inputContrast"

NSDictionary *SupportedLevers = nil;

@interface PhotoLeverViewController ()
//@property (strong, nonatomic) NSString *barnacle;
- (BOOL)loadDefaultPhoto;
- (void)loadDefaultFilter;
- (void)loadDefaultLabels;
- (void)loadDefaultSliders;
- (void)loadSupportedLevers;
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
    
    [self loadSupportedLevers];
    [self loadDefaultPhoto];
    [self loadDefaultLabels];
    [self loadDefaultSliders];
    [self loadDefaultFilter];
    
    //
    [self ChangeSliderValue_0:[self GetSliderValue_0]];
    [self ChangeSliderValue_1:[self GetSliderValue_1]];
    [self ChangeSliderValue_2:[self GetSliderValue_2]];
    [self ChangeSliderValue_3:[self GetSliderValue_3]];
    [self ChangeSliderValue_4:[self GetSliderValue_4]];
    
    if (_lastColor == nil) {
        _lastColor = [CIColor colorWithString:@"0.5 0.5 0.5 1.0"];
    }
    
    /**Set labels and connect modifiers*/
//    if ([self modifier_0]) {
//        [[self NameSlider_0] setText:[[self modifier_0] getKey]];
//    }else{
//        [[self NameSlider_0] setText:@""];
//    }
//    if ([self modifier_1]) {
//        [[self NameSlider_1] setText:[[self modifier_1] getKey]];
//    }else{
//         [[self NameSlider_1] setText:@""];
//    }
//    if ([self modifier_2]) {
//        [[self NameSlider_2] setText:[[self modifier_2] getKey]];
//    }else{
//         [[self NameSlider_2] setText:@""];
//    }
//    if ([self modifier_3]) {
//        [[self NameSlider_3] setText:[[self modifier_3] getKey]];
//    }else{
//         [[self NameSlider_3] setText:@""];
//    }
//    if ([self modifier_4]) {
//        [[self NameSlider_4] setText:[[self modifier_4] getKey]];
//    }else{
//         [[self NameSlider_4] setText:@""];
//    }
    
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

#pragma mark - Supported Levers
- (void) loadSupportedLevers{
    if(SupportedLevers){ return;}
    
    SupportedLevers =
    @{mykInputColor:[NSArray arrayWithObjects:
                     [[DHPairOfKeyAndValue new] setKey:mykInputColor
                                                setSEL:mySELInputColorRed
                                              setLabel:@"Red"],
                     [[DHPairOfKeyAndValue new] setKey:mykInputColor
                                                setSEL:mySELInputColorGreen
                                              setLabel:@"Green"],
                     [[DHPairOfKeyAndValue new] setKey:mykInputColor
                                                setSEL:mySELInputColorBlue
                                              setLabel:@"Blue"],
                     nil],
      mykInputIntensity: [[DHPairOfKeyAndValue new] setKey:mykInputIntensity
                                                    setSEL:mySELInputIntensity
                                                  setLabel:@"Intensity"],
      mykInputSaturation: [[DHPairOfKeyAndValue new] setKey:mykInputSaturation
                                                     setSEL:mySELInputSaturation
                                                   setLabel:@"Saturation"],
      mykInputBrightness: [[DHPairOfKeyAndValue new] setKey:mykInputBrightness
                                                     setSEL:mySELInputBrightness
                                                   setLabel:@"Brightness"],
      mykInputContrast: [[DHPairOfKeyAndValue new] setKey:mykInputContrast
                                                   setSEL:mySELInputContrast
                                                 setLabel:@"Contrast"]
      };
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


#pragma mark - Load Defaults
- (BOOL)loadDefaultPhoto{
    //loading default image of flowers
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"image" ofType:@"png"];
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"png"];// takes about 7 seconds on simulator
    //NSString *filePath = [[NSBundle mainBundle] pathForResource:@"photo" ofType:@"JPG"];//too large and slow.  takes several minutes to do anything on my iPhone 3gs, takes about 7 seconds on sim
    NSURL *fileNameAndPath = [NSURL fileURLWithPath:filePath];
    
    [self setBeginImage:[CIImage imageWithContentsOfURL:fileNameAndPath]];
    
    
    //context determines if it is using cpu or gpu.  nil for default settings
    [self setContext:[CIContext contextWithOptions:nil]];
    return (_beginImage && _context)?YES:NO;
}
- (void)loadDefaultFilter{
    //[self SpecifyFilterToBe:@"CISepiaTone"];
    [self SpecifyFilterToBe:@"CIColorMonochrome"];
}

#pragma mark - SpecifyFilter
- (void)SpecifyFilterToBe:(NSString *)FilterName{
    /**decide filter*/
    [self setFilter:[CIFilter filterWithName:FilterName]];
    [[self filter] setValue:[self beginImage] forKey:kCIInputImageKey];
    /**change add label and connect slider to a method*/
#warning todo: need to debug my generalization.  It works for speia tone, but it is messing up on the cicolormonochrome.  i think I am tok exhausted to really figure it out at this time
    int i = 0;
    NSDictionary *FilterAttributes = [[CIFilter filterWithName:FilterName] attributes];
    for (NSString *validKey in FilterAttributes.allKeys) {
        id dictResult = SupportedLevers[validKey];
        if (dictResult == nil) { continue;}
        i = ((_modifier_0)?1:0) + ((_modifier_1)?1:0) + ((_modifier_2)?1:0)
        + ((_modifier_3)?1:0) + ((_modifier_4)?1:0);
        if( i > 4 ){ break;}
        
//        [self AdjustSliderInfoAt:i
//                        WithDict:[[CIFilter filterWithName:FilterName] attributes]
//                           ofKey:validKey];
        [self connectSliderToModifierAt:i
                   withDictionaryResult:dictResult
                 WhenMatchingFilterName:FilterName];
        
        
    }
}
- (BOOL)connectSliderToModifierAt:(NSInteger)index
             withDictionaryResult:(id)dictResult
           WhenMatchingFilterName:(NSString *)FilterName{
    if (index < 0 || index > 4) {
        @throw [NSException exceptionWithName:@"Out Of Range Exception"
                                       reason:@"index must be 0,1,2,3, or 4" userInfo:nil];
        return false;
    }
    //huh? what does this line do?
    //if(![[[CIFilter filterWithName:FilterName] attributes] objectForKey:[dictResult key]]) {return false;}
    
    if ([dictResult isKindOfClass:[DHPairOfKeyAndValue class]]) {
        [self AdjustSliderInfoAt:index
                        WithDict:[[CIFilter filterWithName:FilterName] attributes]
                           ofKey:[dictResult key]];
        [self SetLabelAt:index toName:[dictResult label]];
        switch (index) {
            case 0: _modifier_0 = dictResult;
                break;
            case 1: _modifier_1 = dictResult;
                break;
            case 2: _modifier_2 = dictResult;
                break;
            case 3: _modifier_3 = dictResult;
                break;
            case 4: _modifier_4 = dictResult;
                break;
            default:
                @throw [NSException exceptionWithName:@"Out Of Range Exception"
                                               reason:@"index must be 0,1,2,3, or 4" userInfo:nil];
                break;
        }
    }else if([dictResult isKindOfClass:[NSArray class]]){
        for (int offset = 0; offset < [dictResult count]; ++offset) {
            [self connectSliderToModifierAt:index + offset
                       withDictionaryResult:dictResult[offset]
                     WhenMatchingFilterName:FilterName];
        }
    }else{
        @throw [NSException
                exceptionWithName:@"Unsupported Lever Class Exception"
                reason:@"This is called when a key in the dictionary is valid, but the class of the value has not been given a conditionaly branch to deal with that class properly"
                userInfo:nil];
    }
    return true;
}
#pragma mark - modify sliders and labels
- (BOOL)SetLabelAt:(NSInteger) index toName:(NSString *)name{
    if(index < 0 || index > 4) return false;
    NSArray *sliderNameArray = @[_NameSlider_0,
                                 _NameSlider_1,
                                 _NameSlider_2,
                                 _NameSlider_3,
                                 _NameSlider_4];
    UILabel *sliderName = sliderNameArray[index];
    [sliderName setText:name];
    return true;
}
- (BOOL)AdjustSliderInfoAt:(NSInteger)index
                  WithDict:(NSDictionary *)filter_Attributes
                     ofKey:(NSString *) key
{
    if(index < 0 || index > 4) {
        @throw [NSException exceptionWithName:@"Out Of Range Exception"
                                       reason:@"index must be 0,1,2,3, or 4" userInfo:nil];
        return false;
    }
    //index must be 0,1,2,3,4
    NSArray *sliderArray = @[_GetSliderValue_0,
                             _GetSliderValue_1,
                             _GetSliderValue_2,
                             _GetSliderValue_3,
                             _GetSliderValue_4];
    //check if key exists.  ie inputIntensity
    NSDictionary *attrib_dict = filter_Attributes[key];
    //if it exists than modify the label and the slider
    //if it doesn't exist then return false'
    if( attrib_dict ){
        if([attrib_dict[@"CIAttributeClass"] isEqualToString:@"NSNumber"]){
        UISlider *sliderRef = sliderArray[index];
        [sliderRef setMaximumValue:[attrib_dict[@"CIAttributeSliderMax"] floatValue]];
        [sliderRef setMinimumValue:[attrib_dict[@"CIAttributeSliderMin"] floatValue]];
        [sliderRef setValue:[attrib_dict[@"CIAttributeDefault"] floatValue]];
        }else if([attrib_dict[@"CIAttributeClass"] isEqualToString:@"CIColor"]){
            UISlider *sliderRef = sliderArray[index];
            [sliderRef setMaximumValue:1.0];
            [sliderRef setMinimumValue:0.0];
            [sliderRef setValue:0.8];
        }else{
            @throw [NSException exceptionWithName:@"Unknown CIAttributeClass"
                                           reason:@"The type of attribute class will tell the program what kinds of data to find in the dictionary.  It will use this info to determine the best way to handle the sliders. ie. NSNumber woudl have a slider min and max, but an CIColor would not have that, you'd have to put in a default"
                                         userInfo:nil];
        }
        return true;
    }
    return false;
}
- (void)loadDefaultLabels{
    [self SetLabelAt:0 toName:@""];
    [self SetLabelAt:1 toName:@""];
    [self SetLabelAt:2 toName:@""];
    [self SetLabelAt:3 toName:@""];
    [self SetLabelAt:4 toName:@""];
}
- (void)loadDefaultSliders{
    [[self GetSliderValue_0] setMaximumValue:0];
    [[self GetSliderValue_0] setMinimumValue:0];
    [[self GetSliderValue_0] setValue:0];
    
    [[self GetSliderValue_1] setMaximumValue:0];
    [[self GetSliderValue_1] setMinimumValue:0];
    [[self GetSliderValue_1] setValue:0];
    
    [[self GetSliderValue_2] setMaximumValue:0];
    [[self GetSliderValue_2] setMinimumValue:0];
    [[self GetSliderValue_2] setValue:0];
    
    [[self GetSliderValue_3] setMaximumValue:0];
    [[self GetSliderValue_3] setMinimumValue:0];
    [[self GetSliderValue_3] setValue:0];
    
    [[self GetSliderValue_4] setMaximumValue:0];
    [[self GetSliderValue_4] setMinimumValue:0];
    [[self GetSliderValue_4] setValue:0];
}
#pragma mark - Handling the Wheel of Filters
-(BOOL)canBecomeFirstResponder{
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
}
-(void)viewWillDisappear:(BOOL)animated{
    [self resignFirstResponder];
    [super viewWillDisappear:animated];
}
-(void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    NSLog(@"motion began");
    [_WheelOfFilters setHidden:([_WheelOfFilters isHidden])?NO:YES];
}
-(void) motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //NSLog(@"motion cancled");
}
-(void) motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //NSLog(@"motion ended");
}
-(NSArray *)FillWheelWithThese{
    //temporary start with three
    return @[@"CISepiaTone",
             @"CIColorMonochrome",
             @"CIColorControls"];
#warning todo: need to fill it with the filters that do work by default.
}
@end

















