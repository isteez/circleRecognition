//
//  gesture.h
//  circleGesture
//
//  Created by Stephen Kyles on 9/26/13.
//  Copyright (c) 2013 Blue Owl Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleGesture : UIGestureRecognizer {
    NSMutableArray *points;
}

@property (assign) CGPoint pt;
@property (nonatomic, retain) NSMutableArray *points;

@end