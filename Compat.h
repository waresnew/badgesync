#import <Shared.h>

@interface AXNRequestWrapper
@property (nonatomic, strong) NCNotificationRequest* request;
@end

@interface AXNManager //axon compat
@property (nonatomic, retain) NSMutableDictionary *notificationRequests;
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
