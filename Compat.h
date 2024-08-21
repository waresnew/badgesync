#import <Shared.h>
@interface AXNManager //axon compat
+(instancetype)sharedInstance;
-(void)insertNotificationRequest:(id)req;
-(void)removeNotificationRequest:(id)req;
-(void)modifyNotificationRequest:(id)req;
@end