//
//  AppDelegate.h
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/16.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
 UITabBarController *tabBarController_;
}
@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)appDelegate;
- (void)setShowLoggedInViewController;
- (void)switchTabBarController:(NSInteger)selectedViewIndex;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

