//
//  TMEEditProductLocationVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/18/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEEditProductLocationVC.h"
#import "TMESingleSectionDataSource.h"
#import <CoreLocation/CoreLocation.h>

@interface TMEEditProductLocationVC () <UITextFieldDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *locationTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) TMESingleSectionDataSource *dataSource;

@end

@implementation TMEEditProductLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTableView];
    [self displayProduct];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupNavigationItems
{
    self.title = @"Location";
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
}

#pragma mark - Setup
- (void)setupTableView
{
    self.tableView.delegate = self;

    self.dataSource = [[TMESingleSectionDataSource alloc] init];
    self.dataSource.cellIdentifier = [UITableViewCell kind];
    self.dataSource.cellConfigureBlock = ^(UITableViewCell *cell, SVPlacemark *placemark) {
        cell.textLabel.text = placemark.formattedAddress;
    };

    self.tableView.dataSource = self.dataSource;

    self.tableView.alpha = 0;
}

- (void)displayProduct
{
    if (self.product.locationText.length > 0) {
        self.locationTextField.text = self.product.locationText;
    } else if (self.product.venueLat && self.product.venueLong) {
        self.locationTextField.text = nil;
        CLLocation *location = [[CLLocation alloc] initWithLatitude:self.product.venueLat.doubleValue longitude:self.product.venueLong.doubleValue];
        [SVGeocoder reverseGeocode:location.coordinate completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
            SVPlacemark *placemark = placemarks.lastObject;
            self.product.locationText = placemark.formattedAddress;
            self.locationTextField.text = self.product.locationText;
        }];
    }
}

#pragma mark - Action
- (void)cancelTouched:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    [self getLocation];

    return YES;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    SVPlacemark *placemark = self.dataSource.items[indexPath.row];
    self.product.venueLat =  @(placemark.coordinate.latitude);
    self.product.venueLong = @(placemark.coordinate.longitude);
    self.product.locationText = placemark.formattedAddress;

    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Location
- (void)getLocation
{
    [SVProgressHUD show];
    [SVGeocoder geocode:self.locationTextField.text completion:^(NSArray *placemarks, NSHTTPURLResponse *urlResponse, NSError *error) {
        [self handleGetLocationResults:placemarks];
    }];
}

- (void)handleGetLocationResults:(NSArray *)placemarks
{
    if (placemarks.count == 0) {
        [SVProgressHUD showErrorWithStatus:@"Please try again"];
        [self hideTableView];
    } else {
        [SVProgressHUD dismiss];
        [self showTableView];
        self.dataSource.items = placemarks;
        [self.tableView reloadData];
    }
}

#pragma mark - Toggle TableView
- (void)showTableView
{
    [self toggleTableViewVisibility:YES];
}

- (void)hideTableView
{
    [self toggleTableViewVisibility:NO];
}

- (void)toggleTableViewVisibility:(BOOL)visible
{

    [UIView animateWithDuration:0.25 animations:^{
        self.tableView.alpha = visible ? 1 : 0;
    } completion:^(BOOL finished) {

    }];
}

@end
