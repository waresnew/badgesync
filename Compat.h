#import <Shared.h>

@interface AXNManager //axon compat
+(instancetype)sharedInstance;
-(void)insertNotificationRequest:(id)req;
-(void)removeNotificationRequest:(id)req;
-(void)modifyNotificationRequest:(id)req;
@end

@interface TKOBundle
@property(nonatomic, retain) NSMutableArray<NCNotificationRequest*>* notifications;
@end

@interface TKOController //tako compat
@property(nonatomic, retain) NSMutableArray<TKOBundle*>* bundles;
+(instancetype)sharedInstance;
-(void)insertNotificationRequest:(id)req;
-(void)removeNotificationRequest:(id)req;
-(void)modifyNotificationRequest:(id)req;
@end
