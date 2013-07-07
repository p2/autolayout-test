//
//  PPViewController.m
//  FontTest
//
//  Created by Pascal Pfiffner on 7/6/13.
//  Copyright (c) 2013 Ossus. All rights reserved.
//

#import "PPViewController.h"


@interface PPViewController ()

@property (weak, nonatomic) UIView *row1;
@property (weak, nonatomic) UIView *row2;

@end


@implementation PPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	NSLog(@"Starting");
	
	// row 1
	UILabel *lbl1 = [UILabel new];
	lbl1.translatesAutoresizingMaskIntoConstraints = NO;
	lbl1.numberOfLines = 0;
	lbl1.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	lbl1.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25f];
	lbl1.text = @"This is some text I want to place";
	
	UIButton *btn1 = [UIButton new];
	btn1.translatesAutoresizingMaskIntoConstraints = NO;
	btn1.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25f];
	[btn1 setTitle:@"Insert" forState:UIControlStateNormal];
	[btn1 addTarget:self action:@selector(insert:) forControlEvents:UIControlEventTouchUpInside];
	
	UIView *row1 = [UIView new];
	row1.translatesAutoresizingMaskIntoConstraints = NO;
	row1.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25f];
	[row1 addSubview:lbl1];
	[row1 addSubview:btn1];
	[self.view addSubview:row1];
	self.row1 = row1;
									
	NSArray *cTop1 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[row1(>=lbl1,>=btn1)]" options:0 metrics:nil views:@{@"row1": row1, @"lbl1": lbl1, @"btn1": btn1}];
	NSArray *cRow1 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[row1]|" options:0 metrics:nil views:@{@"row1": row1}];
	NSLayoutConstraint *cBtn1 = [NSLayoutConstraint constraintWithItem:btn1 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:44.f];
	NSArray *constr1 = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[lbl1]-[btn1(100)]-|"
															   options:NSLayoutFormatAlignAllTop
															   metrics:nil
																 views:@{@"lbl1": lbl1, @"btn1": btn1}];
	[self.view addConstraints:cTop1];
	[self.view addConstraints:cRow1];
	[btn1 addConstraint:cBtn1];
	[row1 addConstraints:constr1];
	
	// row 2
	UILabel *lbl2 = [UILabel new];
	lbl2.translatesAutoresizingMaskIntoConstraints = NO;
	lbl2.numberOfLines = 0;
	lbl2.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	lbl2.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25f];
	lbl2.text = @"And this is more text, to be placed at the very bottom of this growing list";
	
	UIButton *btn2 = [UIButton new];
	btn2.translatesAutoresizingMaskIntoConstraints = NO;
	btn2.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25f];
	[btn2 setTitle:@"Last" forState:UIControlStateNormal];
	
	UIView *row2 = [UIView new];
	row2.translatesAutoresizingMaskIntoConstraints = NO;
	row2.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25f];
	[row2 addSubview:lbl2];
	[row2 addSubview:btn2];
	[self.view addSubview:row2];
	self.row2 = row2;
	
	NSArray *cTop2 = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[row1]-[row2(>=lbl2,>=btn2)]" options:0 metrics:nil views:@{@"row1": row1, @"row2": row2, @"lbl2": lbl2, @"btn2": btn2}];
	NSArray *cRow2 = [NSLayoutConstraint constraintsWithVisualFormat:@"|[row2]|" options:0 metrics:nil views:@{@"row2": row2}];
	NSLayoutConstraint *cBtn2 = [NSLayoutConstraint constraintWithItem:btn2 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:44.f];
	NSArray *constr2 = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[lbl2]-[btn2(100)]-|"
															   options:NSLayoutFormatAlignAllTop
															   metrics:nil
																 views:@{@"lbl2": lbl2, @"btn2": btn2}];
	[self.view addConstraints:cTop2];
	[self.view addConstraints:cRow2];
	[btn2 addConstraint:cBtn2];
	[row2 addConstraints:constr2];
	
	NSLog(@"%@", self.view.constraints);
}

- (void)viewDidAppear:(BOOL)animated
{
	NSLog(@"row1: %@", NSStringFromCGRect(_row1.frame));
	NSLog(@"row2: %@", NSStringFromCGRect(_row2.frame));
}

- (void)insert:(id)sender
{
	NSLog(@"Adding a row");
	UILabel *lbl = [UILabel new];
	lbl.translatesAutoresizingMaskIntoConstraints = NO;
	lbl.numberOfLines = 0;
	lbl.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
	lbl.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25f];
	lbl.text = @"So, this row has been inserted. Cool, aint't it?";
	
	UIButton *btn = [UIButton new];
	btn.translatesAutoresizingMaskIntoConstraints = NO;
	btn.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25f];
	[btn setTitle:@"Row" forState:UIControlStateNormal];
	
	UIView *row = [UIView new];
	row.translatesAutoresizingMaskIntoConstraints = NO;
	row.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25f];
	[row addSubview:lbl];
	[row addSubview:btn];
	[self.view addSubview:row];
	
	NSArray *cTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[row1]-[row(>=lbl,>=btn)]" options:0 metrics:nil views:@{@"row1": _row1, @"row": row, @"lbl": lbl, @"btn": btn}];
	NSArray *cRow = [NSLayoutConstraint constraintsWithVisualFormat:@"|[row]|" options:0 metrics:nil views:@{@"row": row}];
	NSLayoutConstraint *cBtn = [NSLayoutConstraint constraintWithItem:btn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:0.f constant:44.f];
	NSArray *cRowInner = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[lbl]-[btn(100)]-|"
															   options:NSLayoutFormatAlignAllTop
															   metrics:nil
																 views:@{@"lbl": lbl, @"btn": btn}];
	[self.view addConstraints:cTop];
	[self.view addConstraints:cRow];
	[btn addConstraint:cBtn];
	[row addConstraints:cRowInner];
	NSLog(@"Did add, update lower row");
	
	NSArray *old = [_row2 constraintsAffectingLayoutForAxis:UILayoutConstraintAxisVertical];
	for (NSLayoutConstraint *constr in old) {
		if (_row2 == constr.firstItem && NSLayoutAttributeTop == constr.firstAttribute) {
			[self.view removeConstraint:constr];
			break;
		}
	}
	
	[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[row1]-[row2]" options:0 metrics:nil views:@{@"row1": row, @"row2": _row2}]];
	[self.view setNeedsUpdateConstraints];
	[UIView animateWithDuration:0.2 animations:^{
		[self.view layoutIfNeeded];
	}];
	NSLog(@"Added");
}


@end
