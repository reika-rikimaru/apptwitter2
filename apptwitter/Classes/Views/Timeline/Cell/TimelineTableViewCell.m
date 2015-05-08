//
//  TableViewCell.m
//  apptwitter
//
//  Created by 力丸 玲嘉 on 2015/04/22.
//  Copyright (c) 2015年 reika.rikimaru. All rights reserved.
//

#import "TimelineTableViewCell.h"

@interface TimelineTableViewCell ()

@end

@implementation TimelineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
    tweet = [[UILabel alloc] initWithFrame:CGRectZero];
    tweet.numberOfLines = 0;
    [self.contentView addSubview:tweet];
    
    profileView  = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:profileView];
    
    userName = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:userName];

    timeLabel =  [[UILabel alloc] initWithFrame:CGRectZero];
    }
    return self;
  
}

-(void)layoutSubviews {
    
[super layoutSubviews];
//    
//    self.profileView.frame = CGRectMake(5, 5, 48, 48);
//    self.userName.frame = CGRectMake(58, self.tweetHeight+20, 80, 20);
//    self.timeLabel.frame = CGRectMake(138, self.tweetHeight+20, 96, 20);
//    self.tweet.frame = CGRectMake(58, 5, 257, self.tweetHeight);
//    
//    self.profileView = profileView;
//    self.userName = userName;
//    self.timeLabel = timeLabel;
//    self.tweet = tweet;
//
    
}
@end

