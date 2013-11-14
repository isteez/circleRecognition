//
//  ViewController.m
//  circleGesture
//
//  Created by Stephen Kyles on 9/26/13.
//  Copyright (c) 2013 Blue Owl Labs. All rights reserved.
//

#import "ViewController.h"
#import "CircleGesture.h"
#import "draw.h"

@interface ViewController ()
{
    CGPoint _priorPoint;
}
@end

@implementation ViewController
@synthesize stateArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // array of first touch points once a circle is successfully detected
    self.stateArray = [NSMutableArray array];
    
    // add custom circle gesture recognizer
    CircleGesture *circleRecognizer = [[CircleGesture alloc] initWithTarget:self action:@selector(handleCircle:)];
    [self.view addGestureRecognizer:circleRecognizer];
    
    // image for states
    circleImg = [UIImage imageNamed:@"State.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)handleCircle:(CircleGesture *)recognizer
{
    // find first touch point of successful circle
    NSValue *value = [recognizer.points objectAtIndex:0];
    CGPoint p1 = [value CGPointValue];
    
    // create imageview for new state
    UIImageView *singleState = [[UIImageView alloc] initWithFrame:CGRectMake(p1.x, p1.y, 100, 100)];
    singleState.userInteractionEnabled = YES;
    
    // state label
    UILabel *stateName = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, 100, 100)];
    stateName.text = [NSString stringWithFormat:@"q%d", stateArray.count];
    [singleState addSubview:stateName];
    
    // add first touch point of successful circle to state array
    [self.stateArray addObject:value];
    NSLog(@"%@", value);
    
    // attach long press gesture to the imageview
    UIGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    [singleState addGestureRecognizer:longPress];
    
    // add double tap gesture to the imageview
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    [singleState addGestureRecognizer:doubleTapRecognizer];
    
    // add the state image to the imageview
    singleState.image = circleImg;
    [self.view addSubview:singleState];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    // once long press begins, apply shadow
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        recognizer.view.layer.shadowOffset = CGSizeMake(0, 5);
        recognizer.view.layer.shadowRadius = 5;
        recognizer.view.layer.shadowOpacity = 0.4;
    }
    
    // once long press state has changed, move state
    UIView *view = recognizer.view;
    CGPoint point = [recognizer locationInView:view.superview];
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        CGPoint center = view.center;
        center.x += point.x - _priorPoint.x;
        center.y += point.y - _priorPoint.y;
        view.center = center;
    }
    _priorPoint = point;
    
    // once long press has ended, remove shadow
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        recognizer.view.layer.shadowOpacity = 0.0;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}

@end

