//
//  PPRelView.m
//  FontTest
//
//  Created by Pascal Pfiffner on 7/7/13.
//  Copyright (c) 2013 Ossus. All rights reserved.
//

#import "PPRelView.h"


@implementation PPRelView


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


@end
