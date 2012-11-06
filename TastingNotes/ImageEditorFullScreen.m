//
//  ImageEditorFullScreen.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import "ImageEditorFullScreen.h"
#import "NoteView.h"

@implementation ImageEditorFullScreen

-(void)viewDidLoad{
    [super viewDidLoad];
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        self.cameraButton.enabled = NO;
    self.imagePicker = [[UIImagePickerController alloc]init];
    self.imagePicker.delegate = self;
    [[self.contentImage layer] setCornerRadius:8.0f];
    [[self.contentImage layer] setMasksToBounds:YES];
    [self presentImage];
}

-(void)presentImage{
    self.contentImage.image = self.content.image;
    self.contentImage.hidden = NO;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo{
    
    self.contentImage.hidden = YES;
    [self.content.note setPlacardInfoToNil];
    [self.activityIndicator startAnimating];
    
    [self dismissViewControllerAnimated:YES completion:^{
        self.content.image = image;
        self.contentImage.image = self.content.image;
        self.contentImage.hidden = NO;
        [self.activityIndicator stopAnimating];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cameraButtonAction:(id)sender {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    self.imagePicker.showsCameraControls = YES;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (IBAction)libraryButtonAction:(id)sender {
    self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:self.imagePicker animated:YES completion:nil];
}

- (IBAction)trashButtonAction:(id)sender {
    self.content.image = nil;
    [self presentImage];
}

- (IBAction)doneButtonAction:(id)sender {
    _updateBlock();
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end