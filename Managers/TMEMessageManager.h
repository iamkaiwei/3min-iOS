//
//  TMEMessageManager.h
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "BaseManager.h"
#import "TMEMessage.h"

@interface TMEMessageManager : BaseManager

- (void)getListMessageOfProduct:(TMEProduct *)product
                      withBuyer:(TMEUser *)fromBuyer
                         toUser:(TMEUser *)toUser
                 onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)postMessageTo:(TMEUser *)user
           forProduct:(TMEProduct *)product
          withMessage:(NSString *)message
       onSuccessBlock:(void (^) (NSString *status))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
