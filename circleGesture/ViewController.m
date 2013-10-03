//
//  ViewController.m
//  circleGesture
//
//  Created by Stephen Kyles on 9/26/13.
//  Copyright (c) 2013 Blue Owl Labs. All rights reserved.
//

#import "ViewController.h"
#import "gesture.h"
#import "draw.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    gesture * recognizer2 = [[gesture alloc] initWithTarget:self action:@selector(handleCircle:)];
    [self.view addGestureRecognizer:recognizer2];
    _count = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleCircle:(gesture *)recognizer {
    NSLog(@"circle gesture found!");
    _count++;
    UIImage *circleImg = [UIImage imageNamed:@"state.png"];
    UIImageView *singleState = [[UIImageView alloc] initWithImage:circleImg];
    CGRect frame = CGRectMake(50, 380, 100, 100);
    [singleState setFrame:frame];
    [self.view addSubview:singleState];
    NSLog(@"count %d", _count);
}

@end
