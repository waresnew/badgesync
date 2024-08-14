#import <Foundation/Foundation.h>
#import <HBLog.h>
//UNUserNotificationServiceConnection, UNUserNotificationCenter didn't work
//didRemoveNotificationRequest is for tap clear and swipe
//requestsClearingPresentables is for all in a group

@interface NCNotificationRequest : NSObject
@property NSString* sectionIdentifier; // eg. com.apple.MobileSMS
@end

@interface SBApplicationController : NSObject
+ (id)sharedInstance;
- (id)applicationWithBundleIdentifier:(NSString*)identifier; //eg. com.apple.MobileSMS
@end

@interface SBApplication : NSObject
@property NSString* badgeValue; // nil if no badge
- (void) setBadgeValue:(NSString*)value;
@end

@interface NCNotificationGroupList : NSObject
@end

@interface NCNotificationMasterList : NSObject
@end

void badgeDecrement(NCNotificationRequest* notif) {
    SBApplicationController* applicationController = [%c(SBApplicationController) sharedInstance];
    SBApplication* app = [applicationController applicationWithBundleIdentifier:notif.sectionIdentifier];
    if (app) {
        NSInteger newBadgeValue = [[app badgeValue] integerValue]-1;
        [app setBadgeValue:newBadgeValue > 0? [@(newBadgeValue) stringValue]:nil];
        NSLog(@"Notification removed: app is %@, new badgevalue is %ld", notif.sectionIdentifier, (long) newBadgeValue);
    }
}

%hook NCNotificationStructuredListViewController
    -(void)notificationListBaseComponent:(NCNotificationGroupList*)groupList requestsClearingPresentables:(NSArray*)notifs {
        for (NCNotificationRequest* notif in notifs) {
            NSLog(@"ClearAll: %@", notif.sectionIdentifier);
            badgeDecrement(notif);
        }
        %orig;
    }
    -(void)notificationListComponent:(NCNotificationMasterList*)notifList didRemoveNotificationRequest:(NCNotificationRequest*)notif {
        NSLog(@"ClearOne: %@", notif.sectionIdentifier);
        badgeDecrement(notif);
        %orig;
    }
%end




