//
//  PPRelView.m
//  FontTest
//
//  Created by Pascal Pfiffner on 7/7/13.
//  Copyright (c) 2013 Ossus. All rights reserved.
//

#import "PPRelView.h"


@interface PPRelView ()

@property (weak, nonatomic, readwrite) UILabel *label;
@property (weak, nonatomic, readwrite) UIButton *button;

@property (copy, nonatomic) NSArray *widthConstraints;

@end


@implementation PPRelView


- (id)initWithFrame:(CGRect)frame
{
	if ((self = [super initWithFrame:frame])) {
		self.translatesAutoresizingMaskIntoConstraints = NO;
		self.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.25f];
		
		// add subview size constraints
		NSArray *cTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[row(>=lbl,>=btn)]" options:0 metrics:nil views:@{@"row": self, @"lbl": self.label, @"btn": self.button}];
		NSArray *cRowInner = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[lbl]-[btn(100)]-|"
																	 options:NSLayoutFormatAlignAllCenterY
																	 metrics:nil
																	   views:@{@"lbl": self.label, @"btn": self.button}];
		NSLayoutConstraint *cRowCenter = [NSLayoutConstraint constraintWithItem:self.label
																	  attribute:NSLayoutAttributeCenterY
																	  relatedBy:NSLayoutRelationEqual
																		 toItem:_label.superview
																	  attribute:NSLayoutAttributeCenterY
																	 multiplier:1.f constant:0.f];
		[self addConstraints:cTop];
		[self addConstraints:cRowInner];
		[self addConstraint:cRowCenter];
	}
	
	return self;
}



#pragma mark - Chain
- (void)setPrevious:(PPRelView *)previous
{
	if (previous != _previous) {
		PPRelView *oldPrev = (self == _previous.next) ? _previous : nil;
		
		_previous = previous;
		previous.next = self;
		oldPrev.next = nil;
	}
}

- (void)setNext:(PPRelView *)next
{
	if (next != _next) {
		PPRelView *oldNext = (self == _next.previous) ? _next : nil;
		
		_next = next;
		next.previous = self;
		oldNext.previous = nil;
	}
}



#pragma mark - Constraints
- (void)alignBelowView:(PPRelView *)view
{
	NSAssert(self.superview != nil, @"You must add the row to a superview first");
	
	if (view && view == _previous) {
		return;
	}
	
	PPRelView *oldNext = view.next;
	oldNext.topConstraint = [oldNext topConstraintTo:self];
	oldNext.previous = self;
	
	self.topConstraint = [self topConstraintTo:view];
	self.previous = view;
	
	[self.superview setNeedsUpdateConstraints];
}

- (void)removeFromSuperview
{
	PPRelView *oldNext = _next;
	if (oldNext) {
		oldNext.topConstraint = [oldNext topConstraintTo:_previous];
		oldNext.previous = _previous;
	}
	
	self.topConstraint = nil;
	self.widthConstraints = nil;
	
	[super removeFromSuperview];
}

- (void)didMoveToSuperview
{
	if (self.superview) {
		self.widthConstraints = [self widthConstraintsTo:self.superview];
	}
}



- (NSLayoutConstraint *)topConstraintTo:(PPRelView *)view
{
	return [NSLayoutConstraint constraintWithItem:self
										attribute:NSLayoutAttributeTop
										relatedBy:NSLayoutRelationEqual
										   toItem:(view ? view : self.superview)
										attribute:(view ? NSLayoutAttributeBottom : NSLayoutAttributeTop)
									   multiplier:(view ? 1.f : 0.f)
										 constant:(view ? 8.f : 44.f)];
}

- (void)setTopConstraint:(NSLayoutConstraint *)topConstraint
{
	if (topConstraint != _topConstraint) {
		if (_topConstraint) {
			[self.superview removeConstraint:_topConstraint];
		}
		
		_topConstraint = topConstraint;
		
		if (_topConstraint && self.superview) {
			[self.superview addConstraint:_topConstraint];
		}
	}
}

- (NSArray *)widthConstraintsTo:(UIView *)view
{
	return [NSLayoutConstraint constraintsWithVisualFormat:@"|[row]|" options:0 metrics:nil views:@{@"row": self}];
}

- (void)setWidthConstraints:(NSArray *)widthConstraints
{
	if (widthConstraints != _widthConstraints) {
		if (_widthConstraints) {
			[self.superview removeConstraints:_widthConstraints];
		}
		
		_widthConstraints = [widthConstraints copy];
		
		if (_widthConstraints && self.superview) {
			[self.superview addConstraints:_widthConstraints];
		}
	}
}



#pragma mark - Subviews
- (UILabel *)label
{
	if (!_label) {
		UILabel *lbl = [UILabel new];
		lbl.tag = 1;
		lbl.translatesAutoresizingMaskIntoConstraints = NO;
		lbl.numberOfLines = 0;
		lbl.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
		lbl.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.25f];
		
		[self addSubview:lbl];
		self.label = lbl;
	}
	
	return _label;
}

- (UIButton *)button
{
	if (!_button) {
		UIButton *btn = [UIButton new];
		btn.tag = 2;
		btn.translatesAutoresizingMaskIntoConstraints = NO;
		btn.backgroundColor = [[UIColor greenColor] colorWithAlphaComponent:0.25f];
		
		[self addSubview:btn];
		self.button = btn;
	}
	
	return _button;
}


@end
