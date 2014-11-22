//
//  TMEPostFeedbackVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 11/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEPostFeedbackVC.h"
#import <SZTextView/SZTextView.h>

typedef NS_ENUM(NSUInteger, TMEPostFeedbackSection) {
    TMEPostFeedbackSectionImage,
    TMEPostFeedbackSectionSatisfaction,
    TMEPostFeedbackSectionTextView,
};

@interface TMEPostFeedbackVC () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *productImageView;
@property (weak, nonatomic) IBOutlet SZTextView *feedbackTextView;

@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end

@implementation TMEPostFeedbackVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupNavigationItems];
    [self setupTextView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup
- (void)setupNavigationItems
{
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem cancelItemWithTarget:self action:@selector(cancelTouched:)];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem submitItemWithTarget:self action:@selector(submitTouched:)];
}

- (void)setupTextView
{
    self.feedbackTextView.placeholder = @"Feedback goes here";
}

#pragma mark - UITableViewDataSouce
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];

    if ([indexPath isEqual:self.selectedIndexPath]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }

    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == TMEPostFeedbackSectionSatisfaction) {
        if (![indexPath isEqual:self.selectedIndexPath]) {
            self.selectedIndexPath = indexPath;
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
        }
        return;
    }
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }

    return YES;
}

#pragma mark - Action
- (void)cancelTouched:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)submitTouched:(id)sender
{

}

@end
