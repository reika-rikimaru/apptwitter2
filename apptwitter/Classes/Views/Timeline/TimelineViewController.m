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
#import "TimelineTableViewCell.h"
#import "LoginViewController.h"
#import <TwitterKit/TwitterKit.h>

@interface TimelineViewController ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation TimelineViewController

//タイムラインの最新20Tweetを保存する配列
NSArray *tweetArray;

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.UITableView.delegate = self;
    self.UITableView.dataSource = self;
    [self.UITableView registerNib:[UINib nibWithNibName:@"TimelineTableViewCell" bundle:nil] forCellReuseIdentifier:@"Cell"];
    [self.tabBarController.navigationItem setHidesBackButton:YES];
    NSMutableArray *userNameArray;
    NSMutableArray *tweetTextArray;
    userNameArray = [[NSMutableArray alloc] initWithCapacity:0];
    tweetTextArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self getTimeline];
     //投稿ボタンを追加
    UIBarButtonItem * contributeButton = [[UIBarButtonItem alloc] initWithTitle:@"投稿"
                                                                          style:UIBarButtonItemStylePlain target:self
                                                                         action:@selector(showContributeViewController)];
    self.tabBarController.navigationItem.rightBarButtonItem = contributeButton;
    
     //profileボタンを追加
    UIBarButtonItem * profileButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile"
                                                                       style:UIBarButtonItemStylePlain target:self
                                                                      action:@selector
                                                                         (showProfileViewController)];
    self.tabBarController.navigationItem.leftBarButtonItem = profileButton;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.navigationItem.title = @"Home画面";
//    self.tabBarController.navigationController.na;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)getTimeline {
    //タイムラインの取得
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
                        tweetArray = [NSJSONSerialization JSONObjectWithData:responseData
                                                                     options: NSJSONReadingMutableLeaves error:&jsonError];
                        
                        [self.UITableView reloadData];
                    }
                }];
            } else {
                [self alertAccountProblem];
            }
        }

    }];
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

//テーブルに表示するデータ件数を返す
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tweetArray.count;
}

//テーブルに表示するセルを返す
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TimelineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[TimelineTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    NSDictionary *tweetMessage = [tweetArray objectAtIndex:[indexPath row]];
    //ユーザ情報を格納するJSONを解析し、NSDictionaryに
    NSDictionary *userInfo = [tweetMessage objectForKey:@"user"];
    //投稿時間を格納するJSONを解析し、NSDictionaryに
    
    cell.tweet.text = [tweetMessage objectForKey:@"text"];
    [cell.tweet sizeToFit];
    CGRect rect = cell.tweet.frame;
    rect.size.height = CGRectGetHeight(cell.tweet.frame);
    cell.tweet.frame = rect;
    
    cell.tweet.backgroundColor = [UIColor blueColor];
    cell.userName.text = [userInfo objectForKey:@"screen_name"];
    NSURL *profURL = [NSURL URLWithString:@"http://pbs.twimg.com/profile_images/592495079169765378/-UzhitaR_normal.jpg"];
    NSData *profData = [NSData dataWithContentsOfURL:profURL];
    UIImage *profImage = [UIImage imageWithData:profData];
    cell.profileView.image  = profImage;
    
    NSString *inputStr = [tweetMessage objectForKey:@"created_at"];
    NSString *outputStr = [self twitterCreatedAtToFormatString:inputStr format:@"yyyy/MM/dd HH:mm:ss"];
    cell.timeLabel.text = [self twitterCreatedAtToFormatString:inputStr format:@"yyyy/MM/dd HH:mm:ss"];
    
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

//セルのスタイルを標準のものに指定
static NSString *CellIdentifier = @"TweetCell";


//セルの高さを指定
-(CGFloat)tableView:(UITableView*)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UIButton Touch Handler
-(void)showProfileViewController {
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
