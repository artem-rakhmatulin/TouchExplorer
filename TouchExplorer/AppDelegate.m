//
//  AppDelegate.m
//  TouchExplorer
//
//  Created by Artem Rakhmatulin on 05/04/2020.
//  Copyright © 2020 Rakhmatulin Artem Timurovich IP. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()
{
    UIWindow *_window;
}
@end

@implementation AppDelegate

- (UIWindow *)window
{
    return _window;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_window setRootViewController:[[ViewController alloc] init]];
    [_window makeKeyAndVisible];
    
    return YES;
}

@end
