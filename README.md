# FEKit

A Swift utility library inspired by lodash. Provides utility functions for arrays, numbers, objects, strings, and collections.

## Requirements

- iOS 13.0+ / macOS 11.0+ / tvOS 13.0+ / watchOS 6.0+
- Swift 6.0+

## Installation

### Swift Package Manager

Add FEKit to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/yourusername/FEKit.git", from: "0.1.0")
]
```

## Usage

FEKit provides utility functions organized into different categories:

### Array Functions

```swift
import FEKit

// Get the first element
let firstElement = FEKit.Array.first([1, 2, 3, 4])  // 1

// Get the last element
let lastElement = FEKit.Array.last([1, 2, 3, 4])  // 4

// Chunk an array
let chunks = FEKit.Array.chunk([1, 2, 3, 4, 5], size: 2)  // [[1, 2], [3, 4], [5]]

// Compact an array (remove nil values)
let compacted = FEKit.Array.compact([1, nil, 3, nil, 5])  // [1, 3, 5]
```

### String Functions

```swift
import FEKit

// Convert string to camel case
let camelCased = FEKit.String.camelCase("hello world")  // "helloWorld"

// Capitalize a string
let capitalized = FEKit.String.capitalize("hello")  // "Hello"

// Check if a string ends with a target
let endsWithC = FEKit.String.endsWith("abc", "c")  // true

// Pad a string
let padded = FEKit.String.pad("hello", length: 10)  // "  hello   "
```

### Number Functions

```swift
import FEKit

// Clamp a number within bounds
let clamped = FEKit.Number.clamp(3, lower: 1, upper: 5)  // 3

// Check if a number is in a range
let inRange = FEKit.Number.inRange(3, start: 1, end: 5)  // true

// Generate a random number
let random = FEKit.Number.random(min: 1, max: 10)  // Random number between 1 and 10
```

### Collection Functions

```swift
import FEKit

// Filter a collection
let filtered = FEKit.Collection.filter([1, 2, 3, 4]) { $0 % 2 == 0 }  // [2, 4]

// Map a collection
let mapped = FEKit.Collection.map([1, 2, 3, 4]) { $0 * 2 }  // [2, 4, 6, 8]

// Reduce a collection
let sum = FEKit.Collection.reduce([1, 2, 3, 4], initialValue: 0) { $0 + $1 }  // 10
```

### Object Functions

```swift
import FEKit

// Convert object to key-value pairs
let pairs = FEKit.Object.toPairs(["a": 1, "b": 2, "c": 3])  // [("a", 1), ("b", 2), ("c", 3)]

// Pick properties from an object
let picked = FEKit.Object.pick(["a": 1, "b": 2, "c": 3], paths: ["a", "c"])  // ["a": 1, "c": 3]

// Omit properties from an object
let omitted = FEKit.Object.omit(["a": 1, "b": 2, "c": 3], paths: ["b"])  // ["a": 1, "c": 3]

// Get a nested property
let value: Int? = FEKit.Object.get(["user": ["name": "John", "age": 30]], path: "user.age")  // 30
```

## License

FEKit is available under the MIT license. See the LICENSE file for more info. 