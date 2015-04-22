//
//  TimelineViewController.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/20.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "TimelineViewController.h"
#import "ProfileViewController.h"
#import "ContributeViewController.h"


@interface TimelineViewController ()

@end

@implementation TimelineViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self.tabBarController.navigationItem setHidesBackButton:YES];
     self.tabBarController.navigationItem.title = @"Home画面";
     self.view.backgroundColor = [UIColor redColor];
    
     //投稿ボタンを追加
    UIBarButtonItem * contributeButton = [[UIBarButtonItem alloc] initWithTitle:@"投稿"
                                                                          style:UIBarButtonItemStylePlain target:self
                                                                         action:@selector(showContributeViewController)];
    self.tabBarController.navigationItem.rightBarButtonItem = contributeButton;
    
     //profileボタンを追加
    UIBarButtonItem * profileButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile"
                                                                       style:UIBarButtonItemStylePlain target:self
                                                                      action:@selector(showProfileViewController)];
    self.tabBarController.navigationItem.leftBarButtonItem = profileButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIButton Touch Handler
- (void)showProfileViewController {
   //モーダル表示
    ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    [self presentViewController:navigationController animated:YES completion:nil];

}

- (void)showContributeViewController {
    //モーダル表示
    ContributeViewController *contributeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ContributeViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:contributeViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
}

@end
