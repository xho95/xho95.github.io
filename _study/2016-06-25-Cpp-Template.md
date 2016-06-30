## Template

* Template : C++에서 Generic Programming을 하기 위한 도구

### 개요

* `function` : 값의 파라미터화 - 어떤 값에 대해서도 계산, 예) `sort()`
* `template` : 타입의 파라미터화 - 값의 타입에도 독립적인 코드를 만듦

### Template Class

* template class
	* method 또는 method 파라미터의 타입이 템플릿 파라미터로 정의되는 클래스
	* 컨테이너나 데이터 구조 등 객체를 저장하는 기능을 구현할 때 유용
	* 인스턴스화(instantiate) : 사용자가 실제 사용할 때 타입을 지정

* 비-제네릭 게임 보드 클래스 : 예) `GameBoard`
	* GameBoard를 재사용하려면 특정 타입이 GamePiece로 부터 상속받아야 한다.
	
* 제네릭 게임 보드 클래스: 예) `Grid`
	* 어떤 타입의 게임 말도 올려놓을 수 있다. 
	* 사용 데이터 타입을 특정하게 확정하지 않고서도 클래스를 정의할 수 있다.

#### Grid 클래스 정의

```
template <typename T>
```

* 템플릿 클래스가 한 개의 타입에 대해 템플릿화되어 있다는 것을 의미
	* template, typename : C++ 표준 키워드
	* template 지정자는 전체 구문에 적용 - 클래스 정의구문 전체에 적용
	
* 템플릿 클래스
	* 클래스 이름 `Grid` : 템플릿 이름 
	* 실제 사용하는 Grid 클래스 : 템플릿 클래스 `Grid`를 특정 타입(`int`)으로 인스턴스화한 결과물 
	
	* 템플릿 파라미터 `T` : 템플릿을 정의하는 시점에는 어떤 타입일지 정의 되지 않았기 때문에 사용 - 어떤 타입이든 가능
	* 템플릿 Grid 타입 : `Grid<T>`
	
* 표기법	
	* 클래스 정의문 안에서는 컴파일러가 자동으로 `Grid`를 `Grid<T>`로 인식
	* 혼란을 줄이기 위해 `Grid<T>` 처럼 명시적으로 표기하는 것이 바람직
	* 생성자, 소멸자 이름은 `Grid` 처럼 해야 함
	
* method 정의
	* 각 method 구현부다마 `template <typename T>` 지정자가 맨 앞에 붙는다.
	* method 구현부 위치
		* 소스 파일이 아닌 헤더 파일에 있어야 한다. 
		* 템플릿 클래스를 인스턴스화하는 시점에 컴파일러가 구현부를 볼 수 있어야 한다.
	* method 또는 static 멤버 정의 : 클래스 이름은 `Grid<T>` 사용

#### Grid 템플릿 클래스 사용

* Grid 클래스만으로는 객체를 만들 수 없다. Grid에 저장될 항목의 타입을 지정해야 한다.
* 템플릿 인스턴스화 : template instantiation - 템플릿 클래스에 타입을 지정하여 객체를 생성하는 것

```
Grid<int> myIntGrid;
Grid<double> myDoubleGrid(11, 11);
    
myIntGrid.setElementAt(0, 0, 10);
int x = myIntGrid.getElementAt(0, 0);
    
Grid<int> grid2(myIntGrid);
Grid<int> anotherIntGrid = grid2;
```

* Grid<int> 타입 객체에 다른 타입 객체를 넣으려고 하면 컴파일 에러가 발생한다.

```
Grid test;
Grid<> test;
```

* 위의 코드들은 에러가 발생한다. : 정상적으로 타입이 지정되지 않았다.

* Grid 객체를 인자로 받는 다른 함수나 method도 항목 타입을 지정해야 한다.

```
void processIntGrid(Grid<int> & inGrid) {
	...
}
```

* 매번 일일이 템플릿 인자를 나열하는 것이 불편하면 `typedef`을 이용하면 된다.

```
typedef Grid<int> IntGrid;

void ProcessIntGrid(IntGrid & inGrid) {
	...
}
```

* Grid 템플릿은 임의의 타입을 넣을 수 있으며, 포인터를 저장하거나, 다른 템플릿 타입을 항목 타입으로 지정하는 것도 가능하다.

```
Grid<char *> myStringGrid;

myStringGrid.setElementAt(2, 2, "hello");

Grid<vector<int>> gridOfVectors;

vector<int> myVector;
gridOfVectors.setElementAt(5, 6, myVector);
```

* 인스턴스화된 Grid 타입 객체를 동적으로 힙에 생성할 수도 있다.

```
Grid<int> * myGridp = new Grid<int>();
    
myGridp->setElementAt(0, 0, 10);
int y = myGridp->getElementAt(0, 0);
    
delete myGridp;
```

#### 컴파일러의 역할

* 템플릿 method 정의를 만나면 문법 검사만 하고 컴파일은 하지 않는다. : 타입에 대한 정의 없이는 코드 생성을 할 수 없다.
* `Grid<int> myIntGrid` 같은 템플릿 인스턴스화 코드를 만나면 `T`를 `int`로 바꾼 새로운 클래스 정의 코드를 생성한다.
* 템플릿 클래스를 정의만 하고 인스턴스화하지 않으면 컴파일 자체를 하지 않는다.

* `Grid<T>` 같이 매번 템플릿 파라미터를 명시하는 이유는 이런 과정 때문이다.

* 컴파일러는 타입이 지정된 클래스 method 중에서 실제로 호출이 되는 것만 컴파일한다.

#### 템플릿에 사용되는 타입의 요구 조건

* 템플릿에 사용되는 타입이 만족해야 하는 조건들이 있다.
* `Grid` 템플릿의 경우 항목에 들어갈 타입이 대입 연산자를 지원해야 한다.

```
mCells[x][y] = inElem;
```

* 배열 생성 코드는 항목에 들어갈 타입이 default 생성자를 지원하고 있다고 가정한다.

```
mCells = new T * [mWidth];
```

* 템플릿을 인스턴스화할 때 지정된 타입이 템플릿 코드에서 요구하는 동작을 지원하지 않으면 컴파일 에러가 난다. 이 때 발생하는 에러는 굉장히 난해하다.

* 실제 사용하는 코드만 인스턴스화하는 템플릿 특성을 활용해서 컴파일 에러없이 템플릿을 이용할 수도 있다. 

#### 템플릿 코드를 작성하는 요령

* 헤더 파일에 넣기 : 작성된 예문
* 다른 헤더 파일에 넣고 include

```
template <typename T>

class Grid {
};

#include "GridDefinitions.hpp"
```

* 소스 코드에 넣고 include

```
template <typename T>

class Grid {
};

#include "GridDefinitions.cpp"
```

* 주의사항 : 소스 파일은 자동 컴파일이 안되도록 해야 한다.

#### 템플릿 클래스의 특수화

* 템플릿 특수화 : template speciailization - 특정 타입에 대해서만 특별한 템플릿 클래스 정의를 사용하도록 할 수 있다.
	* 해당 클래스가 템플릿이라는 점과 어떤 타입에 대한 특수화인지를 지정해야 한다.
	
```
template <>
class Grid<char *>
``` 

* 특수화는 일반화된 버전보다 앞에 정의되어야 하는데 그러려면 템플릿 클래스 선언부가 필요하다. 전체 흐름은 아래와 같다.

```
// 템플릿 클래스 선언
template <typename T>
class Grid;

// 템플릿 클래스 특수화
template <>
class Grid<char *> {
    //...
};

template <typename T>
class Grid {
	// ...
};
```


### 참고 자료

* Professional C++, 2nd Edition, 2011, Marc Gregoire, Nicholas A. Solter, Scott J. Kleper, John Wiley & Sons, Inc.
* 전문가를 위한 C++, 2013, 권오인 옮김, 한빛미디어::