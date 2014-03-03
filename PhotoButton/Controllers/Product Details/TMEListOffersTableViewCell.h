//
//  TMEListOffersTableViewCell.h
//  PhotoButton
//
//  Created by Toan Slan on 3/3/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMEListOffersTableViewCell : TMEBaseTableViewCell

- (void)configCellWithData:(TMEConversation *)conversation;
+ (CGFloat)getHeight;

@end
