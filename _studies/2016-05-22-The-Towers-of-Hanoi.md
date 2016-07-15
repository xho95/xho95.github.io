### The Towers of Hanoi 

* 재귀 함수를 사용하면 엄청 편해진다!! : **C++ Eraly Objects, 8th Edition** 책 참고

### Exhaustive and Enumeration Algorithms

* 정해진 단위의 돈의 조합으로 거슬러 줄 수 있는 가지 수를 계산하는 방법
	* 예) 1, 5, 10, 25, 50, 100달러 일 경우에 11달러를 거슬러 줄 수 있는 방법 = 4가지 (1 * 11, 1 * 6 + 5 * 1, 1 + 5 * 2, 1 + 10)
	
* 재귀호출은 반복문을 모두 대체할 수 있다.
	* 예) Haskell : 반복문이 없다. 
 
### Infix and Prefix Expressions

* 따로 공부를 해보자! - 계산기 만들 때 도움이 될 수 있다.

* 2 + 3 * 5

* operator+(2, 3) : 역전 현상

* test(2, 3)

* Prefix Operation이 더 좋다(?) - 함수형 언어에서 적극 활용
* 그러면, operation을 자기 마음대로 만들수 있음

* Haskell : ^-^ 2 3 - emotion operator

* C++의 경우 int operator+(int a, int b) {...} 가 안된다. - operator+의 경우 하나의 인자가 사용자 타입 class 이어야 한다. (기존 문법과의 호환을 위해서 고정한 듯 하다.) - operator 이름에도 제약이 있다.




