#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface PLPlatterActionButton : UIControl
@end

%hook PLPlatterActionButton
    - (void)sendAction:(id)arg1 {
        NSMutableArray* targetActions = MSHookIvar<NSMutableArray*>(self, "_targetActions");
        if (targetActions.count > 0) {
            id targetAction = targetActions[0];
            UIAction* handler = MSHookIvar<UIAction*>(targetAction, "_actionHandler");
            if ([handler.title isEqualToString:@"Clear"]) {
                NSLog(@"Clear Button pressed");
            }
        } else {
            NSLog(@"Button pressed");
        }

        %orig;
        
    }
%end