//
//  TheJulianFilter_mark1.m
//  AllFilters
//
//  Created by dho_everest on 6/17/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import "TheJulianFilter_mark1.h"
////////
#define mykInputIntensity @"inputIntensity"
#define mykInputColor @"inputColor"
#define mykInputSaturation @"inputSaturation"
#define mykInputBrightness @"inputBrightness"
#define mykInputContrast @"inputContrast"
#define mykInputCenter @"inputCenter"
#define mykInputSharpness @"inputSharpness"
#define mykInputWidth @"inputWidth"
#define mykInputRadius @"inputRadius"
#define mykInputAngle @"inputAngle"
#define mykInputAmount @"inputAmount"
#define mykInputPower @"inputPower"
#define mykInputEV @"inputEV"
#define mykInputAspectRatio @"inputAspectRatio"
#define mykInputScale @"inputScale"
#define mykInputLevels @"inputLevels"
#define mykInputHighlightAmount @"inputHighlightAmount"
#define mykInputShadowAmount @"inputShadowAmount"
#define mykInputRotation @"inputRotation"
////////
@implementation TheJulianFilter_mark1
@synthesize inputImage;
@synthesize inputContrast;
@synthesize inputBrightness;
@synthesize inputSaturation;
@synthesize inputSharpness;
@synthesize inputColor;
@synthesize inputAmount;
@synthesize inputPower;
@synthesize inputAngle;

- (void) setDefaults{
    NSMutableDictionary * newdic = nil;
    //
    newdic = [[self attributes] objectForKey:mykInputContrast];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(1.0),
     @"CIAttributeMax": @(4.0),
     @"CIAttributeMin": @(0.0)}];
    [[[self attributes] objectForKey:mykInputContrast] setDictionary:newdic];
    //
    newdic = [[self attributes] objectForKey:mykInputBrightness];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(0.0),
     @"CIAttributeMax": @(1.0),
     @"CIAttributeMin": @(-1.0)}];
    [[[self attributes] objectForKey:mykInputBrightness] setDictionary:newdic];
    //
    newdic = [[self attributes] objectForKey:mykInputSaturation];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(1.0),
     @"CIAttributeMax": @(2.0),
     @"CIAttributeMin": @(0.0)}];
    [[[self attributes] objectForKey:mykInputSaturation] setDictionary:newdic];
    //
    newdic = self.attributes[mykInputSharpness];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(0.4),
     @"CIAttributeMax": @(2.0),
     @"CIAttributeMin": @(0.0)}];
    [self.attributes[mykInputSharpness] setDictionary:newdic];
//
    newdic = self.attributes[mykInputColor];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": [CIColor colorWithString:@"1.0 1.0 1.0 1.0"]}];
    [self.attributes[mykInputColor] setDictionary:newdic];
//
    newdic = self.attributes[mykInputAmount];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(0.0),
     @"CIAttributeMax": @(1.0),
     @"CIAttributeMin": @(-1.0)}];
    [self.attributes[mykInputAmount] setDictionary:newdic];
//
    newdic = self.attributes[mykInputPower];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(1.0),
     @"CIAttributeMax": @(4.0),
     @"CIAttributeMin": @(0.25)}];
    [self.attributes[mykInputPower] setDictionary:newdic];
//
    newdic = self.attributes[mykInputAngle];
    [newdic addEntriesFromDictionary:
     @{@"CIAttributeDefault": @(0.0),
     @"CIAttributeMax": @(M_PI),
     @"CIAttributeMin": @(-M_PI)}];
    [self.attributes[mykInputAngle] setDictionary:newdic];
    
//    [CIFilter filterWithName:@"CIColorControls"];
//    [CIFilter filterWithName:@"CISharpenLuminence"];
//    [CIFilter filterWithName:@"CIWhitePointAdjust"];
//    [CIFilter filterWithName:@"CIVibrance"];
//    [CIFilter filterWithName:@"CIGammaAdjust"];
//    [CIFilter filterWithName:@"CIHueAdjust"];
}
- (CIImage *) outputImage{
    CIFilter *color_ctrl = [CIFilter filterWithName:@"CIColorControls"];
    [color_ctrl setValuesForKeysWithDictionary:
     @{
                              kCIInputImageKey: inputImage,
                             mykInputContrast: inputContrast,
                            mykInputBrightness: inputBrightness,
                            mykInputSaturation: inputSaturation
     }];
    
    CIFilter *sharpen = [CIFilter filterWithName:@"CISharpenLuminance"];
    [sharpen setValuesForKeysWithDictionary:
     @{
                           kCIInputImageKey: color_ctrl.outputImage,
                          mykInputSharpness: inputSharpness
     }];
    CIFilter *whitePoint = [CIFilter filterWithName:@"CIWhitePointAdjust"];
    [whitePoint setValuesForKeysWithDictionary:
     @{
                              kCIInputImageKey: sharpen.outputImage,
                                 mykInputColor:inputColor
     }];
    CIFilter *vibrance = [CIFilter filterWithName:@"CIVibrance"];
    [vibrance setValuesForKeysWithDictionary:
     @{
                            kCIInputImageKey: whitePoint.outputImage,
                              mykInputAmount:inputAmount
     }];
    CIFilter *gamma = [CIFilter filterWithName:@"CIGammaAdjust"];
    [gamma setValuesForKeysWithDictionary:
     @{
                         kCIInputImageKey: vibrance.outputImage,
                            mykInputPower:inputPower
     }];
    CIFilter *hue = [CIFilter filterWithName:@"CIHueAdjust"];
    [hue setValuesForKeysWithDictionary:
     @{
                       kCIInputImageKey: gamma.outputImage,
                          mykInputAngle:inputAngle
     }];
    CIFilter *julian_filter = hue;
    
    return julian_filter.outputImage;
}

@end
