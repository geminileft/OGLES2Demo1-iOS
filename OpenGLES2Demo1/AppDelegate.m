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

- (void)dealloc
{
    [mWindow release];
    [super dealloc];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    mWindow = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    DemoViewController* glvc = [[DemoViewController alloc] init];
    mWindow.rootViewController = glvc;
    [mWindow makeKeyAndVisible];
    [glvc release];
    return YES;
}

@end
