//
//  TheJulianFilter_mark1.h
//  AllFilters
//
//  Created by dho_everest on 6/17/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//
/*
 CIColorControls
     Contrast
     Brightness
     Saturation
 CISharpenLuminance
     Sharpness
 CIWhitePointAdjust
     r/g/b
 CIVibrance
     Amount
 CIGammaAdjust
     Power
 CIHueAdjust
     Angle
 
 */
/*What is this?
 
 This is a subclassed filter.  It can be used just like other other filters.
 The filter below is a combo of inputs from all the filters it is deriving from.
 You need these if you want to modifiy the attributes.
 
 setDefaults and outputImage are required methods.
 */

#import <CoreImage/CoreImage.h>

@interface TheJulianFilter_mark1 : CIFilter{
    CIImage *inputImage;
    NSNumber *inputContrast;
    NSNumber *inputBrightness;
    NSNumber *inputSaturation;
    NSNumber *inputSharpness;
    CIColor *inputColor;
    NSNumber *inputAmount;
    NSNumber *inputPower;
    NSNumber *inputAngle;
}
@property (retain, nonatomic) CIImage *inputImage;
@property (retain, nonatomic) NSNumber *inputContrast;
@property (retain, nonatomic) NSNumber *inputBrightness;
@property (retain, nonatomic) NSNumber *inputSaturation;
@property (retain, nonatomic) NSNumber *inputSharpness;
@property (retain, nonatomic) CIColor *inputColor;
@property (retain, nonatomic) NSNumber *inputAmount;
@property (retain, nonatomic) NSNumber *inputPower;
@property (retain, nonatomic) NSNumber *inputAngle;
@end
