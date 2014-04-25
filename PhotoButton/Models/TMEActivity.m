#import "TMEActivity.h"


@interface TMEActivity ()

// Private interface goes here.

@end


@implementation TMEActivity

// Custom logic goes here.
- (BOOL)activityFromDictionary:(NSDictionary *)dict {
    BOOL result = [KZPropertyMapper mapValuesFrom:dict
                         toInstance:self
                       usingMapping:@{
                                      @"id": KZProperty(id),
                                      @"content": KZProperty(content),
                                      @"subject_id": KZProperty(subject_id),
                                      @"subject_type": KZProperty(subject_type),
                                      @"update_time": KZProperty(update_time)
                                      }];
    return result;
}

@end
