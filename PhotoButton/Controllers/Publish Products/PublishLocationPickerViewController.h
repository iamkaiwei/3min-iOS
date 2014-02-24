//
//  PublishLocationPickerViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 23/2/14.
//
//

#import "TMEBaseTableViewController.h"
#import "TMEPublishProductViewController.h"

typedef void (^SelectedVenueBlock)(FSVenue *venue);

@interface PublishLocationPickerViewController : TMEBaseTableViewController

- (id)initWithSelectedVenueBlock:(SelectedVenueBlock)returnBlock;

@end
