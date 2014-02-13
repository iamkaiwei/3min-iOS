//
//  TMEOfferedTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 2/13/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMEOfferedTableViewCell : TMEBaseTableViewCell

- (void)configCellWithData:(TMEConversation *)conversation;
+ (CGFloat)getHeight;

@end
