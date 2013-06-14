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
#define mySELInputCubeDimension @selector(modInputCubeDimensionByThisValue:)
#define mySELInputCenterX @selector(modInputCenterXByThisValue:)
#define mySELInputCenterY @selector(modInputCenterYByThisValue:)
#define mySELInputSharpness @selector(modInputSharpnessByThisValue:)
#define mySELInputWidth @selector(modInputWidthByThisValue:)

#define mykInputIntensity @"inputIntensity"
#define mykInputColor @"inputColor"
#define mykInputSaturation @"inputSaturation"
#define mykInputBrightness @"inputBrightness"
#define mykInputContrast @"inputContrast"
#define mykInputCubeDimension @"inputCubeDimension"
#define mykInputCenter @"inputCenter"
#define mykInputSharpness @"inputSharpness"
#define mykInputWidth @"inputWidth"

NSDictionary *SupportedLevers = nil;

@interface PhotoLeverViewController ()
//@property (strong, nonatomic) NSString *barnacle;
- (BOOL)loadDefaultPhoto;
- (void)loadDefaultFilter;
- (void)loadDefaultLabels;
- (void)loadDefaultSliders;
- (void)loadSupportedLevers;
- (void)loadDefaultModifiers;
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
    [_WheelOfFilters setHidden:YES];
    _ListOfFilters = [self FillWheelWithThese];
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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:[_modifier_0 sel] withObject:@(sender.value)];
#pragma clang diagnostic pop
    //[self modInputIntensityByThisValue:@(sender.value)];
    [self reapplyFiltersToCurrentImage];
}
- (IBAction)ChangeSliderValue_1:(UISlider *)sender{
    if (_modifier_1 == nil) return;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:[_modifier_1 sel] withObject:@(sender.value)];
#pragma clang diagnostic pop
    [self reapplyFiltersToCurrentImage];
}

- (IBAction)ChangeSliderValue_2:(UISlider *)sender{
    if (_modifier_2 == nil) return;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:[_modifier_2 sel] withObject:@(sender.value)];
#pragma clang diagnostic pop
    [self reapplyFiltersToCurrentImage];
}

- (IBAction)ChangeSliderValue_3:(UISlider *)sender{
    if (_modifier_3 == nil) return;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:[_modifier_3 sel] withObject:@(sender.value)];
#pragma clang diagnostic pop
    [self reapplyFiltersToCurrentImage];
}

- (IBAction)ChangeSliderValue_4:(UISlider *)sender{
    if (_modifier_4 == nil) return;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:[_modifier_4 sel] withObject:@(sender.value)];
#pragma clang diagnostic pop
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
                                                 setLabel:@"Contrast"],
      mykInputCubeDimension: [[DHPairOfKeyAndValue new] setKey:mykInputCubeDimension
                                                        setSEL:mySELInputCubeDimension
                                                      setLabel:@"Cube Dimension"],
      mykInputCenter:[NSArray arrayWithObjects:
                      [[DHPairOfKeyAndValue new] setKey:mykInputCenter
                                                 setSEL:mySELInputCenterX
                                               setLabel:@"X-axis"],
                      [[DHPairOfKeyAndValue new] setKey:mykInputCenter
                                                 setSEL:mySELInputCenterY
                                               setLabel:@"y-axis"],
                      nil],
      mykInputSharpness:[[DHPairOfKeyAndValue new] setKey:mykInputSharpness
                                                   setSEL:mySELInputSharpness
                                                 setLabel:@"Sharpness"],
      mykInputWidth:[[DHPairOfKeyAndValue new] setKey:mykInputWidth
                                               setSEL:mySELInputWidth
                                             setLabel:@"Width"]
      };
}
- (void) modInputIntensityByThisValue:(NSNumber *)val{
     [[self filter] setValue:val forKey:mykInputIntensity];
}
- (void) modInputColorRedByThisValue:(NSNumber *)val
{
    CIColor *color = [CIColor colorWithRed:val.floatValue
                                     green:_lastColor.green
                                      blue:_lastColor.blue];
    [[self filter] setValue:color forKey:mykInputColor];
    _lastColor = color;
}
- (void) modInputColorGreenByThisValue:(NSNumber *)val
{
    CIColor *color = [CIColor colorWithRed:_lastColor.red
                                     green:val.floatValue
                                      blue:_lastColor.blue];
    [[self filter] setValue:color forKey:mykInputColor];
    _lastColor = color;
}
- (void) modInputColorBlueByThisValue:(NSNumber *)val
{
    CIColor *color = [CIColor colorWithRed:_lastColor.red
                                     green:_lastColor.green
                                      blue:val.floatValue];
    [[self filter] setValue:color forKey:mykInputColor];
    _lastColor = color;
}
- (void) modInputSaturationByThisValue:(NSNumber *)val
{
    [[self filter] setValue:val forKey:mykInputSaturation];
}
- (void) modInputBrightnessByThisValue:(NSNumber *)val
{
    [[self filter] setValue:val forKey:mykInputBrightness];
}
- (void) modInputContrastByThisValue:(NSNumber *)val
{
    [[self filter] setValue:val forKey:mykInputContrast];
}
- (void) modInputCubeDimensionByThisValue:(NSNumber *)val
{
#warning Currently causes an exception. Will have to research this a bit more
    //[[self filter] setValue:val forKey:@"inputCubeDimension"];
}
- (void) modInputCenterXByThisValue:(NSNumber *)val{
    CIVector *vector = [CIVector vectorWithX:val.floatValue Y:_lastVector.Y];
    [[self filter] setValue:vector forKey:mykInputCenter];
    _lastVector = vector;
}
- (void) modInputCenterYByThisValue:(NSNumber *)val{
    CIVector *vector = [CIVector vectorWithX:_lastVector.X Y:val.floatValue];
    [[self filter] setValue:vector forKey:mykInputCenter];
    _lastVector = vector;
}
-(void) modInputSharpnessByThisValue:(NSNumber *)val{
    [[self filter] setValue:val forKey:mykInputSharpness];
}
-(void) modInputWidthByThisValue:(NSNumber *)val{
    [[self filter] setValue:val forKey:mykInputWidth];
}
#pragma mark - Load Defaults
-(void)loadDefaultModifiers{
    _modifier_0 = _modifier_1 = _modifier_2 =
    _modifier_3 = _modifier_4 = nil;
}
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
  
    int i = 0;
    NSDictionary *FilterAttributes = [[CIFilter filterWithName:FilterName] attributes];
    for (NSString *validKey in FilterAttributes.allKeys) {
        id dictResult = SupportedLevers[validKey];
        if (dictResult == nil) { continue;}
        i = ((_modifier_0)?1:0) + ((_modifier_1)?1:0) + ((_modifier_2)?1:0)
        + ((_modifier_3)?1:0) + ((_modifier_4)?1:0);
        if( i > 4 ){ break;}
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
- (void) changeFilter2:(NSString *)FilterName{
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
    
   //
    [self loadDefaultModifiers];
    [self loadDefaultSliders];
    [self loadDefaultLabels];
    [self SpecifyFilterToBe:FilterName];
    [self ChangeSliderValue_0:[self GetSliderValue_0]];
    [self ChangeSliderValue_1:[self GetSliderValue_1]];
    [self ChangeSliderValue_2:[self GetSliderValue_2]];
    [self ChangeSliderValue_3:[self GetSliderValue_3]];
    [self ChangeSliderValue_4:[self GetSliderValue_4]];
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
#warning todo: need to debug my generalization.  It works for speia tone, monochrome and color control.  it will crash when it finds something that isn't nsnumber or cicolor.  find out what they are, you'd have to go through all of them.
    
    if( attrib_dict ){
        if([attrib_dict[@"CIAttributeClass"] isEqualToString:@"NSNumber"]){
            UISlider *sliderRef = sliderArray[index];
            NSNumber *attributeMaxValue = attrib_dict[@"CIAttributeSliderMax"];
            NSNumber *attributeMinValue = attrib_dict[@"CIAttributeSliderMin"];
            if (!attributeMaxValue) {
                attributeMaxValue = attrib_dict[@"CIAttributeMax"];}
            if (!attributeMinValue) {attributeMinValue = attrib_dict[@"CIAttributeMin"];}
            [sliderRef setMaximumValue:[attributeMaxValue floatValue]];
            [sliderRef setMinimumValue:[attributeMinValue floatValue]];
            [sliderRef setValue:[attrib_dict[@"CIAttributeDefault"] floatValue]];
        }else if([attrib_dict[@"CIAttributeClass"] isEqualToString:@"CIColor"]){
            _lastColor = [CIColor colorWithString:@"0.5 0.5 0.5 1.0"];
            UISlider *sliderRef = sliderArray[index];
            [sliderRef setMaximumValue:1.0];
            [sliderRef setMinimumValue:0.0];
            [sliderRef setValue:0.8];
        }else if([attrib_dict[@"CIAttributeClass"] isEqualToString:@"CIVector"]){
            _lastVector = [CIVector vectorWithX:_FacePic.frame.size.width/2
                                              Y:_FacePic.frame.size.height/2];
            UISlider *sliderRef = sliderArray[index];
            [sliderRef setMaximumValue:_FacePic.frame.size.width];
            [sliderRef setMinimumValue:0];
            [sliderRef setValue:_lastVector.X];
            if( index + 1 <= 4){
                UISlider *sliderRef = sliderArray[index + 1];
                [sliderRef setMaximumValue:_FacePic.frame.size.height];
                [sliderRef setMinimumValue:0];
                [sliderRef setValue:_lastVector.Y];
            }
            
        }else{
            @throw [NSException exceptionWithName:@"Unknown CIAttributeClass"
                                           reason:[NSString stringWithFormat:@"%@ \n\n %@", @"The type of attribute class will tell the program what kinds of data to find in the dictionary.  It will use this info to determine the best way to handle the sliders. ie. NSNumber woudl have a slider min and max, but an CIColor would not have that, you'd have to put in a default" , attrib_dict]
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
#pragma mark - PickerView DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;//sets the number of columns
}
- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component
{
    return _ListOfFilters.count;//sets the number of rows
}
- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _ListOfFilters[row];//returns the corresponding filter name
}
#pragma mark - PickerView delegate
- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    [self changeFilter2:_ListOfFilters[row]];
}
#pragma mark - PickerView Visibility
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
    //return @[@"CIColorMonochrome",
   //          @"CISepiaTone",
   //         @"CIColorControls"];
#warning todo: Go through each filter and test to see that you have properly handled the levers.  there may be more than just "inputIntensity" so look it up!
    /**All 90+ filters should techically work. In the worse case it will
     crash.  In the disappointing case, it wil show white.
     
     below is an array of filters that either show a good picture or a moded picture
     
     W - means white picture
     C - means crash app
     */
    return @[
             @"CIColorMonochrome",//ok
             @"CISepiaTone",//ok
             @"CIColorControls",//ok
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
             @"CICircularScreen",//ok
             @"CIColorBlendMode",
             @"CIColorBurnBlendMode",
             @"CIColorControls",
             @"CIColorCube",
             @"CIColorDodgeBlendMode",
             @"CIColorInvert",//ok
             /*W*///@"CIColorMap",
             @"CIColorMatrix",
             @"CIColorMonochrome",//ok
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

















