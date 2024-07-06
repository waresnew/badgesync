# BadgeSync

Syncs icon badge values when you dismiss notifications from the notification center!

Normally, dismissing a notification will keep the badge value the same, requiring you to manually open and close the app to clear its badge count. With this tweak, if you clear 1 notification, the badge value will decrease by 1; if you clear all notifications for an app, then its badge will disappear.

This way, you can manage your notifications solely from the notification center without needing to manually clear your badges as well.

Supports tapping the "Clear" button, swiping left to clear, and clearing all notifications in a group.

### Usage

Just install it and it'll work!

https://github.com/waresnew/badgesync/assets/45801973/3a772e64-3f96-421b-8c74-f389962bf1e0

### Limitations

- For some apps such as iMessage and Gmail, if you clear notifications from the notification center, re-open the app, leave the messages/emails unread, and return to the homescreen, then the badge value will revert.
    - This probably requires specific logic for each app to mark messages as read, which would be infeasible since there are so many apps.

### Bugs

If you encounter any bugs, feel free to open an [issue](https://github.com/waresnew/badgesync/issues).

If you found this tweak useful, please give it a star on its [Github repo](https://github.com/waresnew/badgesync)!

