//
//  TMEProductAddCommentVC.m
//  ThreeMin
//
//  Created by Khoa Pham on 9/22/14.
//  Copyright (c) 2014 3min. All rights reserved.
//

#import "TMEProductAddCommentVC.h"
#import "TMEProductComment.h"
#import "TMEProductCommentNetworkClient.h"
#import "TMEProduct.h"

@interface TMEProductAddCommentVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

@end

@implementation TMEProductAddCommentVC

- (void)awakeFromNib
{
    self.title = @"Add Comment";
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)sendButtonAction:(id)sender
{
    [SVProgressHUD show];
    self.sendButton.enabled = NO;

    TMEProductCommentNetworkClient *client = [[TMEProductCommentNetworkClient alloc] init];
    [client createCommentForProduct:self.product content:self.textField.text completion:^(BOOL succeeded) {
        self.sendButton.enabled = YES;

        if (succeeded) {
            [SVProgressHUD showSuccessWithStatus:nil];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [SVProgressHUD showErrorWithStatus:nil];
        }
    }];
    
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];

    return YES;
}

@end
