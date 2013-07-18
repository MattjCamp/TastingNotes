//
//  RatingsEditor.m
//  TastingNotes
//
//  Created by Matthew Campbell on 9/20/12.
//
//

#import "RatingsEditor.h"

@implementation RatingsEditor
@synthesize titleLabel, button1, button2, button3, button4, button5, emptyStarImage, starImage, isEditingNote;

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    [self populate];
}

-(void) populate{
    self.isEditingNote = YES;
	button1.tag = 0;
	button2.tag = 0;
	button3.tag = 0;
	button4.tag = 0;
	button5.tag = 0;
	self.starImage = [UIImage imageNamed:@"001_15.png"];
	self.emptyStarImage = [UIImage imageNamed:@"001_17.png"];
	self.titleLabel.text = self.content.control.title;
	if(self.content){
		int rating = [self.content.numeric intValue];
		switch (rating) {
			case 1:{
				[button1 setImage:self.starImage forState:UIControlStateNormal];
				[button2 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button3 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
				button1.tag = 1;
				button2.tag = 0;
				button3.tag = 0;
				button4.tag = 0;
				button5.tag = 0;
			}
				break;
			case 2:{
				[button1 setImage:self.starImage forState:UIControlStateNormal];
				[button2 setImage:self.starImage forState:UIControlStateNormal];
				[button3 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
				button1.tag = 1;
				button2.tag = 1;
				button3.tag = 0;
				button4.tag = 0;
				button5.tag = 0;
			}
				break;
			case 3:{
				[button1 setImage:self.starImage forState:UIControlStateNormal];
				[button2 setImage:self.starImage forState:UIControlStateNormal];
				[button3 setImage:self.starImage forState:UIControlStateNormal];
				[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
				button1.tag = 1;
				button2.tag = 1;
				button3.tag = 1;
				button4.tag = 0;
				button5.tag = 0;
			}
				break;
			case 4:{
				[button1 setImage:self.starImage forState:UIControlStateNormal];
				[button2 setImage:self.starImage forState:UIControlStateNormal];
				[button3 setImage:self.starImage forState:UIControlStateNormal];
				[button4 setImage:self.starImage forState:UIControlStateNormal];
				[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
				button1.tag = 1;
				button2.tag = 1;
				button3.tag = 1;
				button4.tag = 1;
				button5.tag = 0;
			}
				break;
			case 5:{
                [button1 setImage:self.starImage forState:UIControlStateNormal];
                [button2 setImage:self.starImage forState:UIControlStateNormal];
                [button3 setImage:self.starImage forState:UIControlStateNormal];
                [button4 setImage:self.starImage forState:UIControlStateNormal];
                [button5 setImage:self.starImage forState:UIControlStateNormal];
                button1.tag = 1;
                button2.tag = 1;
                button3.tag = 1;
                button4.tag = 1;
                button5.tag = 1;
			}
				break;
			default:{
				[button1 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button2 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button3 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
				[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
				button1.tag = 0;
				button2.tag = 0;
				button3.tag = 0;
				button4.tag = 0;
				button5.tag = 0;
			}
				break;
		}
	}
}

-(IBAction) rateOne{
	if(self.isEditingNote){
		if(button1.tag == 0){
			button1.tag = 1;
			self.content.numeric = [NSNumber numberWithInt:1];
			[button1 setImage:self.starImage forState:UIControlStateNormal];
		}
		else{
			button1.tag = 0;
			[button1 setImage:self.emptyStarImage forState:UIControlStateNormal];
			self.content.numeric = [NSNumber numberWithInt:0];
		}
		[button2 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button2.tag = 0;
		[button3 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button3.tag = 0;
		[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button4.tag = 0;
		[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button5.tag = 0;
	}
}

-(IBAction) rateTwo{
	if(self.isEditingNote){
		if(button2.tag == 0){
			button2.tag = 1;
			self.content.numeric = [NSNumber numberWithInt:2];
			[button2 setImage:self.starImage forState:UIControlStateNormal];
		}
		else{
			button2.tag = 0;
			[button2 setImage:self.emptyStarImage forState:UIControlStateNormal];
			self.content.numeric = [NSNumber numberWithInt:1];
		}
		[button1 setImage:self.starImage forState:UIControlStateNormal];
		button1.tag = 1;
		[button3 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button3.tag = 0;
		[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button4.tag = 0;
		[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button5.tag = 0;
	}
}

-(IBAction) rateThree{
	if(self.isEditingNote){
		if(button3.tag == 0){
			button3.tag = 1;
			self.content.numeric = [NSNumber numberWithInt:3];
			[button3 setImage:self.starImage forState:UIControlStateNormal];
		}
		else{
			button3.tag = 0;
			[button3 setImage:self.emptyStarImage forState:UIControlStateNormal];
			self.content.numeric = [NSNumber numberWithInt:2];
		}
		[button1 setImage:self.starImage forState:UIControlStateNormal];
		button1.tag = 1;
		[button2 setImage:self.starImage forState:UIControlStateNormal];
		button2.tag = 1;
		[button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button4.tag = 0;
		[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
		button5.tag = 0;
	}
}

-(IBAction) rateFour{    
    if(self.isEditingNote){
        if(button4.tag == 0){
            button4.tag = 1;
            self.content.numeric = [NSNumber numberWithInt:4];
            [button4 setImage:self.starImage forState:UIControlStateNormal];
        }
        else{
            button4.tag = 0;
            [button4 setImage:self.emptyStarImage forState:UIControlStateNormal];
            self.content.numeric = [NSNumber numberWithInt:3];
        }
        [button1 setImage:self.starImage forState:UIControlStateNormal];
        button1.tag = 1;
        [button2 setImage:self.starImage forState:UIControlStateNormal];
        button2.tag = 1;
        [button3 setImage:self.starImage forState:UIControlStateNormal];
        button3.tag = 1;
        [button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
        button5.tag = 0;
    }
}

-(IBAction) rateFive{
	if(self.isEditingNote){
		if(button5.tag == 0){
			button5.tag = 1;
			self.content.numeric = [NSNumber numberWithInt:5];
			[button5 setImage:self.starImage forState:UIControlStateNormal];
		}
		else{
			button5.tag = 0;
			[button5 setImage:self.emptyStarImage forState:UIControlStateNormal];
			self.content.numeric = [NSNumber numberWithInt:4];
		}
		[button1 setImage:self.starImage forState:UIControlStateNormal];
		button1.tag = 1;
		[button2 setImage:self.starImage forState:UIControlStateNormal];
		button2.tag = 1;
		[button3 setImage:self.starImage forState:UIControlStateNormal];
		button3.tag = 1;
		[button4 setImage:self.starImage forState:UIControlStateNormal];
		button4.tag = 1;
	}
}

@end
