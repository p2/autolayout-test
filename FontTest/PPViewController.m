//
//  PPViewController.m
//  FontTest
//
//  Created by Pascal Pfiffner on 7/6/13.
//  Copyright (c) 2013 Ossus. All rights reserved.
//

#import "PPViewController.h"
#import "PPRelView.h"


@interface PPViewController ()

@property (weak, nonatomic) PPRelView *row1;
@property (weak, nonatomic) PPRelView *row2;

@end


@implementation PPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	// add rows
	self.row1 = [self addRowWithText:@"This is some text I want to place" buttonText:@"Insert" to:self.view after:_header];
	[_row1.button addTarget:self action:@selector(insert:) forControlEvents:UIControlEventTouchUpInside];
	
	self.row2 = [self addRowWithText:@"And this is more text, to be placed at the very bottom of this growing list" buttonText:@"Last" to:self.view after:_row1];
}

- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"row1: %@", NSStringFromCGRect(_row1.frame));
	NSLog(@"row2: %@", NSStringFromCGRect(_row2.frame));
}



#pragma mark - Actions
- (IBAction)pop:(id)sender
{
	PPRelView *row = [self addRowWithText:@"A row that I just added" buttonText:@"Remove" to:self.view after:_row2.previous];
	[row.button addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
	
	[UIView animateWithDuration:0.4
						  delay:0.0
		 usingSpringWithDamping:_slider1.value
		  initialSpringVelocity:_slider2.value
						options:0
					 animations:^{
						 [self.view layoutIfNeeded];
					 }
					 completion:NULL];
}

- (void)insert:(id)sender
{
	PPRelView *row = [self addRowWithText:@"A row that I just added" buttonText:@"Remove" to:self.view after:_row2.previous];
	[row.button addTarget:self action:@selector(remove:) forControlEvents:UIControlEventTouchUpInside];
	
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}

- (void)remove:(UIButton *)sender
{
	[sender.superview removeFromSuperview];
	
	[UIView animateWithDuration:0.4
						  delay:0.0
		 usingSpringWithDamping:_slider1.value
		  initialSpringVelocity:_slider2.value
						options:0
					 animations:^{
						 [self.view layoutIfNeeded];
					 }
					 completion:NULL];
}



#pragma mark - Get a Row
- (PPRelView *)addRowWithText:(NSString *)text buttonText:(NSString *)btnText to:(UIView *)parent after:(PPRelView *)after
{
	PPRelView *row = [[PPRelView alloc] initWithFrame:after.frame];
	row.label.text = text;
	[row.button setTitle:btnText forState:UIControlStateNormal];
	
	[parent addSubview:row];
	[row alignBelowView:after];
	
	return row;
}


@end
