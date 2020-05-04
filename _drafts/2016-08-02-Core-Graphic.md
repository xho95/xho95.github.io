### CoreGraphics

#### UIGraphicsGetCurrentContext()
 CoreGraphic 함수를 이용해서 그림을 그릴려면, 아래와 같이 위의 함수를 이용하여 context를 구하고, 이 context에 그려야 한다.  

 ```
let context = UIGraphicsGetCurrentContext() ```


반면, 보통의 UI 함수들을 이용하여 그림을 그리는 것은 UIview 의 drawRect 에서 제공하는, rect 인자에 바로 그림을 그릴 수 있다.
어쨌든, CoreGraphic 프레임웍이 UI 프레임웍 보다 저수준의 인터페이스를 제공한다고 할 수 있다.
