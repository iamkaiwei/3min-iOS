//
//  TMESubmitTableCellRight.h
//  PhotoButton
//
//  Created by admin on 12/25/13.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMESubmitTableCellRight : TMEBaseTableViewCell

- (CGFloat)getHeightWithContent:(NSString *)content;
- (void)configCellWithMessage:(TMEMessage *)message andSeller:(TMEUser *)seller;

@end
