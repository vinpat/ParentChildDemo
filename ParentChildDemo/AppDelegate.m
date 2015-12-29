//
//  AppDelegate.m
//  ParentChildDemo
//
//  Created by Vinod on 29/12/15.
//

#import "AppDelegate.h"
#import "PCDAppViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setBackgroundColor:[UIColor whiteColor]];
    
    PCDAppViewController *appController = [[PCDAppViewController alloc] init];
    [self.window setRootViewController:appController];
    
    [self.window makeKeyAndVisible];
    [self setWindow:self.window];
    
    return YES;
}

@end
