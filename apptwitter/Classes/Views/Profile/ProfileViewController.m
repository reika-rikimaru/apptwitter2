//
//  ProfileViewController.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/20.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "ProfileViewController.h"
#import "TimelineViewController.h"
#import <UIKit/UIKit.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(dismissPlofileViewController)];
    NSLog(@"konnni");
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.title = @"編集画面";
    self.IDlabel.text = self.userName;
    self.myIntroduce.text = self.introduce;
    self.profView.image = self.profImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIButton Touch Handler
- (IBAction)pushUpdateButton:(id)sender{
    //更新するボタン
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dismissPlofileViewController{
    //モーダルを消す
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
