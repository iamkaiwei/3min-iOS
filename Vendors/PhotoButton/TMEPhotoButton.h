//
//  PhotoButton.h
//
//  Created by AT on 6/18/12.
//

#import <UIKit/UIKit.h>

@class TMEPhotoButton;

@protocol TMEPhotoButtonDelegate

@optional
- (void)didFinishGetImageWithImageUrl:(NSString *)localURL;
- (void)beforeGetImageWithPhotoButton:(TMEPhotoButton *)photoButton;

@end

@interface TMEPhotoButton : UIButton
<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIViewController    *viewController;
@property (nonatomic, strong) UIPopoverController *popoverController;
@property (nonatomic, strong) NSString            *photoName;
@property (nonatomic)         CGSize              photoSize;

- (void)takeOrChoosePhoto:(BOOL)take;

@end
