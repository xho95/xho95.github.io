Visual Studio 를 사용할 때는 솔루션의 이름을 신중하게 결정해야 합니다. 예를 들어서 아래에서는 솔루션의 이름을 Console 이라고 정한 경우입니다. 

```
using System;

namespace Console
{
	class MainClass
	{
		public static void Main(string[] args)
		{
			Console.WriteLine("Hello World!");
		}
	}
}
```

위와 같은 코드는 아래와 같은 에러를 발생합니다. 

```
/Users/kimminho/Documents/C#_Works/Console/Console/Program.cs(4,4): Error CS0234: The type or namespace name 'WriteLine' does not exist in the namespace 'Console' (are you missing an assembly reference?) (CS0234) (Console)
```

이것은 솔루션의 이름인 **Console** 이 C# 내에 이미 존재하는 클래스의 이름과 동일하기 때문입니다. 따라서 현재의 Console 에는 WriteLine 이 없다는 에러가 뜹니다. 

이를 해결하려면 아래와 같이 Console 이 속한 namespace 를 지정해주면 됩니다.

```
System.Console.WriteLine("Hello World!");
```

하지만 이보다는 결국 솔루션의 이름을 **Console** 이외의 것으로 정하는 것이 더 바람직합니다.