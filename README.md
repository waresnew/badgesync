# BadgeSync

Jailbreak tweak that decrements icon badge values when you clear notifications from the notification centre.

Supports tapping the "clear" button, swiping left to clear, and clearing all notifications.

![](image.png)

### Compatibility

This has only been tested on iOS 16.x rootless + arm64e, as that is the only device I have. However, if enough people want support for other versions/jailbreaks, then I may add support.

### Limitations

- For some apps such as iMessage and Gmail, if you clear notifications from the notification centre, re-open the app, leave the messages/emails unread, and return to the homescreen, then the badge value will revert.
    - This probably requires specific logic for each app to mark messages as read, which would be infeasible since there are so many apps.