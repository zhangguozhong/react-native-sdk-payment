import { NativeModules } from 'react-native';
const { RNPayment } = NativeModules;

export default class UtilsPayment {

    static onPay(type,orderInfo,appScheme,successCallback,failureCallback) {
        RNPayment.onPay(type,orderInfo,appScheme,successCallback,failureCallback);
    }
}
