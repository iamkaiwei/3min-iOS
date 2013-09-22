//
//  BaseViewController.h
//  MyBaseProject
//
//  Created by Torin on 1/12/12.
//  Copyright (c) 2012 MyCompany. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAITrackedViewController.h"

#define LABEL_SPACING             5

@interface TMEBaseViewController : GAITrackedViewController <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *activeTextField;
@property (nonatomic, assign) BOOL previousVCIsHome;
@property (nonatomic, strong) UILabel *titleLabel;

/**
 A Boolean value that specifies whether views should avoid keyboard. Default is YES.
 */
@property (nonatomic) BOOL shouldAvoidKeyboard;

- (UIViewController*)initWithNib;

/*
 * Obtain a class instance object from a string class name
 */
- (UIViewController*)getViewControllerWithClassName:(NSString*)theClassName;

/*
 * Use a standard 'Back' button in navbar instead of title of previous view controller
 */
- (void)useStandardNavbarBackButton;

/*
 * Use a custom button title for left/right navbar button, with standard look & feel
 */
- (void)setCustomNavbarLeftButtonTitle:(NSString*)title selector:(SEL)selector;
- (void)setCustomNavbarRightButtonTitle:(NSString*)title selector:(SEL)selector;

/*
 * Auto adjust content size for UIScrollView according to its subviews
 */
- (void)autoAdjustScrollViewContentSize;

/*
 * Show a standard webview controller
 */
//- (void)showWebviewWithURL:(NSString *)urlString;

/*
 * Pops navigation controller
 */
- (IBAction)onBtnBack:(id)sender;


/**
 *list all notification this view can receive
 *return: array of notification
 */
- (NSArray *)listNotificationInterests;

/**
 *lMethod to handle all notification this view receive
 *@Param notification: notification this view recieve
 */
- (void)handleNotification:(NSNotification *)notification;

/*
 * Local notification helpers
 */
- (void)sendNotification:(NSString *)notificationName;
- (void)sendNotification:(NSString *)notificationName body:(id)body;
- (void)sendNotification:(NSString *)notificationName body:(id)body type:(id)type;

@end

