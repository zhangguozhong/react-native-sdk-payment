
# react-native-sdk-payment

## Getting started

`$ npm install react-native-sdk-payment --save`

### Mostly automatic installation

`$ react-native react-native-sdk-payment`

### Manual installation

配置请参考支付宝开放文档

#### iOS

1. In XCode, in the project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `react-native-sdk-payment` and add `RNPayment.xcodeproj`
3. In XCode, in the project navigator, select your project. Add `libRNPayment.a`,`AlipaySDK.framework` to your project's `Build Phases` ➜ `Link Binary With Libraries`
4. In XCode, in the project navigator, select your project. Add `$(SRCROOT)/../node_modules/react-native-sdk-payment/ios/PaySdk` to your project's `Build Settings` ➜ `Framework Search Paths`
5. Run your project (`Cmd+R`)<

#### Android

1. Open up `android/app/src/main/java/[...]/MainActivity.java`
  - Add `import com.library.pay.RNPaymentPackage;` to the imports at the top of the file
  - Add `new RNPaymentPackage()` to the list returned by the `getPackages()` method
2. Append the following lines to `android/settings.gradle`:
  	```
  	include ':react-native-sdk-payment'
  	project(':react-native-sdk-payment').projectDir = new File(rootProject.projectDir, 	'../node_modules/react-native-sdk-payment/android')
  	```
3. Insert the following lines inside the dependencies block in `android/app/build.gradle`:
  	```
      compile project(':react-native-sdk-payment')
  	```

## Usage
```javascript
import PaymentSDK from 'react-native-sdk-payment';

PaymentSDK.onPay(1,{ order:'123' },'appScheme',()=> {
    console.log('成功回调');
},() => {
    console.log('失败回调');
});

```
  
