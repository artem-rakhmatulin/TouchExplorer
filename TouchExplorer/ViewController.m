//
//  ViewController.m
//  TouchExplorer
//
//  Created by Artem Rakhmatulin on 05/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    View *_v;
    UILabel *_messageLabel;
}
@end

@implementation ViewController

- (View *)v
{
    return _v;
} //v

- (instancetype)init
{
    self = [super init];
    if (self) {
        _v = [[View alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)loadView
{
    [self setView:_v];
} //loadView

@end
