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
- (void) setBadgeValue:(id)value;
@end

@interface NCNotificationGroupList : NSObject
@property NSMutableArray<NCNotificationRequest*>* orderedRequests;
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

@interface BBSectionInfoSettings : NSObject
@property BOOL showsInNotificationCenter; //notif centre
@property BOOL showsInLockScreen; //Lockscreen
@property BOOL allowsNotifications;
@property NSUInteger alertType; //0 for no Banners at all, 1 for temporary Banners, 2 for persistent
@end

@interface BBSectionInfo : NSObject
{
    NSMutableDictionary* _sectionInfoByID;
}
@property BBSectionInfoSettings* readableSettings;
@end

@interface BBServer : NSObject
+(NSMutableDictionary*)savedSectionInfo;
@end