#import <Shared.h>
#import <dlfcn.h>
#import <objc/runtime.h>
#import <Compat.h>
#import <rootless.h>

NCNotificationStructuredListViewController* notifController;
NSArray<NSString*>* blacklist;

NSMutableArray<NCNotificationRequest*>* getNotifs() {
    NSMutableArray<NCNotificationRequest*>* notifs = [NSMutableArray new];
    if (%c(TKOController)) {
        NSLog(@"Using Tako notif list");
        TKOController* tako = [%c(TKOController) sharedInstance];
        for (TKOBundle* bundle in [tako bundles]) {
            [notifs addObjectsFromArray:[bundle notifications]];
        }
        return notifs;
    }
    NCNotificationMasterList* masterList = [notifController masterList];
    for(NCNotificationStructuredSectionList* section in [masterList notificationSections]) {
        [notifs addObjectsFromArray:[section allNotificationRequests]];
    }
    return notifs;
}

NSString* badgeSync(NSString* bundleIdentifier) {
    NSMutableArray<NCNotificationRequest*>* notifs = getNotifs();
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

BOOL notifCentreEnabled(NSString* bundleIdentifier) { //don't set badge to 0 for apps that don't show notifs
    BBSectionInfo* sectionInfo = [%c(BBServer) savedSectionInfo][bundleIdentifier];
    if (!sectionInfo) {
        return NO;
    }
    BBSectionInfoSettings* notifSettings = [sectionInfo readableSettings];
    return [notifSettings allowsNotifications] && ([notifSettings showsInNotificationCenter] || [notifSettings showsInLockScreen]); //banners don't popup in masterlist
}

%hook SBApplication
    -(void)setBadgeValue:(id)value { //hook setBadgeValue to prevent apps from reverting badgecount, safe to spam call
        NSString* bundleIdentifier = [self bundleIdentifier];
        if ([blacklist containsObject:bundleIdentifier] || !notifCentreEnabled(bundleIdentifier)) {
            NSLog(@"SETTER: App: %@; skipping", bundleIdentifier);
            if (![value isKindOfClass:[NSString class]] || ![value isEqualToString:@"BadgeSync"]) { //organic call
                %orig;
            }
            return;
        }
        NSString* result = badgeSync(bundleIdentifier);
        NSLog(@"SETTER: App: %@, BadgeValue: %@", bundleIdentifier, result);
        %orig(result); //likely %orig() does some extra stuff to repaint the badge
    }
%end

%hook NCNotificationStructuredListViewController
    - (void)removeNotificationRequest:(NCNotificationRequest*)notif { // will be called in bursts if multiple notifs of an app are cleared at once
        %orig; //run orig before to update masterlist
        NSLog(@"Remove: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:@"BadgeSync"]; // arg doesn't matter here (but make it unique so i can cancel it later), this is just to call badgeSync() and repaint
    }
    -(void)insertNotificationRequest:(NCNotificationRequest*)notif {
        %orig;
        NSLog(@"Insert: %@", notif.sectionIdentifier);
        [getApp(notif.sectionIdentifier) setBadgeValue:@"BadgeSync"];
    }
    -(id)init {
        self = %orig;
        notifController = self;
        return self;
    }

%end

static void preferencesChanged() {
    NSUserDefaults* const prefs = [[NSUserDefaults alloc] initWithSuiteName:@"com.newwares.badgesyncprefs"];
	blacklist = [prefs objectForKey:@"enabledApps"]?:@[];
    NSLog(@"Blacklist: %@", blacklist);
}

%ctor {
    dlopen(ROOT_PATH("/Library/MobileSubstrate/DynamicLibraries/Axon.dylib"), RTLD_NOW);
    dlopen(ROOT_PATH("/Library/MobileSubstrate/DynamicLibraries/Tako.dylib"), RTLD_NOW);
    preferencesChanged();
    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)preferencesChanged, CFSTR("com.newwares.badgesyncprefs/ReloadPrefs"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
}


