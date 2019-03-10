package com.library.pay;

import android.util.Log;

import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.ReadableMap;
import com.library.pay.alipay.AliPayment;

public class RNPaymentModule extends ReactContextBaseJavaModule {

  private final ReactApplicationContext reactContext;

  public RNPaymentModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
  }

  @Override
  public String getName() {
    return "RNPayment";
  }

  @ReactMethod
  public void onPay(int id, ReadableMap orderInfo, final String appScheme, final Callback suc, final Callback fail) {

    Log.i("onAliPay","onAliPay-->"+orderInfo);
    if (orderInfo != null && suc != null && fail != null) {

      AliPayment aliPay = new AliPayment(getCurrentActivity());
      aliPay.pay(orderInfo,new PayListener() {
        @Override
        public void onPaySuccess(String resultInfo) {
          suc.invoke(resultInfo);
        }
        @Override
        public void onPayFail(String code,String resultInfo) {
          fail.invoke(resultInfo);
        }
        @Override
        public void onPayConfirm(String resultInfo) {}
      },fail);
    }
  }
}