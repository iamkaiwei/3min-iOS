//
//  TMESearchFilterOnlyTableVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/1/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchFilterOnlyTableVC.h"
#import "TMESearchFilter.h"

typedef NS_ENUM(NSUInteger, TMESearchFilterOnlyTableViewSection) {
    TMESearchFilterOnlyTableViewSectionCriteria,
    TMESearchFilterOnlyTableViewSectionPriceRange,
};

@interface TMESearchFilterOnlyTableVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *minPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxPriceTextField;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation TMESearchFilterOnlyTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.selectedIndexPath = [NSIndexPath indexPathForRow:TMESearchFilterCriteriaPopular
                                                inSection:TMESearchFilterOnlyTableViewSectionCriteria];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup


#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == TMESearchFilterOnlyTableViewSectionCriteria) {
        UITableViewCell *previousCell = [tableView cellForRowAtIndexPath:self.selectedIndexPath];
        previousCell.accessoryType = UITableViewCellAccessoryNone;

        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.selectedIndexPath = indexPath;
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"textFieldDidEndEditing");
}


@end
