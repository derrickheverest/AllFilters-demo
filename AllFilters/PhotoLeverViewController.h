//
//  PhotoLeverViewController.h
//  AllFilters
//
//  Created by dho_everest on 6/10/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h> //for saving pics to library

@class DHPairOfKeyAndValue;
@interface PhotoLeverViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
//@property (nonatomic, assign) id delegate;
@property (strong, nonatomic) CIContext *context;
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIImage *beginImage;
@property (weak, nonatomic) IBOutlet UIImageView *FacePic;

@property (strong, nonatomic) DHPairOfKeyAndValue *modifier_0;
@property (strong, nonatomic) DHPairOfKeyAndValue *modifier_1;
@property (strong, nonatomic) DHPairOfKeyAndValue *modifier_2;
@property (strong, nonatomic) DHPairOfKeyAndValue *modifier_3;
@property (strong, nonatomic) DHPairOfKeyAndValue *modifier_4;
@property (strong, nonatomic) CIColor *lastColor;

- (IBAction)ChooseNewPhoto_b:(id)sender;

- (IBAction)Choose2SavePhoto:(id)sender;

- (IBAction)back:(id)sender;

- (IBAction)ChangeSliderValue_0:(id)sender;

- (IBAction)ChangeSliderValue_1:(id)sender;

- (IBAction)ChangeSliderValue_2:(id)sender;

- (IBAction)ChangeSliderValue_3:(id)sender;

- (IBAction)ChangeSliderValue_4:(id)sender;

@property BOOL willPresetSliders;
@property float MaxSliderVal0, MinSliderVal0, NewSliderVal0,
MaxSliderVal1, MinSliderVal1, NewSliderVal1,
MaxSliderVal2, MinSliderVal2, NewSliderVal2,
MaxSliderVal3, MinSliderVal3, NewSliderVal3,
MaxSliderVal4, MinSliderVal4, NewSliderVal4;

@property (weak, nonatomic) IBOutlet UISlider *GetSliderValue_0;
@property (weak, nonatomic) IBOutlet UISlider *GetSliderValue_1;
@property (weak, nonatomic) IBOutlet UISlider *GetSliderValue_2;
@property (weak, nonatomic) IBOutlet UISlider *GetSliderValue_3;
@property (weak, nonatomic) IBOutlet UISlider *GetSliderValue_4;

@property (weak, nonatomic) IBOutlet UILabel *NameSlider_0;
@property (weak, nonatomic) IBOutlet UILabel *NameSlider_1;
@property (weak, nonatomic) IBOutlet UILabel *NameSlider_2;
@property (weak, nonatomic) IBOutlet UILabel *NameSlider_3;
@property (weak, nonatomic) IBOutlet UILabel *NameSlider_4;


@end
