//
//  TableViewCell.h
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/22.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell {
    UIImageView *profileView;
    UILabel *userName;
    UILabel *timeLabel;
    UITextView *tweet;
    
}

@property (weak, nonatomic) IBOutlet UIImageView *profileView;

@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweet;

@end
