//
//  TMETransactionManager.h
//  PhotoButton
//
//  Created by Toan Slan on 12/23/13.
//
//

#import "BaseManager.h"
#import "TMEMessage.h"

@interface TMEMessageManager : BaseManager

- (void)getListMessageOfProduct:(TMEProduct *)product
                      fromBuyer:(TMEUser *)fromBuyer
                         toUser:(TMEUser *)toUser
                 onSuccessBlock:(void (^) (NSArray *arrayProducts))successBlock
                andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

- (void)postMessageTo:(TMEUser *)user
           forProduct:(TMEProduct *)product
          withMessage:(NSString *)message
       onSuccessBlock:(void (^) (TMEMessage *message))successBlock
      andFailureBlock:(TMEJSONRequestFailureBlock)failureBlock;

@end
