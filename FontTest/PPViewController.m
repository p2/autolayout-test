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
	NSLog(@"Starting");
	
	// add rows
	self.row1 = [self addRowWithText:@"This is some text I want to place" buttonText:@"Insert" to:self.view before:nil orAfter:nil];
	[((UIButton *)[_row1 viewWithTag:2]) addTarget:self action:@selector(insert:) forControlEvents:UIControlEventTouchUpInside];
	
	self.row2 = [self addRowWithText:@"And this is more text, to be placed at the very bottom of this growing list" buttonText:@"Last" to:self.view before:nil orAfter:_row1];
	
	NSLog(@"%@", _row2.constraints);
}

- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"row1: %@", NSStringFromCGRect(_row1.frame));
	NSLog(@"row2: %@", NSStringFromCGRect(_row2.frame));
}

- (void)insert:(id)sender
{
	NSLog(@"Adding a row");
	[self addRowWithText:@"A row that I just added" buttonText:@"Row" to:self.view before:_row2 orAfter:nil];
	NSLog(@"Added");
	
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
}


- (PPRelView *)addRowWithText:(NSString *)text buttonText:(NSString *)btnText to:(UIView *)parent before:(PPRelView *)before orAfter:(PPRelView *)after
{
	UIView *rel = before ? before : after;
	UILabel *lbl = [[UILabel alloc] initWithFrame:[rel viewWithTag:1].frame];
	lbl.tag = 1;
	lbl.translatesAutoresizingMaskIntoConstraints = NO;
	lbl.numberOfLines = 0;
	lbl.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	lbl.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25f];
	lbl.text = text;
	
	UIButton *btn = [[UIButton alloc] initWithFrame:[rel viewWithTag:2].frame];
	btn.tag = 2;
	btn.translatesAutoresizingMaskIntoConstraints = NO;
	btn.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25f];
	[btn setTitle:btnText forState:UIControlStateNormal];
	
	PPRelView *row = [[PPRelView alloc] initWithFrame:rel.frame];
	row.previous = before ? before.previous : after;
	row.translatesAutoresizingMaskIntoConstraints = NO;
	row.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25f];
	[row addSubview:lbl];
	[row addSubview:btn];
	[parent addSubview:row];
	
	// row width
	NSArray *cRow = [NSLayoutConstraint constraintsWithVisualFormat:@"|[row]|" options:0 metrics:nil views:@{@"row": row}];
	
	// row top margin and height
	NSArray *cTop = nil;
	if (row.previous) {
		cTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[row1]-[row(>=lbl,>=btn)]" options:0 metrics:nil views:@{@"row1": row.previous, @"row": row, @"lbl": lbl, @"btn": btn}];
	}
	else {
		cTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[row(>=lbl,>=btn)]" options:0 metrics:nil views:@{@"row": row, @"lbl": lbl, @"btn": btn}];
	}
	
	// label and button alignment
	NSArray *cRowInner = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[lbl]-[btn(100)]-|"
																 options:NSLayoutFormatAlignAllCenterY
																 metrics:nil
																   views:@{@"lbl": lbl, @"btn": btn}];
	NSLayoutConstraint *cRowCenter = [NSLayoutConstraint constraintWithItem:lbl
																  attribute:NSLayoutAttributeCenterY
																  relatedBy:NSLayoutRelationEqual
																	 toItem:lbl.superview
																  attribute:NSLayoutAttributeCenterY
																 multiplier:1.f constant:0.f];
	[parent addConstraints:cTop];
	[parent addConstraints:cRow];
	[row addConstraints:cRowInner];
	[row addConstraint:cRowCenter];
	
	// move down the lower row
	if (before) {
		before.previous = row;
		NSArray *old = [before constraintsAffectingLayoutForAxis:UILayoutConstraintAxisVertical];
		for (NSLayoutConstraint *constr in old) {
			if (before == constr.firstItem && NSLayoutAttributeTop == constr.firstAttribute) {
				[parent removeConstraint:constr];
				break;
			}
		}
		
		[parent addConstraint:[NSLayoutConstraint constraintWithItem:before attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:row attribute:NSLayoutAttributeBottom multiplier:1.f constant:8.f]];
		[parent setNeedsUpdateConstraints];
	}
	
	return row;
}


@end
