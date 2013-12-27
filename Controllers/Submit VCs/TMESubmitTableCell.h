//
//  TMESubmitTableCell.h
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "TMEBaseTableViewCell.h"

@interface TMESubmitTableCell : TMEBaseTableViewCell

- (CGFloat)getHeightWithContent:(NSString *)content;
- (void)configCellWithMessage:(TMEMessage *)message andSeller:(TMEUser *)seller;

@end
