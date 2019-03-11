import { NativeModules } from 'react-native';
const { RNPayment } = NativeModules;

export default class PaymentSdk {

    static onPay(type,orderInfo,appScheme,successCallback,failureCallback) {
        RNPayment.onPay(type,orderInfo,appScheme,successCallback,failureCallback);
    }
}
