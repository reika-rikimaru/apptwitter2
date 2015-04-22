//
//  ProfileViewController.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/20.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "ProfileViewController.h"
#import "TimelineViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad{
   
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(dismissPlofileViewController)];

    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = @"編集画面";
    
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIButton Touch Handler
   //更新するボタン

- (IBAction)pushUpdateButton:(id)sender{

    [self dismissViewControllerAnimated:YES completion:nil];
    
}

  //モーダルを消す
- (void)dismissPlofileViewController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"ig");

}

@end
