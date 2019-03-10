
#if __has_include("RCTBridgeModule.h")
#import "RCTBridgeModule.h"
#else
#import <React/RCTBridgeModule.h>
#endif
#import <UIKit/UIKit.h>

@interface RNPayment : NSObject <RCTBridgeModule>

//支付宝在appdelegate 中的回调
+ (void)application:(UIApplication *)application handleOpenURL:(NSURL *)url;

@end
  
