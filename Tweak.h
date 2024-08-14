#import <Foundation/Foundation.h>
#import <HBLog.h>

@interface NCNotificationRequest : NSObject
@property NSString* sectionIdentifier; // eg. com.apple.MobileSMS
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(NSString*)identifier; //eg. com.apple.MobileSMS
@end

@interface SBApplication : NSObject
@property NSString* badgeValue; // nil if no badge
@property NSString* bundleIdentifier;
- (void) setBadgeValue:(NSString*)value;
@end

@interface NCNotificationGroupList : NSObject
@end

@interface NCNotificationMasterList : NSObject
@property NSArray* notificationSections;
@end

@interface NCNotificationStructuredListViewController : NSObject
@property NCNotificationMasterList* masterList;
@end

@interface NCNotificationStructuredSectionList : NSObject
- (NSArray*)allNotificationRequests;
@end