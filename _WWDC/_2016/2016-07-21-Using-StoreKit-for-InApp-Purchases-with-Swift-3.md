## Using Store Kit for In-App Purchases with Swift 3

WWDC 2016의 Using Store Kit for In-App Purchases with Swift 3 영상을 보고 정리한 글입니다.[^2016_702]

### StoreKit

* APIs in Swift : new
* Subscriptions
* iMessage Apps : support In-App Purchases

#### Subsriptions

* categories

### In-App Purchase Overview

#### Types

* consumable
* non-consumable

#### Implementing

### In-App Purchase Process

* Load In-App Identifiers
* Fetch Product Info
* Show In-App UI
* Make Purchase
* Process Transaction
* Make Asset Available
* Finish Transaction

#### The Payment Queue

* The center of In-App Purchase implementation
* `SKPaymentQueue` (?)

### Load In-App Identifiers

* options for storing the list 

### Fetch Product Info

* `SKProductsRequest`

* 중간에 몇 단계는 말로 설명하고 끝난 것 같습니다.

#### Testing Deferred Transactions

```
let payment = SKMutablePayment(product: product)

payment.simulatesAskToBuyInSandbox = true
```

#### Handling Errors

* User canceling a payment will result in an error

#### Receipt Validation

* On-device validation
* Server-to-server validation

* Do not use online validation directly from the device!

#### The Receipt

#### The Basics

* Stored in the App Bundle
* Single file
	* APN.1 

#### Getting Started

* NSBundle API

```
let url NSBundle.main().appStoreReceiptURL!

let receipt = NSData(contentsOf: url)
```

#### Verification

* Do not check the expiry date on the certificate

* Do evaluate trust up to Root CA

#### Receipt Payload

* Series of attributes : 참고자료에 있는 그림을 볼 필요가 있습니다!

#### Verify Application

* Use hardcoded values : not `info.plist` values

#### Verify Device

* `SHA-1` hash : 참고자료에 있는 그림을 볼 필요가 있습니다!

#### Switching to Subscriptions

* 이 부근 전후로 아직 잘 모르겠습니다.

#### Transaction Lifecycle 

#### Receipt Refresh on iOS

* `SKReceiptRefreshRequest`

#### Receipt Refresh on macOS

* `exit(173)`

#### Server-to-server validation

* Response is in JSON

### Make Asset Available

#### On-Demand Resources

* Optimizing On-Demand Resources[^Other]

#### Hosted

* Downloads in background
* Up to 2GB

#### Self-Hosted Content

### Finish the Transaction

```
SKPaymentQueue.defaultQueue().finishTransaction(transaction)
```

### Restore Completed Transactions

```
SKPaymentQueue.defaultQueue().restoreCompletedTransactions()
```

#### Restore Button

### Summary

* Always observe the Payment Queue
* Fetch localized product information 


### 관련 영상 : 실제 추가되는 위치로 옮기자

* Introducing Expanded Subscriptions in iTunes Connect[^Some]

### 참고 자료

[^2016_702]: [WWDC 2016 702: Using Store Kit for In-App Purchases with Swift 3](https://developer.apple.com/videos/play/wwdc2016/702/)

[^Some]: [Introducing Expanded Subscriptions in iTunes Connect]()

[^Other]: [Optimizing On-Demand Resources]()