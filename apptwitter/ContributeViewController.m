//
//  ContributeViewController.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/20.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "ContributeViewController.h"
#import "TimelineViewController.h"
#import <UIKit/UIKit.h>


@interface ContributeViewController ()

@end

@implementation ContributeViewController

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    UIBarButtonItem * backButton = [[UIBarButtonItem alloc] initWithTitle:@"戻る"
                                                            style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(dismissContributeViewController)];
 
    self.navigationItem.leftBarButtonItem = backButton;
    
    self.navigationItem.title = @"投稿画面";
 
}

- (void)didReceiveMemoryWarning{
    
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UIButton Touch Handler
//投稿するボタン
-(IBAction)pushContributeButton:(id)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


//モーダルを消す
- (void)dismissContributeViewController{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end


