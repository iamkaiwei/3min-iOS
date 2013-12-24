//
//  TMESubmitTableCell.h
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMESubmitTableCell : TMEBaseTableViewCell

+ (CGFloat)getHeight;
- (void)configCellWithConversation:(TMETransaction *)transaction andSeller:(TMEUser *)seller;

@end
