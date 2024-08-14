<p align="center">
  <img src="https://github.com/user-attachments/assets/7c1dfd00-1608-4517-b586-6b457e9abe41" width="128px" height="128px">
</p>
<h1 align="center">BadgeSync</h1>

[<img src="https://docs.havoc.app/img/badges/get_square.png" width=15% height=15%>](https://havoc.app/package/badgesync)


Syncs icon badge values when you dismiss notifications from the notification center!

Normally, dismissing a notification will keep the badge value the same, requiring you to manually open and close the app to clear its badge count. With this tweak, when you dismiss a notification, the badge count automatically updates to reflect the remaining notifications.

> eg. You have 5 iMessage notifications so the badge for iMessage is at 5. If you clear 1 notification from iMessage, then the badge value becomes 4 (and so on).

This way, you can manage your notifications solely from the notification center without needing to manually clear your badges as well.

Supports tapping the "Clear" button, swiping left to clear, and clearing all notifications in a group.

### Usage

Just install it and it'll work!

https://github.com/waresnew/badgesync/assets/45801973/3a772e64-3f96-421b-8c74-f389962bf1e0

### Caveat for Some Users

This tweak aims to keep the badge count synced with the notification center. That means if you have a high badge count from an app prior to installing the tweak, the next notification you receive from that app will adjust the badge count to match the notifications currently in the notification center.

If you like having a high badge count, you can uninstall the tweak and it'll be restored.

> eg. You have an app that has accumlated a high badge count (let's say 1000) prior to installing this tweak, but there are no notifications from it in the notification centre (because they were dismissed without syncing)

> Once you install this tweak and you receive another notification from that app, it'll reset to 1. If you uninstall this tweak, then it'll restore the original badge count of 1000.

### Bugs

If you encounter any bugs, feel free to open an [issue](https://github.com/waresnew/badgesync/issues).

If you found this tweak useful, please give it a star on its [Github repo](https://github.com/waresnew/badgesync)!

