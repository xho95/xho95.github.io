C# 의 WriteLine 메소드에서 여러 변수를 출력하려면 `{}` 형식을 사용합니다. Swift 의 String Interpolation 과 아주 유사한 것 같습니다.

괄호 사이에는 목록에 있는 변수의 순서에 해당하는 숫자를 입력하면 됩니다. 

아래에 예를 나타내었습니다. 

```
// Bool
bool b = true;

// Numeric
short sh = -32768;

// DateTime 2011-10-30 12:35
DateTime dt = new DateTime(2011, 10, 30, 12, 35, 0);

Console.WriteLine("{0}, {1}, {2}", b, sh, dt);
```