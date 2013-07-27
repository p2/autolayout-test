//
//  PPViewController.h
//  FontTest
//
//  Created by Pascal Pfiffner on 7/6/13.
//  Copyright (c) 2013 Ossus. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIView *header;
@property (weak, nonatomic) IBOutlet UISlider *slider1;
@property (weak, nonatomic) IBOutlet UISlider *slider2;

- (IBAction)pop:(id)sender;

@end
