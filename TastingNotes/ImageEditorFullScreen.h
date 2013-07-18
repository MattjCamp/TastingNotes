//
//  ImageEditorFullScreen.h
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import <Foundation/Foundation.h>
#import "ContentFullScreen.h"

@interface ImageEditorFullScreen : ContentFullScreen<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *contentImage;
@property (strong, nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cameraButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)cameraButtonAction:(id)sender;
- (IBAction)libraryButtonAction:(id)sender;
- (IBAction)trashButtonAction:(id)sender;
- (IBAction)doneButtonAction:(id)sender;

@end