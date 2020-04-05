//
//  View.m
//  TouchExplorer
//
//  Created by Artem Rakhmatulin on 05/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "View.h"

#define kMinGestureLenth 25

@interface View ()
{
    UILabel *_messageLabel;
    UILabel *_tapsLabel;
    UILabel *_touchesLabel;
    UILabel *_gestureLabel;
    
    CGPoint _touchBeganPoint;
}
@end

@implementation View

#pragma mark - Getters

- (UILabel *)messageLabel
{
    return _messageLabel;
} //messageLabel

- (UILabel *)tapsLabel
{
    return _tapsLabel;
} //tapsLabel

- (UILabel *)touchesLabel
{
    return _touchesLabel;
} //touchesLabel

- (UILabel *)gestureLabel
{
    return _gestureLabel;
} //gestureLabel

#pragma mark -

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UISwipeGestureRecognizer *verticalSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportVerticalSwipe)];
        [verticalSwipeRecognizer setDirection:0b1100];
        [verticalSwipeRecognizer setNumberOfTouchesRequired:1];
        [verticalSwipeRecognizer setCancelsTouchesInView:NO];
        
        UISwipeGestureRecognizer *horizontalSwipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(reportHorizontalSwipe)];
        [horizontalSwipeRecognizer setDirection:0b0011];
        [horizontalSwipeRecognizer setNumberOfTouchesRequired:1];
        [horizontalSwipeRecognizer setCancelsTouchesInView:NO];
        
        UITapGestureRecognizer *singleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reportSingleTap)];
        [singleTapGestureRecognizer setNumberOfTouchesRequired:1];
        [singleTapGestureRecognizer setNumberOfTapsRequired:1];
        [singleTapGestureRecognizer setCancelsTouchesInView:NO];
        
        UITapGestureRecognizer *doubleTapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reportDoubleTap)];
        [doubleTapGestureRecognizer setNumberOfTouchesRequired:1];
        [doubleTapGestureRecognizer setNumberOfTapsRequired:2];
        [doubleTapGestureRecognizer setCancelsTouchesInView:NO];
        [singleTapGestureRecognizer requireGestureRecognizerToFail:doubleTapGestureRecognizer];
        
        [self addGestureRecognizer:singleTapGestureRecognizer];
        [self addGestureRecognizer:doubleTapGestureRecognizer];
        [self addGestureRecognizer:verticalSwipeRecognizer];
        [self addGestureRecognizer:horizontalSwipeRecognizer];
        
        _messageLabel = [[UILabel alloc] init];
        _tapsLabel = [[UILabel alloc] init];
        _touchesLabel = [[UILabel alloc] init];
        _gestureLabel = [[UILabel alloc] init];
        
        [self setMultipleTouchEnabled:YES];
        
#pragma mark Layout
        
        [self addSubview:_messageLabel];
        [self addSubview:_tapsLabel];
        [self addSubview:_touchesLabel];
        [self addSubview:_gestureLabel];
        
        for (UIView *view in [self subviews]) {
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }
        
        [NSLayoutConstraint activateConstraints:@[
            [_messageLabel.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:16.0],
            [_messageLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8.0],
            [_messageLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8.0],
            
            [_touchesLabel.topAnchor constraintEqualToAnchor:_messageLabel.bottomAnchor constant:8.0],
            [_touchesLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8.0],
            [_touchesLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8.0],
            
            [_tapsLabel.topAnchor constraintEqualToAnchor:_touchesLabel.bottomAnchor constant:8.0],
            [_tapsLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8.0],
            [_tapsLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8.0],
            
            [_gestureLabel.topAnchor constraintEqualToAnchor:_tapsLabel.bottomAnchor constant:8.0],
            [_gestureLabel.leftAnchor constraintEqualToAnchor:self.leftAnchor constant:8.0],
            [_gestureLabel.rightAnchor constraintEqualToAnchor:self.rightAnchor constant:-8.0]
        ]];
        
#pragma mark Style
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [_gestureLabel setTextColor:[UIColor redColor]];
        
        [_messageLabel setText:@"Touch to begin"];
    }
    return self;
} //initWithFrame:

#pragma mark - Touch Event Methods

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateLabelsFromTouches:touches inMethod:_cmd];
    
    if (1 == [touches count])
        _touchBeganPoint = [[touches anyObject] locationInView:self];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateLabelsFromTouches:touches inMethod:_cmd];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self updateLabelsFromTouches:touches inMethod:_cmd];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches cancelled:\n%@", touches);
}

- (void)updateLabelsFromTouches:(NSSet<UITouch *> *)touches inMethod:(SEL)sel
{
    [_messageLabel setText:NSStringFromSelector(sel)];
    [_touchesLabel setText:[NSString stringWithFormat:@"%ld touches detected", [touches count]]];
    [_tapsLabel setText:[NSString stringWithFormat:@"%ld taps detected", [[touches anyObject] tapCount]]];
}

#pragma mark - Other methods

- (void)reportSingleTap
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(eraseGestureLabel) object:nil];
    [_gestureLabel setText:@"Single tap detected"];
    [self performSelector:@selector(eraseGestureLabel) withObject:nil afterDelay:1.0];
}

- (void)reportDoubleTap
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(eraseGestureLabel) object:nil];
    [_gestureLabel setText:@"Double tap detected"];
    [self performSelector:@selector(eraseGestureLabel) withObject:nil afterDelay:1.0];
}

- (void)reportVerticalSwipe
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(eraseGestureLabel) object:nil];
    [_gestureLabel setText:@"Vertical swipe detected"];
    [self performSelector:@selector(eraseGestureLabel) withObject:nil afterDelay:1.0];
}

- (void)reportHorizontalSwipe
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(eraseGestureLabel) object:nil];
    [_gestureLabel setText:@"Horizontal swipe detected"];
    [self performSelector:@selector(eraseGestureLabel) withObject:nil afterDelay:1.0];
}

- (void)eraseGestureLabel
{
    [_gestureLabel setText:@""];
}

@end
