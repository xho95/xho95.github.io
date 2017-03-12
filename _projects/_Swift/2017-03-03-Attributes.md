## 특성 (Attributes)

특성 (Attributes) 은 선언 구문이나 타입에 대해 더 많은 정보를 제공합니다. [^attribute] Swift 에는 두 가지 종류의 특성이 있는데 하나는 선언 구문에 적용되는 것이고 다른 하나는 타입에 적용되는 것입니다. [^declaration]

특성을 지정하려면 `@` 기호를 쓰고 뒤이어 특성의 이름과 특성이 받아들이는 인자를 쓰면 됩니다.

@`attribute name`  
@`attribute name`(`attribute arguments`)

몇몇 선언 특성들은 특성 인자를 받아서 특성에 대해 더 많은 정보를 지정하거나 특정한 선언 구문에 적용하는 방법을 알려줍니다. 이들 속성 인자는 괄호로 감싸며 포맷은 그들이 속한 특성에서 정의됩니다. [^format]

### 선언 특성 (Declaration Attributes)

선언 특성은 선언 구문에만 적용할 수 있습니다.

* `available`

	Apply this attribute to indicate a declaration’s lifecycle relative to certain Swift language versions or certain platforms and operating system versions. [^lifecycle]

	The `available` attribute always appears with a list of two or more comma-separated attribute arguments. These arguments begin with one of the following platform or language names:
	
	* `iOS`
	* `iOSApplicationExtension`
	* `macOS`
	* `macOSApplicationExtension`
	* `watchOS`
	* `watchOSApplicationExtension`
	* `tvOS`
	* `tvOSApplicationExtension`
	* `swift`

	You can also use an asterisk (`*`) to indicate the availability of the declaration on all of the platform names listed above. An `available` attribute specifying a Swift version availability can’t use the asterisk.

	The remaining arguments can appear in any order and specify additional information about the declaration’s lifecycle, including important milestones.

	* The `unavailable` argument indicates that the declaration isn’t available on the specified platform. This argument can’t be used when specifying Swift version availability.
	
	* The `introduced` argument indicates the first version of the specified platform or language in which the declaration was introduced. It has the following form:
		
		```
		introduced: version number
		```
		
		The version number consists of one to three positive integers, separated by periods.
		
	* The `deprecated` argument indicates the first version of the specified platform or language in which the declaration was deprecated. It has the following form:
		
		```
		deprecated: version number
		```
		The optional version number consists of one to three positive integers, separated by periods. Omitting the version number indicates that the declaration is currently deprecated, without giving any information about when the deprecation occurred. If you omit the version number, omit the colon (`:`) as well.
		
	* The `obsoleted` argument indicates the first version of the specified platform or language in which the declaration was obsoleted. When a declaration is obsoleted, it’s removed from the specified platform or language and can no longer be used. It has the following form:
		
		```
		obsoleted: version number
		```
		
		The version number consists of one to three positive integers, separated by periods.
		
	* The `message` argument is used to provide a textual message that’s displayed by the compiler when emitting a warning or error about the use of a deprecated or obsoleted declaration. It has the following form:
		
		```
		message: message
		```
		
		The message consists of a string literal.

	* The `renamed` argument is used to provide a textual message that indicates the new name for a declaration that’s been renamed. The new name is displayed by the compiler when emitting an error about the use of a renamed declaration. It has the following form:
		
		```
		renamed: new name
		```
		
		The new name consists of a string literal.

		You can use the `renamed` argument in conjunction with the `unavailable` argument and a type alias declaration to indicate to clients of your code that a declaration has been renamed. For example, this is useful when the name of a declaration is changed between releases of a framework or library.

		```
		// First release
		protocol MyProtocol {
    		// protocol definition
		}
		```
		```
		// Subsequent release renames MyProtocol
		protocol MyRenamedProtocol {
    		// protocol definition
		}
		
		@available(*, unavailable, renamed: "MyRenamedProtocol")
		typealias MyProtocol = MyRenamedProtocol
		```
		
	You can apply multiple `available` attributes on a single declaration to specify the declaration’s availability on different platforms and different versions of Swift. The declaration that the `available` attribute applies to is ignored if the attribute specifies a platform or language version that doesn’t match the current target. If you use multiple `available` attributes the effective availability is the combination of the platform and Swift availabilities.

	If an `available` attribute only specifies an `introduced` argument in addition to a platform or language name argument, the following shorthand syntax can be used instead:

	@available(`platform name` `version number`, *)
	@available(swift `version number`)

	The shorthand syntax for `available` attributes allows for availability for multiple platforms to be expressed concisely. Although the two forms are functionally equivalent, the shorthand form is preferred whenever possible.

	```
	@available(iOS 10.0, macOS 10.12, *)
	class MyClass {
    	// class definition
	}
	```
	
	An `available` attribute specifying a Swift version availability can’t additionally specify a declaration’s platform availability. Instead, use separate `available` attributes to specify a Swift version availability and one or more platform availabilities.

	```
	@available(swift 3.0.2)
	@available(macOS 10.12, *)
	struct MyStruct {
    	// struct definition
	}
	```
	
* `discardableResult`

	Apply this attribute to a function or method declaration to suppress the compiler warning when the function or method that returns a value is called without using its result.

* `GKInspectable`

	Apply this attribute to expose a custom GameplayKit component property to the SpriteKit editor UI.

* `objc`

	Apply this attribute to any declaration that can be represented in Objective-C—for example, non-nested classes, protocols, nongeneric enumerations (constrained to integer raw-value types), properties and methods (including getters and setters) of classes and protocols, initializers, deinitializers, and subscripts. The `objc` attribute tells the compiler that a declaration is available to use in Objective-C code.

	Classes marked with the `objc` attribute must inherit from a class defined in Objective-C. If you apply the `objc` attribute to a class or protocol, it’s implicitly applied to the Objective-C compatible members of that class or protocol. The compiler also implicitly adds the `objc` attribute to a class that inherits from another class marked with the `objc` attribute or a class defined in Objective-C. Protocols marked with the `objc` attribute can’t inherit from protocols that aren’t.

	If you apply the `objc` attribute to an enumeration, each enumeration case is exposed to Objective-C code as the concatenation of the enumeration name and the case name. The first letter of the case name is capitalized. For example, a case named `venus` in a Swift `Planet` enumeration is exposed to Objective-C code as a case named `PlanetVenus`.

	The `objc` attribute optionally accepts a single attribute argument, which consists of an identifier. Use this attribute when you want to expose a different name to Objective-C for the entity the `objc` attribute applies to. You can use this argument to name classes, enumerations, enumeration cases, protocols, methods, getters, setters, and initializers. The example below exposes the getter for the `enabled` property of the `ExampleClass` to Objective-C code as `isEnabled` rather than just as the name of the property itself.

	```
	@objc
	class ExampleClass: NSObject {
    	var enabled: Bool {
        	@objc(isEnabled) get {
            	// Return the appropriate value
        	}
    	}
	}
	```
	
* `nonobjc`

	Apply this attribute to a method, property, subscript, or initializer declaration to suppress an implicit `objc` attribute. The `nonobjc` attribute tells the compiler to make the declaration unavailable in Objective-C code, even though it is possible to represent it in Objective-C.

	You use the `nonobjc` attribute to resolve circularity for bridging methods in a class marked with the `objc` attribute, and to allow overloading of methods and initializers in a class marked with the `objc` attribute.

	A method marked with the `nonobjc` attribute cannot override a method marked with the `objc` attribute. However, a method marked with the `objc` attribute can override a method marked with the `nonobjc` attribute. Similarly, a method marked with the `nonobjc` attribute cannot satisfy a protocol requirement for a method marked with the `objc` attribute.

* `NSApplicationMain`

	Apply this attribute to a class to indicate that it is the application delegate. Using this attribute is equivalent to calling the `NSApplicationMain(_:_:)` function.

	If you do not use this attribute, supply a **main.swift** file with code at the top level that calls the `NSApplicationMain(_:_:)` function as follows:

	```
	import AppKit
	NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
	```
	
* `NSCopying`

	Apply this attribute to a stored variable property of a class. This attribute causes the property’s setter to be synthesized with a copy of the property’s value—returned by the `copyWithZone(_:)` method—instead of the value of the property itself. The type of the property must conform to the `NSCopying` protocol.

	The `NSCopying` attribute behaves in a way similar to the Objective-C `copy` property attribute.

* `NSManaged`

	Apply this attribute to an instance method or stored variable property of a class that inherits from `NSManagedObject` to indicate that Core Data dynamically provides its implementation at runtime, based on the associated entity description. For a property marked with the `NSManaged` attribute, Core Data also provides the storage at runtime. Applying this attribute also implies the `objc` attribute.

* `testable`

	Apply this attribute to `import` declarations for modules compiled with testing enabled to access any entities marked with the `internal` access-level modifier as if they were declared with the `public` access-level modifier. Tests can also access classes and class members that are marked with the `internal` or `public` access-level modifier as if they were declared with the `open` access-level modifier.

* `UIApplicationMain`

	Apply this attribute to a class to indicate that it is the application delegate. Using this attribute is equivalent to calling the `UIApplicationMain` function and passing this class’s name as the name of the delegate class.

	If you do not use this attribute, supply a **main.swift** file with code at the top level that calls the `UIApplicationMain(_:_:_:)` function. For example, if your app uses a custom subclass of `UIApplication` as its principal class, call the `UIApplicationMain(_:_:_:)` function instead of using this attribute.

#### Declaration Attributes Used by Interface Builder

Interface Builder attributes are declaration attributes used by Interface Builder to synchronize with Xcode. Swift provides the following Interface Builder attributes: `IBAction`, `IBOutlet`, `IBDesignable`, and `IBInspectable`. These attributes are conceptually the same as their Objective-C counterparts.

You apply the `IBOutlet` and `IBInspectable` attributes to property declarations of a class. You apply the `IBAction` attribute to method declarations of a class and the `IBDesignable` attribute to class declarations.

Both the `IBAction` and `IBOutlet` attributes imply the `objc` attribute.

### Type Attributes

You can apply type attributes to types only.

* `autoclosure`

	This attribute is used to delay the evaluation of an expression by automatically wrapping that expression in a closure with no arguments. Apply this attribute to a parameter’s type in a method or function declaration, for a parameter of a function type that takes no arguments and that returns a value of the type of the expression. For an example of how to use the `autoclosure` attribute, see [Autoclosures]() and [Function Type]().

* `convention`

	Apply this attribute to the type of a function to indicate its calling conventions.

	The `convention` attribute always appears with one of the attribute arguments below.

	* The `swift` argument is used to indicate a Swift function reference. This is the standard calling convention for function values in Swift.
	* The `block` argument is used to indicate an Objective-C compatible block reference. The function value is represented as a reference to the block object, which is an id-compatible Objective-C object that embeds its invocation function within the object. The invocation function uses the C calling convention.
	* The `c` argument is used to indicate a C function reference. The function value carries no context and uses the C calling convention.

	A function with C function calling conventions can be used as a function with Objective-C block calling conventions, and a function with Objective-C block calling conventions can be used as a function with Swift function calling conventions. However, only nongeneric global functions, and local functions or closures that don’t capture any local variables, can be used as a function with C function calling conventions.

* `escaping`

	Apply this attribute to a parameter’s type in a method or function declaration to indicate that the parameter’s value can be stored for later execution. This means that the value is allowed to outlive the lifetime of the call. Function type parameters with the `escaping` type attribute require explicit use of `self`. for properties or methods. For an example of how to use the `escaping` attribute, see [Escaping Closures]().

> GRAMMAR OF AN ATTRIBUTE
> 
> attribute → @­ attribute-name ­attribute-argument-clause­ <sub>opt</sub>­  
> attribute-name → identifier­  
> attribute-argument-clause → (­ balanced-tokens <sub>­opt</sub> ­)­  
> attributes → attribute­attributes­ <sub>opt</sub>­ ­  
> 
> balanced-tokens → balanced-token­balanced-tokens <sub>­opt­</sub>­   
> balanced-token → (­ balanced-tokens <sub>­opt­</sub>­ )­  
> balanced-token → [­ balanced-tokens <sub>­opt­</sub>­ ]­  
> balanced-token → {­ balanced-tokens <sub>­opt­</sub>­ }­  
> balanced-token → Any identifier, keyword, literal, or operator  
> balanced-token → Any punctuation except (­, )­, [­, ]­, {­, or }­  

### 참고 자료

[^attribute]: 'attribute' 는 'property' 를 이미 '속성'이라고 하고 있기 때문에 '특성' 등의 다른 단어로 옮깁니다. '성질' 이라고 해도 가능할 것 같습니다. 그냥 '어트리뷰트'라고 이름을 그대로 써도 될 것 같습니다.

[^declaration]: 'declaration' 은 때에 따라 '선언' 또는 '선언 구문' 으로 옮깁니다.

[^format]: 'format' 은 '포맷' 으로 옮깁니다.

[^lifecycle]: 'lifecycle' 은 '수명' 으로 옮깁니다.