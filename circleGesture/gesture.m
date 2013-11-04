//
//  gesture.m
//  circleGesture
//
//  Created by Stephen Kyles on 9/26/13.
//  Copyright (c) 2013 Blue Owl Labs. All rights reserved.
//

#import "gesture.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@implementation gesture
@synthesize points;

// On new touch, start a new array of points
- (void) touchesBegan:(NSSet *) touches withEvent:(UIEvent *) event
{
    self.points = [NSMutableArray array];
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    [self.points addObject:[NSValue valueWithCGPoint:pt]];
}

// Add each point to the array
- (void) touchesMoved:(NSSet *) touches withEvent:(UIEvent *) event
{
    CGPoint pt = [[touches anyObject] locationInView:self.view];
    [self.points addObject:[NSValue valueWithCGPoint:pt]];
    [self.view setNeedsDisplay];
}

// At the end of touches, determine whether a circle was drawn
- (void) touchesEnded:(NSSet *) touches withEvent:(UIEvent *) event
{
    if (!self.points) return;
    
    NSLog(@"first point %@", [self.points objectAtIndex:0]);
    NSLog(@"last point %@", [self.points lastObject]);
    
    NSValue *t1 = [self.points objectAtIndex:0];
    NSValue *t2 = [self.points lastObject];
    
    NSLog(@"t1 is %@", t1);
    NSLog(@"t2 is %@", t2);
    
    CGPoint p1 = [t1 CGPointValue];
    CGPoint p2 = [t2 CGPointValue];
    
    // Circle Test 1: The start and end points must be between 60 pixels of each other
    CGFloat yDist = (p2.y - p1.y);
    CGFloat xDist = (p2.x - p1.x);
    CGFloat distance = sqrt((xDist * xDist) + (yDist * yDist));
    if (distance < 60.0f)
        [self setState:UIGestureRecognizerStateRecognized];
    
    /*
    // Circle Test 2: Count the distance traveled in degrees.
    //CGRect tcircle;
    CGPoint center = CGPointMake(CGRectGetMidX(tcircle), CGRectGetMidY(tcircle));
    float distance = ABS(acos(dotproduct(centerPoint(POINT(0), center), centerPoint(POINT(1), center))));
    for (int i = 1; i < (self.points.count - 1); i++)
        distance += ABS(acos(dotproduct(centerPoint(POINT(i), center), centerPoint(POINT(i+1), center))));
    if ((ABS(distance - 2 * M_PI) < (M_PI / 4.0f))) tcircle = tcircle;
    */
    
    [self.view setNeedsDisplay];
    [self reset];
}

// reset points for touches
- (void)reset {
    self.pt = CGPointZero;
    if (self.state == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateFailed];
    }
}

@end
