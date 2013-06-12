//
//  PhotoWheelViewController.h
//  AllFilters
//
//  Created by dho_everest on 6/12/13.
//  Copyright (c) 2013 dho_everest. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface PhotoWheelViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationBarDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *WheelOfFilters;
@property (strong, nonatomic) NSArray *AllFilterNames;
@property (strong, nonatomic) CIContext *context;
@property (strong, nonatomic) CIFilter *filter;
@property (strong, nonatomic) CIImage *beginImage;
@property (weak, nonatomic) IBOutlet UIImageView *FacePic;



- (IBAction)ChooseNewPhoto_b:(id)sender;

- (IBAction)Choose2SavePhoto:(id)sender;

- (IBAction)back:(id)sender;



@property BOOL willPresetSliders;

@end
