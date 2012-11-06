//
//  ImageEditro.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import "ImageEditor.h"

@implementation ImageEditor

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGSize newSize = CGSizeMake(90, 120);
    
    UIGraphicsBeginImageContext(newSize);
    [self.content.image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.contentImage.image = newImage;
    
    [[self.contentImage layer] setCornerRadius:8.0f];
    [[self.contentImage layer] setMasksToBounds:YES];
    self.controlLabel.text = self.content.control.title;
}

@end