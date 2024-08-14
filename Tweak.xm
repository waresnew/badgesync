#import <Tweak.h>

NCNotificationStructuredListViewController* notifController;

NSString* badgeSync(NSString* bundleIdentifier) {
    NSMutableArray<NCNotificationRequest*>* notifs = [NSMutableArray new];
    NCNotificationMasterList* masterList = [notifController masterList];
    for(NCNotificationStructuredSectionList* section in [masterList notificationSections]) {
        [notifs addObjectsFromArray:[section allNotificationRequests]];
    }

    NSInteger count = 0;
    for (NCNotificationRequest* notif in notifs) {
        if ([notif.sectionIdentifier isEqualToString:bundleIdentifier]) {
            count++;
        }
    }
    return count==0?nil:[@(count) stringValue];
}

SBApplication* getApp(NSString* bundleIdentifier) {
    SBApplicationController* applicationController = [%c(SBApplicationController) sharedInstance];
    return [applicationController applicationWithBundleIdentifier:bundleIdentifier];
}

%hook SBApplication
    -(void)setBadgeValue:(NSString*)value {
        NSString* bundleIdentifier = [self bundleIdentifier];
        NSString* result = badgeSync(bundleIdentifier);
        NSLog(@"SETTER: App: %@, BadgeValue: %@", bundleIdentifier, result);
        %orig(result); //likely %orig() does some extra stuff to repaint the badge
    }
%end

%hook NCNotificationStructuredListViewController
    -(void)notificationListBaseComponent:(NCNotificationGroupList*)groupList requestsClearingPresentables:(NSArray*)notifs {
        %orig; //run orig before to update masterlist
        for (NCNotificationRequest* notif in notifs) {
            NSLog(@"ClearAll: %@", notif.sectionIdentifier);
            [getApp(notif.sectionIdentifier) setBadgeValue:nil]; // arg doesn't matter here, this is just to call badgeSync() and repaint
        }
    }
    -(void)notificationListComponent:(NCNotificationMasterList*)notifList didRemoveNotificationRequest:(NCNotificationRequest*)notif {
        %orig;
        NSLog(@"ClearOne: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:nil];
    }
    -(void)insertNotificationRequest:(NCNotificationRequest*)notif {
        %orig;
        NSLog(@"Insert: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:nil];
    }
    -(id)init {
        self = %orig;
        notifController = self;
        return self;
    }
%end




