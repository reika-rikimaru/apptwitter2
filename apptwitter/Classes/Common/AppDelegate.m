//
//  AppDelegate.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/16.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>


@interface AppDelegate ()

@end

@implementation AppDelegate
//clientId
static NSString * const kOauth2ClientClientId = @""; //クライアントIDを設定
//Client Secret
static NSString * const kOauth2ClientClientSecret = @"xxx"; //クライアントシークレットを設定

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Fabric with:@[TwitterKit]];

    
    
//    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
//    UIViewController *secondViewController = [navigationController.storyboard instantiateViewControllerWithIdentifier:@"TimelineViewController"];
//    [navigationController pushViewController:secondViewController animated:NO];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [self saveContext];
}

#pragma mark Public Methods

+ (AppDelegate *)appDelegate {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)setShowLoggedInViewController {
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    UITabBarController *tweetTab = [[UITabBarController alloc] init];
    UIViewController *secondViewController = [navigationController.storyboard instantiateViewControllerWithIdentifier:@"TimelineViewController"];
    UIViewController *secondViewController2 = [navigationController.storyboard instantiateViewControllerWithIdentifier:@"MyPageViewController"];
    NSArray *viewTweet = [NSArray arrayWithObjects:secondViewController, secondViewController2, nil];
    [tweetTab setViewControllers:viewTweet animated:NO];
    navigationController = [[UINavigationController alloc] initWithRootViewController:tweetTab];
    navigationController.navigationBar.translucent = NO;
    navigationController.tabBarController.tabBar.translucent = NO;
    self.window.rootViewController = navigationController;
}
#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
        return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
        if (_managedObjectModel != nil) {
        return _managedObjectModel;
}
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"apptwitter" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
       if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
}
    
       _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"apptwitter.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
}
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
       if (_managedObjectContext != nil) {
        return _managedObjectContext;
}
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
}
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
                        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
