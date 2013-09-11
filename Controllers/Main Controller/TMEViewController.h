//
//  ViewController.h
//  PhotoButton
//
//  Created by Triệu Khang on 08/09/13.
//  Copyright (c) 2013 hasBrain. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TMEPhotoButton;

@interface TMEViewController : UIViewController
{
}

@property (nonatomic, assign) IBOutlet TMEPhotoButton *photoButton;

- (IBAction)photoSaved:(id)sender;

@end
