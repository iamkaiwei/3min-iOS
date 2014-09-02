//
//  TMESearchFilterOnlyTableVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/1/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMESearchFilterOnlyTableVC.h"
#import "TMESearchFilter.h"
#import "UITextField+TMEAdditions.h"

typedef NS_ENUM(NSUInteger, TMESearchFilterOnlyTableViewSection) {
    TMESearchFilterOnlyTableViewSectionCriteria,
    TMESearchFilterOnlyTableViewSectionPriceRange,
};

static NSUInteger const kDefaultMinPrice = 0;
static NSUInteger const kDefaultMaxPrice = 500;

@interface TMESearchFilterOnlyTableVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *minPriceTextField;
@property (weak, nonatomic) IBOutlet UITextField *maxPriceTextField;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;
@property (nonatomic, strong) NSNumberFormatter *numberFormatter;

@end

@implementation TMESearchFilterOnlyTableVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.searchFilter = [TMESearchFilter defaultFilter];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setupTextFields];
    [self resetFilter];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupTextFields
{
    [self.minPriceTextField tme_addDoneButton];
    [self.maxPriceTextField tme_addDoneButton];
}

#pragma mark - UITableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if (indexPath.section == TMESearchFilterOnlyTableViewSectionCriteria) {
        if ([indexPath isEqual:self.selectedIndexPath]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == TMESearchFilterOnlyTableViewSectionCriteria) {
        self.selectedIndexPath = indexPath;

        self.searchFilter.criteria = indexPath.row;

        [tableView reloadSections:[NSIndexSet indexSetWithIndex:TMESearchFilterOnlyTableViewSectionCriteria]
                 withRowAnimation:UITableViewRowAnimationNone];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSNumber *minPrice, *maxPrice;

    minPrice = [self.numberFormatter numberFromString:self.minPriceTextField.text];
    maxPrice = [self.numberFormatter numberFromString:self.maxPriceTextField.text];

    if ([self validatePriceRangeWithMinPrice:minPrice maxPrice:maxPrice]) {
        self.searchFilter.minPrice = minPrice;
        self.searchFilter.maxPrice = maxPrice;
    }
}

- (BOOL)validatePriceRangeWithMinPrice:(NSNumber *)minPrice maxPrice:(NSNumber *)maxPrice
{
    // TODO: Refactor
    // Validate
    if (minPrice.integerValue < kDefaultMinPrice) {
        NSString *message = [NSString stringWithFormat:@"Minimum price must be greater than %d", kDefaultMinPrice];
        [TMEAlertView showMessage:message];

        self.searchFilter.minPrice = @(kDefaultMinPrice);
        self.minPriceTextField.text = [self.numberFormatter stringFromNumber:self.searchFilter.minPrice];

        return NO;
    }

    if (maxPrice.integerValue > kDefaultMaxPrice) {
        NSString *message = [NSString stringWithFormat:@"Maximum price must be less than %d", kDefaultMaxPrice];
        [TMEAlertView showMessage:message];

        self.searchFilter.maxPrice = @(kDefaultMaxPrice);
        self.maxPriceTextField.text = [self.numberFormatter stringFromNumber:self.searchFilter.maxPrice];

        return NO;
    }

    if (minPrice.integerValue > maxPrice.integerValue) {
        NSString *message = [NSString stringWithFormat:@"Minimum price must be less than maximum price"];
        [TMEAlertView showMessage:message];

        self.minPriceTextField.text = [self.numberFormatter stringFromNumber:self.searchFilter.minPrice];
        self.maxPriceTextField.text = [self.numberFormatter stringFromNumber:self.searchFilter.maxPrice];

        return NO;
    }

    return YES;

}

#pragma mark - Filter
- (void)resetFilter
{
    self.searchFilter = [TMESearchFilter defaultFilter];

    self.selectedIndexPath = [NSIndexPath indexPathForRow:self.searchFilter.criteria
                                                inSection:TMESearchFilterOnlyTableViewSectionCriteria];

    self.minPriceTextField.text = [self.numberFormatter stringFromNumber:self.searchFilter.minPrice];
    self.maxPriceTextField.text = [self.numberFormatter stringFromNumber:self.searchFilter.maxPrice];

    [self.tableView reloadData];
}

#pragma mark - NumberFormatter
- (NSNumberFormatter *)numberFormatter
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _numberFormatter = [[NSNumberFormatter alloc] init];
    });

    return _numberFormatter;
}

@end
