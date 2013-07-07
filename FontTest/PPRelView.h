//
//  PPRelView.h
//  FontTest
//
//  Created by Pascal Pfiffner on 7/7/13.
//  Copyright (c) 2013 Ossus. All rights reserved.
//

@import UIKit;


@interface PPRelView : UIView

@property (weak, nonatomic, readonly) UILabel *label;
@property (weak, nonatomic, readonly) UIButton *button;

@property (weak, nonatomic) PPRelView *previous;
@property (weak, nonatomic) PPRelView *next;
@property (weak, nonatomic) NSLayoutConstraint *topConstraint;

- (void)alignBelowView:(PPRelView *)view;

@end
