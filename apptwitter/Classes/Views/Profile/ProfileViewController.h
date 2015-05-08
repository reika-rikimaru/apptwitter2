//
//  ProfileViewController.h
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/20.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *profView;
@property (weak, nonatomic) IBOutlet UILabel *IDlabel;
@property (weak, nonatomic) IBOutlet UILabel *myIntroduce;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *introduce;
@property (nonatomic, strong) UIImage *profImage;

@end
