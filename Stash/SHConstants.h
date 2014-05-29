//
//  SHConstants.h
//  Stash
//
//  Created by Taylor Potter on 5/26/14.
//  Copyright (c) 2014 stash. All rights reserved.
//

@import Foundation;

static NSString * const kStashTitleKey = @"title";
static NSString * const kStashTextKey = @"text";
static NSString * const kStashOriginKey = @"isMine";
static NSString * const kStashObjectId = @"objectId";
static NSString * const kStashObjectUUID = @"uuid";

static NSString * const kApplicationID = @"1Dn8UFej0pHivPQNQ4qooKFuFYCZ3lQXrp4cXSiH";
static NSString * const kRESTAPI = @"jg4nfT5flFUjO82XPkbb2geckCXQHADrNpjFo5qw";

static NSString * const kApplicationIDKey = @"X-Parse-Application-Id";
static NSString * const kRESTAPIKey = @"X-Parse-REST-API-Key";

static NSString * const kStashAPIURL = @"https://api.parse.com/1/classes/Stash";

#define SH_EDIT_VIEW_CONTROLLER 0
#define SH_BROWSE_VIEW_CONTROLLER 320
#define SH_HOME_VIEW_CONTROLLER 640
#define SH_ADD_PITCH_VIEW_CONTROLLER 960
#define SH_ADD_TITLE_VIEW_CONTROLLER 1280
#define SH_ADD_CATEGORY_VIEW_CONTROLLER 1600