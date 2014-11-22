//
//  TMEFeedbackCell.h
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TMEFeedbackCell : UITableViewCell

@property (weak, nonatomic) IBOutlet KHRoundAvatar *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *feedbackLabel;

@end
