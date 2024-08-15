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
    -(void)setBadgeValue:(NSString*)value { //hook setBadgeValue to prevent apps from reverting badgecount, safe to spam call
        NSString* bundleIdentifier = [self bundleIdentifier];
        NSString* result = badgeSync(bundleIdentifier);
        NSLog(@"SETTER: App: %@, BadgeValue: %@", bundleIdentifier, result);
        %orig(result); //likely %orig() does some extra stuff to repaint the badge
    }
%end

%hook NCNotificationStructuredListViewController
    - (void)removeNotificationRequest:(NCNotificationRequest*)notif { // will be called in bursts if multiple notifs of an app are cleared at once
        %orig; //run orig before to update masterlist
        NSLog(@"Remove: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:nil]; // arg doesn't matter here, this is just to call badgeSync() and repaint
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




