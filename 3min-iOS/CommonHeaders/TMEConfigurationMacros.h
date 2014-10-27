//
//  TMEConfigurationMacros.h
//  ThreeMin
//
//  Created by Khoa Pham on 7/17/14.
//  Copyright (c) 2014 3min. All rights reserved.
//


//------------------------------------------------------------------------------------------------------
// Debug vs Production configurations
//------------------------------------------------------------------------------------------------------
#import "TMECommonHeaders.h"

#ifdef TME_PRODUCTION
// Production

#define API_BASE_URL                                @"https://threemins-server.herokuapp.com"
#define API_CLIENT_ID                               @"36d9b0cae1fb797b3095ebd8c50ef4b58df47f16d5aa18f96704f4c484136869"
#define API_GRANT_TYPE                              @"password"

#define PUSHER_APP_KEY                              @"ce3898cbc04d99f952cd"
#define FLURRY_API_KEY                              @"76DX6MC5DYNGYYNSYX3F"

#define URBAN_AIRSHIP_APP_KEY                       @"tyVT4cw2TFi529WyWJswXA"
#define URBAN_AIRSHIP_APP_SECRET                    @"pLdhKxkZTdiGmqFmWEGaPg"

#define SETTINGS_LOCALYTICS_TOKEN_DEFAULT           @"f7e86c8413e50da8f46d1af-130c72d6-0489-11e3-11a5-004a77f8b47f"
#define SETTINGS_NEW_RELIC_TOKEN_DEFAULT            @""
#define SETTINGS_ITUNE_APP_ID                       @""
#define ENABLE_TRIPPLE_TAP_PREFILL                  NO
#define GOOGLE_ANALYTICS_APP_KEY                    @"UA-44232541-1"

#else
// Staging

#define API_BASE_URL                                @"http://threemins-server-staging.herokuapp.com"
#define API_CLIENT_ID                               @"36d9b0cae1fb797b3095ebd8c50ef4b58df47f16d5aa18f96704f4c484136869"
#define API_GRANT_TYPE                              @"password"

#define PUSHER_APP_KEY                              @"ce3898cbc04d99f952cd"
#define FLURRY_API_KEY                              @"76DX6MC5DYNGYYNSYX3F"

#define URBAN_AIRSHIP_APP_KEY                       @"-IT-qB3pRBiec3liyxk4cQ"
#define URBAN_AIRSHIP_APP_SECRET                    @"rp9clmV1RzGi0GfPUiO0iA"

#define SETTINGS_LOCALYTICS_TOKEN_DEFAULT           @""
#define SETTINGS_NEW_RELIC_TOKEN_DEFAULT            @""
#define SETTINGS_ITUNE_APP_ID                       @""
#define ENABLE_TRIPPLE_TAP_PREFILL                  YES
#define GOOGLE_ANALYTICS_APP_KEY                    @"UA-44232541-1"

#endif

// Common
#define APP_VERSION                                 ([[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey])




// API Path
#define API_SERVER_HOST                             ([NSString stringWithFormat:@"%@%@", API_BASE_URL, API_PREFIX])

#define NOTIFICATION_RELOAD_CONVERSATION            @"updateConversationTableView"
#define NOTIFICATION_FINISH_LOGIN                   @"NotificationFinishLogin"
#define API_CLIENT_SERCET                           @"8eb597435160bcef09084a9bbd32c9d2a309b97b33f2e7284d2ac8c3840a0834"

#define API_PREFIX                                  @"/api/v1"
#define API_PRODUCTS                                @"/api/v1/products"
#define API_USER                                    @"/api/v1/users"
#define API_POPULAR                                 @"/api/v1/popular"
#define API_CONVERSATIONS                           @"/api/v1/conversations"
#define API_CONVERSATIONS_EXIST                     @"/exist"
#define API_CONVERSATION_REPLIES                    @"/api/v1/conversation_replies"
#define API_CREATE_BULK                             @"/api/v1/bulk_create"
#define API_OFFER                                   @"/api/v1/offer"
#define API_SHOW_OFFER                              @"/api/v1/show_offer"
#define API_LIKES                                   @"/api/v1/likes"
#define API_LIKED                                   @"/api/v1/liked"
#define API_ME                                      @"/api/v1/me"
#define API_CATEGORY                                @"/api/v1/categories"
#define API_CATEGORY_TAGGABLE                       @"/api/v1/taggable"
#define API_USER_LOGIN                              @"/oauth/token"
#define API_ACTIVITY                                @"/api/v1/activities"
#define URL_PUSHER_ENDPOINT                         @"/api/v1/pushers/auth"


#define PUSHER_CHAT_EVENT_NAME                      @"client-chat"
#define PUSHER_CHAT_EVENT_TYPING                    @"client-typing"
#define PUSHER_CHAT_EVENT_UNTYPING                  @"client-untyping"
