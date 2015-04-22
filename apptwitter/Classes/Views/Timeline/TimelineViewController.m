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
#import "TableViewCell.h"

@interface TimelineViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TimelineViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [_tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    [self.tabBarController.navigationItem setHidesBackButton:YES];
     self.tabBarController.navigationItem.title = @"Home画面";
    
    
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

//テーブルに表示するデータ件数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 5;
}

//テーブルに表示するセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    return cell;
}
//セルの高さを指定
-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}


#pragma mark - UIButton Touch Handler
-(void)showProfileViewController {
   //モーダル表示;

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
