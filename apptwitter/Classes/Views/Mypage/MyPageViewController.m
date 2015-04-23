//
//  MyPageViewController.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/20.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "MyPageViewController.h"
#import "MyPageTableViewCell.h"
#import "TimelineViewController.h"
#import "TimelineTableViewCell.h"

@interface MyPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBarController.navigationItem.title = @"MyPage画面";
    [_tableView registerNib:[UINib nibWithNibName:@"MyPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    NSLog(@"vsojpadf");

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
    MyPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[MyPageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    return cell;
}
//セルの高さを指定
-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

@end
