# BadgeSync

Jailbreak tweak that syncs icon badge values when you dismiss notifications from the notification centre.

### Purpose
Normally, dismissing a notification will keep the badge value the same, requiring you to manually open and close the app to clear its badge count. With this tweak, if you clear 1 notification, the badge value will decrease by 1; if you clear all notifications for an app, then its badge will disappear.

This way, you can manage your notifications solely from the notification center without needing to manually clear your badges as well.

Supports tapping the "Clear" button, swiping left to clear, and clearing all notifications in a group.

![](image.png)

### Compatibility

This has only been tested on iOS 16.x rootless + arm64e, as that is the only device I have. However, if enough people want support for other versions/jailbreaks, then I may add support.

### Limitations

- For some apps such as iMessage and Gmail, if you clear notifications from the notification centre, re-open the app, leave the messages/emails unread, and return to the homescreen, then the badge value will revert.
    - This probably requires specific logic for each app to mark messages as read, which would be infeasible since there are so many apps.