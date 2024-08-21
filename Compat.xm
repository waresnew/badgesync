#import <Compat.h>
%hook AXNManager
    -(void)removeNotificationRequest:(NCNotificationRequest*)notif {
        %orig;
        NSLog(@"Axon Remove: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:@"BadgeSync"];
    }
    -(void)insertNotificationRequest:(NCNotificationRequest*)notif {
        %orig;
        NSLog(@"Axon Insert: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:@"BadgeSync"];
    }
%end