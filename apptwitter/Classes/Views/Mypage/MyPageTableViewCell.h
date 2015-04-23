//
//  TableViewCell.h
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/23.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyPageTableViewCell : UITableViewCell {
    
    UIImageView *Profile;
    UILabel *userName;
    UILabel *time;
    UILabel *tweet;
    
}

@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *Tweet;
@property (weak, nonatomic) IBOutlet UILabel *Time;
@property (weak, nonatomic) IBOutlet UIImageView *Profile;




@end
