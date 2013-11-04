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
@synthesize count;

- (void)viewDidLoad
{
    [super viewDidLoad];
    gesture * recognizer2 = [[gesture alloc] initWithTarget:self action:@selector(handleCircle:)];
    [self.view addGestureRecognizer:recognizer2];
    count = 0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 // handleCircle function in order:
 // debug
 // running count for number of circles found
 // retrieve touchBegin point from successful gesture
 // convert NSValue to CGPoint
 // create circle image
 // set circle frame; where to place the image
 // set image
 // add image to view
 // debug
 */

- (void)handleCircle:(gesture *)recognizer {
    NSLog(@"circle gesture found!");
    count++;
    NSValue *value = [recognizer.points objectAtIndex:0];
    CGPoint p1 = [value CGPointValue];
    UIImage *circleImg = [UIImage imageNamed:@"state.png"];
    UIImageView *singleState = [[UIImageView alloc] initWithFrame:CGRectMake(p1.x, p1.y, 100, 100)];
    singleState.image = circleImg;
    [self.view addSubview:singleState];
    NSLog(@"count %d", count);
}

@end

