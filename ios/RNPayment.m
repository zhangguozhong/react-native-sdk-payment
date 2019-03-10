
#import "RNPayment.h"
#import <AlipaySDK/AlipaySDK.h>

@interface RNPayment ()
@property(nonatomic,copy) RCTResponseSenderBlock successCallback;
@property(nonatomic,copy) RCTResponseSenderBlock failureCallback;
@end

@implementation RNPayment

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+ (instancetype)shareInstance {
    static RNPayment *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!instance) {
            instance = [[self alloc] init];
        }
    });
    return instance;
}
RCT_EXPORT_MODULE()


/**
 支付
 @param NSInteger type 1:支付宝 2:微信 orderInfo:订单参数
 */
RCT_EXPORT_METHOD(onPay:(NSInteger)type orderInfo:(NSDictionary *)orderInfo appScheme:(NSString *)appScheme successCallback:(RCTResponseSenderBlock)successCallback failureCallback:(RCTResponseSenderBlock)failureCallback) {
    RNPayment *payment = [RNPayment shareInstance];
    payment.successCallback = successCallback;
    payment.failureCallback = failureCallback;
    
    if(type == 1) {
        if(appScheme) {
            // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
            NSString *orderString = [orderInfo objectForKey:@"order"];
            // NOTE: 调用支付结果开始支付
            [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                [RNPayment aliPayCallBack:resultDic];
            }];
        }
    }else if(type==2) {
        
    }
}


/**
 支付回调
 @param resultDic resultStatus参考支付宝文档
 */
+(void)aliPayCallBack:(NSDictionary *)resultDic {
    NSInteger resultStatus = [[resultDic objectForKey:@"resultStatus"] integerValue];
    if(resultStatus == 9000 || resultStatus == 8000 || resultStatus == 6004){
        RNPayment *payment = [RNPayment shareInstance];
        if(payment.successCallback){
            payment.successCallback(@[resultDic]);
        }
    }else{
        RNPayment *payment = [RNPayment shareInstance];
        if(payment.failureCallback){
            payment.failureCallback(@[resultDic]);
        }
    }
}

+ (void)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            [RNPayment aliPayCallBack:resultDic];
        }];
    }
}

@end
  
