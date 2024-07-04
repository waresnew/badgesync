#import <Foundation/Foundation.h>

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

%hook NCNotificationStructuredListViewController // will be called in bursts if multiple notifs of an app are cleared at once
    - (void)removeNotificationRequest:(NCNotificationRequest*)notif {
        SBApplicationController* applicationController = [%c(SBApplicationController) sharedInstance];
        SBApplication* app = [applicationController applicationWithBundleIdentifier:notif.sectionIdentifier];
        if (app) {
            NSInteger newBadgeValue = [[app badgeValue] integerValue]-1;
            [app setBadgeValue:newBadgeValue > 0? [@(newBadgeValue) stringValue]:nil];
        }
        %orig;
    }
%end