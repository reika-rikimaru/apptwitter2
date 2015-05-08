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
#import "LoginViewController.h"
#import "ProfileViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface MyPageViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation MyPageViewController
NSArray *myTweetArray;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tabBarController.navigationItem.title = @"MyPage画面";
    [self.tableView registerNib:[UINib nibWithNibName:@"MyPageTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    NSMutableArray *userNameArray;
    NSMutableArray *tweetTextArray;
    userNameArray = [[NSMutableArray alloc] initWithCapacity:0];
    tweetTextArray = [[NSMutableArray alloc] initWithCapacity:0];
    [self getMyTimeline];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
//アカウント情報を設定画面で編集するかを確認するalert View表示
-(void)alertAccountProblem {
    // メインスレッドで表示させる
    dispatch_async(dispatch_get_main_queue(), ^{
        //メッセージを表示
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Twitterアカウント"
                                                        message:@"アカウントに問題があります。今すぐ「設定」でアカウント情報を確認してください"
                                                       delegate:self
                                              cancelButtonTitle:nil
                                              otherButtonTitles:@"はい",nil
                              ];
        [alert show];
    });

}

-(void)getMyTimeline{
    ACAccountStore *store = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    NSString *apiURL = @"https://api.twitter.com/1.1/statuses/home_timeline.json";
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
        if (!granted) {
            NSLog(@"Twitterへの認証が拒否されました。");
            [self alertAccountProblem];
        } else {
            //ユーザーの了解が取れた場合
            //デバイスに保存されているTwitterのアカウント情報をすべて取得
            NSArray *twitterAccounts = [store accountsWithAccountType:twitterAccountType];
            //Twitterのアカウントが1つ以上登録されている場合
            if ([twitterAccounts count] > 0) {
                //0番目のアカウントを使用
                ACAccount *account = [twitterAccounts objectAtIndex:0];
                //認証が必要な要求に関する設定
                NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
                [params setObject:@"1" forKey:@"include_entities"];
                //リクエストを生成
                NSURL *url = [NSURL URLWithString:apiURL];
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                        requestMethod:SLRequestMethodGET
                                                                  URL:url parameters:params];
                //リクエストに認証情報を付加
                [request setAccount:account];
                //ステータスバーのActivity Indicatorを開始
                [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
                //リクエストを発行
                [request performRequestWithHandler:^(
                                                     NSData *responseData,
                                                     NSHTTPURLResponse *urlResponse,
                                                     NSError *error) {
                    if (!responseData) {
                        //Twitterからの応答がなかった場合
                        NSLog(@"response error: %@", error);
                        //Twitterからの返答があった場合
                    } else {
                        //JSONの配列を解析し、TweetをNSArrayの配列に入れる
                        NSError *jsonError;
                        myTweetArray = [NSJSONSerialization JSONObjectWithData:responseData
                                                                       options: NSJSONReadingMutableLeaves error:&jsonError];
                        
                        [self.tableView reloadData];
                    }
                }];
            } else {
                [self alertAccountProblem];
            }
        }
        
    }];
    
}
//テーブルに表示するデータ件数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return myTweetArray.count;

}

//テーブルに表示するセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyPageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[MyPageTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    
    
    NSDictionary *tweetMessage = [myTweetArray objectAtIndex:[indexPath row]];
    //ユーザ情報を格納するJSONを解析し、NSDictionaryに
    NSDictionary *userInfo = [tweetMessage objectForKey:@"user"];
    //投稿時間を格納するJSONを解析し、NSDictionaryに
    cell.Tweet.text = [tweetMessage objectForKey:@"text"];
    cell.userName.text = [userInfo objectForKey:@"screen_name"];
    cell.Time.text = [tweetMessage objectForKey:@"created_at"];
    NSURL *profURL = [NSURL URLWithString:@"http://pbs.twimg.com/profile_images/592495079169765378/-UzhitaR_normal.jpg"];
    NSLog(@"profURL%@", profURL);
    NSData *profData = [NSData dataWithContentsOfURL:profURL];
    UIImage *profImage = [UIImage imageWithData:profData];
    NSLog(@"profImage%@", profImage);
    cell.Profile.image  = profImage;
    NSLog(@"tweetMessage%@", tweetMessage);
    
    NSString *inputStr = [tweetMessage objectForKey:@"created_at"];
    NSLog(@"%@", inputStr);
    NSString *outputStr = [self twitterCreatedAtToFormatString:inputStr format:@"yyyy/MM/dd HH:mm:ss"];
    NSLog(@"%@", outputStr); //-> "2014/01/05 02:19:53"
    cell.Time.text = [self twitterCreatedAtToFormatString:inputStr format:@"yyyy/MM/dd HH:mm:ss"];

    return cell;
    
}

- (NSString *)twitterCreatedAtToFormatString:(NSString * )dateString format:(NSString *)format {
    //引数をNSDateに変換
    NSDateFormatter *inputFormat = [[NSDateFormatter alloc] init];
    [inputFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    [inputFormat setDateFormat:@"eee MMM dd HH:mm:ss ZZZZ yyyy"];
    NSDate *date = [inputFormat dateFromString:dateString];
    //NSDateを文字列に変換
    NSDateFormatter *outputFormat = [[NSDateFormatter alloc] init];
    [outputFormat setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [outputFormat setDateFormat:format];
    return [outputFormat stringFromDate:date];
    
}


//セルの高さを指定
-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

-(void)showProfileViewController {
    //モーダル表示
    
    ProfileViewController *profileViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:profileViewController];
    [self presentViewController:navigationController animated:YES completion:nil];
    
}

@end
