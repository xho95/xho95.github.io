## API Design Guidelines

### Table of Contents

* [Fundamentals](#Fundamentals)
* Naming
	* Promote Clear Usage
	* Strive for Fluent Usage
	* Use Terminology Well
* Conventions
	* General Conventions
	* Parameters
	* Argument Labels
* [Special Instructions](#special)

### Fundamentals

* **Clarity at the point of use** is your most important goal. Entities such as methods and properties are declared only once but used repeatedly. Design APIs to make those uses clear and concise. When evaluating a design, reading a declaration is seldom sufficient; always examine a use case to make sure it looks clear in context.

* **Clarity is more important than brevity.** Although Swift code can be compact, it is a non-goal to enable the smallest possible code with the fewest characters. Brevity in Swift code, where it occurs, is a side-effect of the strong type system and features that naturally reduce boilerplate.

* **Write a documentation comment** for every declaration. Insights gained by writing documentation can have a profound impact on your design, so don’t put it off.

> If you are having trouble describing your API’s functionality in simple terms, **you may have designed the wrong API.**

### Naming

#### Promote Clear Usage

* **Include all the words needed to avoid ambiguity** for a person reading code where the name is used.

* **Omit needless words.** Every word in a name should convey salient information at the use site.

* **Name variables, parameters, and associated types according to their roles**, rather than their type constraints.

* **Compensate for weak type information** to clarify a parameter’s role.

#### Strive for Fluent Usage

* Prefer method and function names that make use sites form grammatical English phrases.

* Begin names of factory methods with “make”, e.g. x.makeIterator().

* Initializer and factory method calls should form a phrase that does not include the first argument, e.g. x.makeWidget(cogCount: 47)

* Name functions and methods according to their side-effects

	* Those without side-effects should read as noun phrases, e.g. x.distance(to: y), i.successor().

	* Those with side-effects should read as imperative verb phrases, e.g., print(x), x.sort(), x.append(y).

	* Name Mutating/nonmutating method pairs consistently. A mutating method will often have a nonmutating variant with similar semantics, but that returns a new value rather than updating an instance in-place.

		* When the operation is naturally described by a verb, use the verb’s imperative for the mutating method and apply the “ed” or “ing” suffix to name its nonmutating counterpart.
		
			Mutating | Nonmutating
			---|---
			`x.sort()` | `z = x.sorted()`
			`x.append(y)` |	`z = x.appending(y)`
			
		* When the operation is naturally described by a noun, use the noun for the nonmutating method and apply the “form” prefix to name its mutating counterpart.

			Nonmutating | Mutating
			---|---
			`x = y.union(z)` | `y.formUnion(z)`
			`j = c.successor(i)` | `c.formSuccessor(&i)`

* Uses of Boolean methods and properties should read as assertions about the receiver when the use is nonmutating, e.g. x.isEmpty, line1.intersects(line2).

* Protocols that describe what something is should read as nouns (e.g. Collection).

* Protocols that describe a capability should be named using the suffixes able, ible, or ing (e.g. Equatable, ProgressReporting).

* The names of other types, properties, variables, and constants should read as nouns.			

#### Use Terminology Well

Term of Artnoun - a word or phrase that has a precise, specialized meaning within a particular field or profession.

* Avoid obscure terms if a more common word conveys meaning just as well. Don’t say “epidermis” if “skin” will serve your purpose. Terms of art are an essential communication tool, but should only be used to capture crucial meaning that would otherwise be lost.

* Stick to the established meaning if you do use a term of art.

* Avoid abbreviations. Abbreviations, especially non-standard ones, are effectively terms-of-art, because understanding depends on correctly translating them into their non-abbreviated forms.
	
	> The intended meaning for any abbreviation you use should be easily found by a web search.

* Embrace precedent. Don’t optimize terms for the total beginner at the expense of conformance to existing culture.

### Conventions

#### General Conventions

* Document the complexity of any computed property that is not O(1). People often assume that property access involves no significant computation, because they have stored properties as a mental model. Be sure to alert them when that assumption may be violated.

* Prefer methods and properties to free functions. Free functions are used only in special cases:

* Follow case conventions. Names of types and protocols are UpperCamelCase. Everything else is lowerCamelCase.

* Methods can share a base name when they share the same basic meaning or when they operate in distinct domains.

#### Parameters

```swift
func move(from start: Point, to end: Point)
```

* Choose parameter names to serve documentation. Even though parameter names do not appear at a function or method’s point of use, they play an important explanatory role.

* Take advantage of defaulted parameters when it simplifies common uses. Any parameter with a single commonly-used value is a candidate for a default.

* Prefer to locate parameters with defaults toward the end of the parameter list. Parameters without defaults are usually more essential to the semantics of a method, and provide a stable initial pattern of use where methods are invoked.

#### Argument Labels

```swift
func move(from start: Point, to end: Point)
x.move(from: x, to: y) 
```

* Omit all labels when arguments can’t be usefully distinguished, e.g. min(number1, number2), zip(sequence1, sequence2).

* In initializers that perform value preserving type conversions, omit the first argument label, e.g. Int64(someUInt32)

* When the first argument forms part of a prepositional phrase, give it an argument label. The argument label should normally begin at the preposition, e.g. x.removeBoxes(havingLength: 12).

* Otherwise, if the first argument forms part of a grammatical phrase, omit its label, appending any preceding words to the base name, e.g. x.addSubview(y)

* Label all other arguments.

<a href="#special"></a>
### Special Instructions

* Label closure parameters and tuple members where they appear in your API.

* Take extra care with unconstrained polymorphism (e.g. Any, AnyObject, and unconstrained generic parameters) to avoid ambiguities in overload sets.