## Adopting Cocoa Design Patterns

One aid in writing well-designed, resilient apps is to use Cocoa’s established design patterns. Many of these patterns rely on classes defined in Objective-C. Because of Swift’s interoperability with Objective-C, you can take advantage of these common patterns in your Swift code. In many cases, you can use Swift language features to extend or simplify existing Cocoa patterns, making them more powerful and easier to use.

### Delegation

In both Swift and Objective-C, delegation is often expressed with a protocol that defines the interaction and a conforming delegate property. Just as in Objective-C, before you send a message that a delegate may not respond to, you ask the delegate whether it responds to the selector. In Swift, you can use optional chaining to invoke an optional protocol method on a possibly nil object and unwrap the possible result using if–let syntax. The code listing below illustrates the following process:

1. Check that myDelegate is not nil.
2. Check that myDelegate implements the method window:willUseFullScreenContentSize:.
3. If 1 and 2 hold true, invoke the method and assign the result of the method to the value named fullScreenSize.
4. Print the return value of the method.

```swift
class MyDelegate: NSObject, NSWindowDelegate {
    func window(_ window: NSWindow, willUseFullScreenContentSize proposedSize: NSSize) -> NSSize {
        return proposedSize
    }
}
myWindow.delegate = MyDelegate()
if let fullScreenSize = myWindow.delegate?.window(myWindow, willUseFullScreenContentSize: mySize) {
    print(NSStringFromSize(fullScreenSize))
}
```

### Lazy Initialization

A lazy property is a property whose underlying value is only initialized when the property is first accessed. Lazy properties are useful when the initial value for a property either requires complex or computationally expensive setup, or cannot be determined until after an instance’s initialization is complete.

In Objective-C, a property may override its synthesized getter method such that the underlying instance variable is conditionally initialized if its value is nil:

```objectivec
@property NSXMLDocument *XML;
 
- (NSXMLDocument *)XML {
    if (_XML == nil) {
        _XML = [[NSXMLDocument alloc] initWithContentsOfURL:[[Bundle mainBundle] URLForResource:@"/path/to/resource" withExtension:@"xml"] options:0 error:nil];
    }
 
    return _XML;
}
```

In Swift, a stored property with an initial value can be declared with the lazy modifier to have the expression calculating the initial value only evaluated when the property is first accessed:

```swift
lazy var XML: XMLDocument = try! XMLDocument(contentsOf: Bundle.main.url(forResource: "document", withExtension: "xml")!, options: 0)
```

Because a lazy property is only computed when accessed for a fully-initialized instance it may access constant or variable properties in its default value initialization expression:

```swift
var pattern: String
lazy var regex: NSRegularExpression = try! NSRegularExpression(pattern: self.pattern, options: [])
```

For values that require additional setup beyond initialization, you can assign the default value of the property to a self-evaluating closure that returns a fully-initialized value:

```swift
lazy var currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "¤"
    return formatter
}()
```

> If a lazy property has not yet been initialized and is accessed by more than one thread at the same time, there is no guarantee that the property will be initialized only once.

For more information, see Lazy Stored Properties in The Swift Programming Language (Swift 3.1).

### Error Handling

In Cocoa, methods that produce errors take an NSError pointer parameter as their last parameter, which populates its argument with an NSError object if an error occurs. Swift automatically translates Objective-C methods that produce errors into methods that throw an error according to Swift’s native error handling functionality.

> Methods that consume errors, such as delegate methods or methods that take a completion handler with an NSError object argument, do not become methods that throw when imported by Swift.

For example, consider the following Objective-C method from NSFileManager:

```objectivec
- (BOOL)removeItemAtURL:(NSURL *)URL
                  error:(NSError **)error;
```
                 
In Swift, it’s imported like this:

```swift
func removeItem(at: URL) throws
```

Notice that the removeItem(at:) method is imported by Swift with a Void return type, no error parameter, and a throws declaration.

If the last non-block parameter of an Objective-C method is of type NSError **, Swift replaces it with the throws keyword, to indicate that the method can throw an error. If the Objective-C method’s error parameter is also its first parameter, Swift attempts to simplify the method name further, by removing the “WithError” or “AndReturnError” suffix, if present, from the first part of the selector. If another method is declared with the resulting selector, the method name is not changed.

If an error producing Objective-C method returns a BOOL value to indicate the success or failure of a method call, Swift changes the return type of the function to Void. Similarly, if an error producing Objective-C method returns a nil value to indicate the failure of a method call, Swift changes the return type of the function to a nonoptional type.

Otherwise, if no convention can be inferred, the method is left intact.

> Use the NS_SWIFT_NOTHROW macro on an Objective-C method declaration that produces an NSError to prevent it from being imported by Swift as a method that throws.

#### Catching and Handling an Error

In Objective-C, error handling is opt-in, meaning that errors produced by calling a method are ignored unless an error pointer is provided. In Swift, calling a method that throws requires explicit error handling.

Here’s an example of how to handle an error when calling a method in Objective-C:

```objectivec
NSFileManager *fileManager = [NSFileManager defaultManager];
NSURL *fromURL = [NSURL fileURLWithPath:@"/path/to/old"];
NSURL *toURL = [NSURL fileURLWithPath:@"/path/to/new"];
NSError *error = nil;
BOOL success = [fileManager moveItemAtURL:fromURL toURL:toURL error:&error];
if (!success) {
    NSLog(@"Error: %@", error.domain);
}
```

And here’s the equivalent code in Swift:

```swift
let fileManager = FileManager.default
let fromURL = URL(fileURLWithPath: "/path/to/old")
let toURL = URL(fileURLWithPath: "/path/to/new")
do {
    try fileManager.moveItem(at: fromURL, to: toURL)
} catch let error as NSError {
    print("Error: \(error.domain)")
}
```

Additionally, you can use catch clauses to match on particular error codes as a convenient way to differentiate possible failure conditions:

```swift
do {
    try fileManager.moveItem(at: fromURL, to: toURL)
} catch CocoaError.fileNoSuchFile {
    print("Error: no such file exists")
} catch CocoaError.fileReadUnsupportedScheme {
    print("Error: unsupported scheme (should be 'file://')")
}
```

#### Converting Errors to Optional Values

In Objective-C, you pass NULL for the error parameter when you only care whether there was an error, not what specific error occurred. In Swift, you write try? to change a throwing expression into one that returns an optional value, and then check whether the value is nil.

For example, the NSFileManager instance method URL(for:in:appropriateForURL:create:) returns a URL in the specified search path and domain, or produces an error if an appropriate URL does not exist and cannot be created. In Objective-C, the success or failure of the method can be determined by whether an NSURL object is returned.

```objectivec
NSFileManager *fileManager = [NSFileManager defaultManager];
 
NSURL *tmpURL = [fileManager URLForDirectory:NSCachesDirectory
                                    inDomain:NSUserDomainMask
                           appropriateForURL:nil
                                      create:YES
                                       error:nil];
 
if (tmpURL != nil) {
   // ...
}
```

You can do the same in Swift as follows:

```swift
let fileManager = FileManager.default
if let tmpURL = try? fileManager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true) {
    // ...
}
```

#### Throwing an Error

If an error occurs in an Objective-C method, that error is used to populate the error pointer argument of that method:

```objectivec
// an error occurred
if (errorPtr) {
   *errorPtr = [NSError errorWithDomain:NSURLErrorDomain
                                   code:NSURLErrorCannotOpenFile
                               userInfo:nil];
}
```

If an error occurs in a Swift method, the error is thrown, and automatically propagated to the caller:

```swift
// an error occurred
throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)
```

If Objective-C code calls a Swift method that throws an error, the error is automatically propagated to the error pointer argument of the bridged Objective-C method.

For example, consider the read(from:ofType:) method in NSDocument. In Objective-C, this method’s last parameter is of type NSError **. When overriding this method in a Swift subclass of NSDocument, the method replaces its error parameter and throws instead.

```swift
class SerializedDocument: NSDocument {
    static let ErrorDomain = "com.example.error.serialized-document"
    
    var representedObject: [String: Any] = [:]
    
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        guard let data = fileWrapper.regularFileContents else {
            throw NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotOpenFile, userInfo: nil)
        }
        
        if case let JSON as [String: Any] = try JSONSerialization.jsonObject(with: data, options: []) {
            self.representedObject = JSON
        } else {
            throw NSError(domain: SerializedDocument.ErrorDomain, code: -1, userInfo: nil)
        }
    }
}
```

If the method is unable to create an object with the regular file contents of the document, it throws an NSError object. If the method is called from Swift code, the error is propagated to its calling scope. If the method is called from Objective-C code, the error instead populates the error pointer argument.

In Objective-C, error handling is opt-in, meaning that errors produced by calling a method are ignored unless you provide an error pointer. In Swift, calling a method that throws requires explicit error handling.

> Although Swift error handling resembles exception handling in Objective-C, it is entirely separate functionality. If an Objective-C method throws an exception during runtime, Swift triggers a runtime error. There is no way to recover from Objective-C exceptions directly in Swift. Any exception handling behavior must be implemented in Objective-C code used by Swift.

### Key-Value Observing

Key-value observing is a mechanism that allows objects to be notified of changes to specified properties of other objects. You can use key-value observing with a Swift class, as long as the class inherits from the NSObject class. You can use these three steps to implement key-value observing in Swift.

1. Add the dynamic modifier to any property you want to observe. For more information on dynamic, see Requiring Dynamic Dispatch.

	```swift
	class MyObjectToObserve: NSObject {
		dynamic var myDate = NSDate()
		func updateDate() {
			myDate = NSDate()
		}
	}
	```
	
2. Create a global context variable.

	```swift
	private var myContext = 0
	```
	
3. Add an observer for the key-path, override the observeValue(for:of:change:context:) method, and remove the observer in deinit.

	```swift
	class MyObserver: NSObject {
		var objectToObserve = MyObjectToObserve()
		override init() {
			super.init()
			objectToObserve.addObserver(self, forKeyPath: #keyPath(MyObjectToObserve.myDate), options: .new, context: &myContext)
		}
		
		override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
			if context == &myContext {
				if let newValue = change?[.newKey] {
					print("Date changed: \(newValue)")
				}
			} else {
				super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
			}
		}
		
		deinit {
			objectToObserve.removeObserver(self, forKeyPath: #keyPath(MyObjectToObserve.myDate), context: &myContext)
		}
	}
	```

### Undo

In Cocoa, you register operations with NSUndoManager to allow users to reverse that operation’s effect. You can take advantage of Cocoa’s undo architecture in Swift just as you would in Objective-C.

Objects in an app’s responder chain—that is, subclasses of NSResponder on macOS and UIResponder on iOS—have a read-only undoManager property that returns an optional NSUndoManager value, which manages the undo stack for the app. Whenever an action is taken by the user, such as editing the text in a control or deleting an item at a selected row, an undo operation can be registered with the undo manager to allow the user to reverse the effect of that operation. An undo operation records the steps necessary to counteract its corresponding operation, such as setting the text of a control back to its original value or adding a deleted item back into a table.

NSUndoManager supports two ways to register undo operations: a “simple undo”, which performs a selector with a single object argument, and an “invocation-based undo”, which uses an NSInvocation object that takes any number and any type of arguments.

For example, consider a simple Task model, which is used by a ToDoListController to display a list of tasks to complete:

```swift
class Task {
    var text: String
    var completed: Bool = false
    
    init(text: String) {
        self.text = text
    }
}
 
class ToDoListController: NSViewController, NSTableViewDataSource, NSTableViewDelegate {
    @IBOutlet var tableView: NSTableView!
    var tasks: [Task] = []
    
    // ...
}
```

For methods that take more than one argument, you can create an undo operation using an NSInvocation, which invokes the method with arguments that effectively revert the app to its previous state:

```swift
@IBOutlet var remainingLabel: NSTextView!
 
func mark(task: Task, asCompleted completed: Bool) {
    if let target = undoManager?.prepare(withInvocationTarget: self) as? ToDoListController {
        target.mark(task: task, asCompleted: !completed)
        undoManager?.setActionName(NSLocalizedString("todo.task.mark", comment: "Mark As Completed"))
    }
    
    task.completed = completed
    tableView.reloadData()
    
    let numberRemaining = tasks.filter{ $0.completed }.count
    remainingLabel.string = String(format: NSLocalizedString("todo.task.remaining", comment: "Tasks Remaining: %d"), numberRemaining)
}
```

The prepare(withInvocationTarget:) method returns a proxy to the specified target. By casting to ToDoListController, this return value can make the corresponding call to mark(task:asCompleted:) directly.

For more information, see Undo Architecture.

### Target-Action

Target-action is a common Cocoa design pattern in which one object sends a message to another object when a specific event occurs. The target-action model is fundamentally similar in Swift and Objective-C. In Swift, you use the Selector type to refer to Objective-C selectors. For an example of using target-action in Swift code, see Selectors.

### Singleton

Singletons provide a globally accessible, shared instance of an object. You can create your own singletons as a way to provide a unified access point to a resource or service that’s shared across an app, such as an audio channel to play sound effects or a network manager to make HTTP requests.

In Objective-C, you can ensure that only one instance of a singleton object is created by wrapping its initialization in a call the dispatch_once function, which executes a block once and only once for the lifetime of an app:

```objectivec
+ (instancetype)sharedInstance {
    static id _sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
 
    return _sharedInstance;
}
```

In Swift, you can simply use a static type property, which is guaranteed to be lazily initialized only once, even when accessed across multiple threads simultaneously:

```swift
class Singleton {
    static let sharedInstance = Singleton()
}
```

If you need to perform additional setup beyond initialization, you can assign the result of the invocation of a closure to the global constant:

```swift
class Singleton {
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
}
```

For more information, see Type Properties in The Swift Programming Language (Swift 3.1).

### Introspection

In Objective-C, you use the isKindOfClass: method to check whether an object is of a certain class type, and the conformsToProtocol: method to check whether an object conforms to a specified protocol. In Swift, you accomplish this task by using the is operator to check for a type, or the as? operator to downcast to that type.

You can check whether an instance is of a certain subclass type by using the is operator. The is operator returns true if the instance is of that subclass type, and false if it is not.

```swift
if object is UIButton {
    // object is of type UIButton
} else {
    // object is not of type UIButton
}
```

You can also try and downcast to the subclass type by using the as? operator. The as? operator returns an optional value that can be bound to a constant using an if-let statement.

```swift
if let button = object as? UIButton {
    // object is successfully cast to type UIButton and bound to button
} else {
    // object could not be cast to type UIButton
}
```

For more information, see Type Casting in The Swift Programming Language (Swift 3.1).

Checking for and casting to a protocol follows exactly the same syntax as checking for and casting to a class. Here is an example of using the as? operator to check for protocol conformance:

```swift
if let dataSource = object as? UITableViewDataSource {
    // object conforms to UITableViewDataSource and is bound to dataSource
} else {
    // object not conform to UITableViewDataSource
}
```

Note that after this cast, the dataSource constant is of type UITableViewDataSource, so you can only call methods and access properties defined on the UITableViewDataSource protocol. You must cast it back to another type to perform other operations.

For more information, see Protocols in The Swift Programming Language (Swift 3.1).

### Serializing

Serialization allows you to encode and decode objects in your application to and from architecture-independent representations, such as JSON or property lists. These representations can then be written to a file or transmitted to another process locally or over a network.

In Objective-C, you can use the Foundation framework classes NSJSONSerialiation and NSPropertyListSerialization to initialize objects from a decoded JSON or property list serialization value—usually an object of type NSDictionary<NSString *, id>. You can do the same in Swift, but because Swift enforces type safety, additional type casting is required in order to extract and assign values.

For example, consider the following Venue structure, which contains a name property of type String, a coordinate property of type CLLocationCoordinate2D, and a category property of a nested Category enumeration type:

```swift
import Foundation
import CoreLocation
 
struct Venue {
    enum Category: String {
        case entertainment
        case food
        case nightlife
        case shopping
    }
    
    var name: String
    var coordinates: CLLocationCoordinate2D
    var category: Category
}
```

An app that interacts with Venue instances may communicate with a web server that vends JSON representations of venues, such as:

```json
{
   "name": "Caffè Macs",
   "coordinates": {
      "lat": 37.330576,
      "lng": -122.029739
   },
   "category": "food"
}
```

You can provide a failable Venue initializer that takes an attributes parameter of type [String: Any] corresponding to the value returned from NSJSONSerialiation or NSPropertyListSerialization:

```objectivec
init?(attributes: [String: Any]) {
    guard let name = attributes["name"] as? String,
        let coordinates = attributes["coordinates"] as? [String: Double],
        let latitude = coordinates["lat"],
        let longitude = coordinates["lng"],
        let category = Category(rawValue: attributes["category"] as? String ?? "Invalid")
        else {
            return nil
    }
    
    self.name = name
    self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.category = category
}
```

A guard statement consisting of multiple optional binding expressions ensures that the attributes argument provides all of the required information in the expected format. If any one of the optional binding expressions fails to assign a value to a constant, the guard statement immediately stops evaluating its condition and executes its else branch, which returns nil.

You can create a Venue from a JSON representation by creating a dictionary of attributes using the NSJSONSerialization class and then passing that into the corresponding Venue initializer:

```swift
let JSON = "{\"name\": \"Caffè Macs\",\"coordinates\": {\"lat\": 37.330576,\"lng\": -122.029739},\"category\": \"food\"}"
let data = JSON.data(using: String.Encoding.utf8)!
let attributes = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
 
let venue = Venue(attributes: attributes)!
print(venue.name)
// Prints "Caffè Macs"
```

#### Validating Serialized Representations

In the previous example, the Venue initializer optionally returns an instance only if all of the required information is provided. If not, the initializer simply returns nil.

It is often useful to determine and communicate the specific reason why a given collection of values failed to produce a valid instance. To do this, you can refactor the failable initializer into an initializer that throws:

```swift
enum ValidationError: Error {
    case missing(String)
    case invalid(String)
}
 
init(attributes: [String: Any]) throws {
    guard let name = attributes["name"] as? String else {
        throw ValidationError.missing("name")
    }
    
    guard let coordinates = attributes["coordinates"] as? [String: Double] else {
        throw ValidationError.missing("coordinates")
    }
    
    guard let latitude = coordinates["lat"],
        let longitude = coordinates["lng"]
        else {
            throw ValidationError.invalid("coordinates")
    }
    
    guard let categoryName = attributes["category"] as? String else {
        throw ValidationError.missing("category")
    }
    
    guard let category = Category(rawValue: categoryName) else {
        throw ValidationError.invalid("category")
    }
    
    self.name = name
    self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    self.category = category
}
```

Instead of capturing all of the attributes values at once in a single guard statement, this initializer checks each value individually and throws an error if any particular value is either missing or invalid.

For instance, if the provided JSON didn’t have a value for the key "name", the initializer would throw the enumeration value ValidationError.missing with an associated value corresponding to the "name" field:

```json
{
   "coordinates": {
      "lat": 37.7842,
      "lng": -122.4016
   },
   "category": "Convention Center"
}
```

```swift
let JSON = "{\"coordinates\": {\"lat\": 37.7842, \"lng\": -122.4016}, \"category\": \"Convention Center\"}"
let data = JSON.data(using: String.Encoding.utf8)!
let attributes = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
 
do {
    let venue = try Venue(attributes: attributes)
} catch ValidationError.missing(let field) {
    print("Missing Field: \(field)")
}
// Prints "Missing Field: name"
```

Or, if the provided JSON specified all of the required fields but had a value for the "category" key that didn’t correspond with the rawValue of any of the defined Category cases, the initializer would throw the enumeration value ValidationError.invalid with an associated value corresponding to the "category" field:

```json
{
   "name": "Moscone West",
   "coordinates": {
      "lat": 37.7842,
      "lng": -122.4016
   },
   "category": "Convention Center"
}
```

```swift
let JSON = "{\"name\": \"Moscone West\", \"coordinates\": {\"lat\": 37.7842, \"lng\": -122.4016}, \"category\": \"Convention Center\"}"
let data = JSON.data(using: String.Encoding.utf8)!
let attributes = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
 
do {
    let venue = try Venue(attributes: attributes)
} catch ValidationError.invalid(let field) {
    print("Invalid Field: \(field)")
}
// Prints "Invalid Field: category"
```

### Localization

In Objective-C, you typically use the NSLocalizedString family of macros to localize strings. These include NSLocalizedString, NSLocalizedStringFromTable, NSLocalizedStringFromTableInBundle, and NSLocalizedStringWithDefaultValue. In Swift, the functionality of these macros is made available through a single function: NSLocalizedString(_:tableName:bundle:value:comment:).

Rather than defining separate functions that correspond to each Objective-C macro, the Swift NSLocalizedString(_:tableName:bundle:value:) function specifies default values for the tableName, bundle, and value arguments, so that they may be overridden as necessary.

For example, the most common form of a localized string in an app may only need a localization key and a comment:

```swift
let format = NSLocalizedString("Hello, %@!", comment: "Hello, {given name}!")
let name = "Mei"
let greeting = String(format: format, arguments: [name as CVarArg])
print(greeting)
// Prints "Hello, Mei!"
```

Or, an app may require more complex usage in order to use localization resources from a separate bundle:

```swift
if let path = Bundle.main.path(forResource: "Localization", ofType: "strings", inDirectory: nil, forLocalization: "ja"),
    let bundle = Bundle(path: path) {
    let translation = NSLocalizedString("Hello", bundle: bundle, comment: "")
    print(translation)
}
// Prints "こんにちは"
```

For more information, see Internationalization and Localization Guide.

### Autorelease Pools

Autorelease pool blocks allow objects to relinquish ownership without being deallocated immediately. Typically, you don’t need to create your own autorelease pool blocks, but there are some situations in which either you must—such as when spawning a secondary thread—or it is beneficial to do so—such as when writing a loop that creates many temporary objects.

In Objective-C, autorelease pool blocks are marked using @autoreleasepool. In Swift, you can use the autoreleasepool(_:) function to execute a closure within an autorelease pool block.

```swift
import Foundation
 
autoreleasepool {
    // code that creates autoreleased objects.
}
```

For more information, see Advanced Memory Management Programming Guide.

### API Availability

Some classes and methods are not available to all versions of all platforms that your app targets. To ensure that your app can accommodate any differences in functionality, you check the availability those APIs.

In Objective-C, you use the respondsToSelector: and instancesRespondToSelector: methods to check for the availability of a class or instance method. Without a check, the method call throws an NSInvalidArgumentException “unrecognized selector sent to instance” exception. For example, the requestWhenInUseAuthorization method is only available to instances of CLLocationManager starting in iOS 8.0 and macOS 10.10:

```swift
if ([CLLocationManager instancesRespondToSelector:@selector(requestWhenInUseAuthorization)]) {
  // Method is available for use.
} else {
  // Method is not available.
}
```

In Swift, attempting to call a method that is not supported on all targeted platform versions causes a compile-time error.

Here’s the previous example, in Swift:

```swift
let locationManager = CLLocationManager()
locationManager.requestWhenInUseAuthorization()
// error: only available on iOS 8.0 or newer
```

If the app targets a version of iOS prior to 8.0 or macOS prior to 10.10, requestWhenInUseAuthorization() is unavailable, so the compiler reports an error.

Swift code can use the availability of APIs as a condition at run-time. Availability checks can be used in place of a condition in a control flow statement, such as an if, guard, or while statement.

Taking the previous example, you can check availability in an if statement to call requestWhenInUseAuthorization() only if the method is available at runtime:

```swift
let locationManager = CLLocationManager()
if #available(iOS 8.0, macOS 10.10, *) {
    locationManager.requestWhenInUseAuthorization()
}
```

Alternatively, you can check availability in a guard statement, which exits out of scope unless the current target satisfies the specified requirements. This approach simplifies the logic of handling different platform capabilities.

```swift
let locationManager = CLLocationManager()
guard #available(iOS 8.0, macOS 10.10, *) else { return }
locationManager.requestWhenInUseAuthorization()
```

Each platform argument consists of one of platform names listed below, followed by corresponding version number. The last argument is an asterisk (*), which is used to handle potential future platforms.

Platform Names:

* iOS
* iOSApplicationExtension
* macOS
* macOSApplicationExtension
* watchOS
* watchOSApplicationExtension
* tvOS
* tvOSApplicationExtension

All of the Cocoa APIs provide availability information, so you can be confident the code you write works as expected on any of the platforms your app targets.

You can denote the availability of your own APIs by annotating declarations with the @available attribute. The @available attribute uses the same syntax as the #available runtime check, with the platform version requirements provided as comma-delimited arguments.

For example:

```swift
@available(iOS 8.0, macOS 10.10, *)
func useShinyNewFeature() {
    // ...
}
```

> A method annotated with the @available attribute can safely use APIs available to the specified platform requirements without the use of an explicit availability check.

### Processing Command-Line Arguments

On macOS, you typically open an app by clicking its icon in the Dock or Launchpad, or by double-clicking its icon from the Finder. However, you can also open an app programmatically and pass command-line arguments from Terminal.

You can get a list of any command-line arguments that are specified at launch by accessing the CommandLine.arguments type property.

```bash
$ /path/to/app --argumentName value
```

```swift
for argument in CommandLine.arguments {
    print(argument)
}
// prints "/path/to/app"
// prints "--argumentName"
// prints "value"
```

The first element in CommandLine.arguments is a path to the executable. Any command-line arguments that are specified at launch begin at CommandLine.arguments[1].

> Accessing arguments using CommandLine.arguments is equivalent to accessing the arguments property on ProcessInfo.processInfo.