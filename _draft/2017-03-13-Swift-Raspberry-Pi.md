### 들어가며

Raspberry Pi 에서 Swift 를 사용할 수 있는 방법을 정리한 글입니다.

### OS 설치

[라즈베리파이: Raspberry Pi 라즈비안 설치하기 (맥 OS)](http://ljs93kr.tistory.com/35)

[맥에서 라즈베리 파이 3 사용하기 (Start using Raspberry Pi 3 in Mac OS X)](http://arsviator.blogspot.kr/2016/04/3-start-using-raspberry-pi-3-in-mac-os-x.html)

### Raspbian 에서 Swift 사용하기

#### Claudio Carnino

Claudio Carnino 님이 [Setup Swift 3.0 on a Raspberry Pi 2/3 with a headless Raspbian. Step-by-step](https://medium.com/a-swift-misadventure/setup-swift-3-0-on-a-raspberry-pi-2-3-with-a-headless-raspbian-step-by-step-384d8bb5aed4#.g0eua4dp6) 라는 좋은 글을 시리즈로 정리한 것이 있습니다. 

* [Setup your Raspberry Pi 2/3 with Raspbian headless (without cables)](https://medium.com/a-swift-misadventure/setup-your-raspberry-pi-2-3-with-raspbian-headless-without-cables-c78309fd7045#.mepsyiwiv)
* [Installing Swift 3.0 preview on a Raspberry Pi 2/3 with Raspbian](https://medium.com/a-swift-misadventure/installing-swift-3-0-preview-on-a-raspberry-pi-2-3-with-raspbian-3e857fa995d9#.7pts5e8pn)
* [Using Swift to control the Raspberry Pi GPIO pins and turn an LED on](https://medium.com/a-swift-misadventure/using-swift-to-control-the-raspberry-pi-gpio-pins-and-turn-an-led-on-f31e33c3cb9a#.kig6fjndl)

#### Joe

Joe 님이 [Swift 3.0 on Raspberry Pi 2 and 3](http://dev.iachieved.it/iachievedit/swift-3-0-on-raspberry-pi-2-and-3/) 라는 글도 작성해 둔것이 있습니다. 위의 글과 비교해서 사용해보면 될 것 같습니다.

#### Cameron Perry

[Accessing Raspberry Pi GPIO Pins (With Swift)](http://mistercameron.com/2016/06/accessing-raspberry-pi-gpio-pins-with-swift/) 는 아래에 있는 GPIO 패키지에서 소개하고 있는 글입니다. 각각이 얼마나 다른지는 확인이 필요합니다.

#### 기타 

[Swift 3.0 on Raspberry Pi! Hello Swifty World - Part 1](https://www.hackster.io/the-swiftpi-team/swift-3-0-on-raspberry-pi-hello-swifty-world-part-1-624e1c)

### GPIO 패키지

[uraimo/SwiftyGPIO](https://github.com/uraimo/SwiftyGPIO) : A Swift library to interact with Linux GPIOs/SPI/PWM
