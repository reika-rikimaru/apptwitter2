//
//  ViewController.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/16.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "LoginViewController.h"
#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"
#import <TwitterKit/TwitterKit.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (error) {
            NSLog(@"Error : %@", error);
        } else {
            NSLog(@"UserName : %@", session.userName);
            [self showTimelineViewController];
        }
    }];

    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];
    [self.navigationItem setHidesBackButton:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (void)showTimelineViewController
{
    TimelineViewController  *timelineViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TimelineViewController"];
    [self.navigationController pushViewController:timelineViewController animated:YES];
}

@end