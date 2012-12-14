//
//  AppDelegate.m
//  OpenGLES2Demo1
//
//  Created by dev on 12/12/12.
//  Copyright (c) 2012 gemini left. All rights reserved.
//

#import "AppDelegate.h"
#import "DemoViewController.h"

@implementation AppDelegate

@synthesize window = mWindow;

- (void)dealloc
{
    [mWindow release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    
    DemoViewController* glvc = [[DemoViewController alloc] init];
    self.window.rootViewController = glvc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
