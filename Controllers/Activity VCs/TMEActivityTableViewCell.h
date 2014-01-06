//
//  TMEActivityTableViewCell.h
//  PhotoButton
//
//  Created by admin on 1/2/14.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMEActivityTableViewCell : TMEBaseTableViewCell

- (void)configCellWithConversation:(TMEConversation *)conversation;
+ (CGFloat)getHeight;
@end
