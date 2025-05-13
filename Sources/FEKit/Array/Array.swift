//
//  Array.swift
//  FEKit
//
//  Array utilities inspired by lodash
//

import Foundation

extension Array {
  // at: returns the element at the specified index, supports negative indices
  public func at(_ index: Int) -> Element? {
    let adjustedIndex = index >= 0 ? index : count + index
    return indices.contains(adjustedIndex) ? self[adjustedIndex] : nil
  }

  // concat: merges two or more arrays
  public func concat(_ arrays: [Element]...) -> [Element] {
    var result = Array(self)
    for array in arrays {
      result.append(contentsOf: array)
    }
    return result
  }

  // entries: returns an array of [index, element] pairs
  public func entries() -> [(Int, Element)] {
    return enumerated().map { ($0.offset, $0.element) }
  }

  // every: tests whether all elements pass the provided function
  public func every(_ predicate: (Element) -> Bool) -> Bool {
    for element in self {
      if !predicate(element) {
        return false
      }
    }
    return true
  }

  // fill: fills all elements with a static value
  public mutating func fill(_ value: Element, start: Int = 0, end: Int? = nil) -> [Element] {
    let startIndex = Swift.max(0, start)
    let endIndex = Swift.min(end ?? count, count)

    guard startIndex < endIndex else { return self }

    for i in startIndex..<endIndex {
      self[i] = value
    }
    return self
  }

  // filter: creates a new array with elements that pass the test
  public func filter(_ isIncluded: (Element) -> Bool) -> [Element] {
    var result: [Element] = []
    for element in self {
      if isIncluded(element) {
        result.append(element)
      }
    }
    return result
  }

  // find: returns the first element that satisfies the provided testing function
  public func find(_ predicate: (Element) -> Bool) -> Element? {
    return first(where: predicate)
  }

  // findIndex: returns the index of the first element that satisfies the provided testing function
  public func findIndex(_ predicate: (Element) -> Bool) -> Int? {
    return firstIndex(where: predicate)
  }

  // findLast: returns the last element that satisfies the provided testing function
  public func findLast(_ predicate: (Element) -> Bool) -> Element? {
    return reversed().first(where: predicate)
  }

  // findLastIndex: returns the index of the last element that satisfies the provided testing function
  public func findLastIndex(_ predicate: (Element) -> Bool) -> Int? {
    for i in stride(from: count - 1, through: 0, by: -1) {
      if predicate(self[i]) {
        return i
      }
    }
    return nil
  }

  // flat: flattens a nested array structure
  public func flat<T>() -> [T] where Element == [T] {
    return flatMap { $0 }
  }

  // flatMap: maps each element using a mapping function, then flattens the result
  public func flatMap<T>(_ transform: (Element) -> [T]) -> [T] {
    var result: [T] = []
    for element in self {
      result.append(contentsOf: transform(element))
    }
    return result
  }

  // forEach: executes a provided function once for each array element
  public func forEach(_ body: (Element) -> Void) {
    for element in self {
      body(element)
    }
  }

  // indexOf: returns the first index at which a given element can be found
  public func indexOf(_ element: Element) -> Int? where Element: Equatable {
    return firstIndex(of: element)
  }

  // join: joins all elements of an array into a string
  public func join(separator: String = ",") -> String where Element: CustomStringConvertible {
    return map { $0.description }.joined(separator: separator)
  }

  // lastIndexOf: returns the last index at which a given element can be found
  public func lastIndexOf(_ element: Element) -> Int? where Element: Equatable {
    return lastIndex(of: element)
  }

  // includes: determines whether an array includes a certain value
  public func includes(_ element: Element) -> Bool where Element: Equatable {
    return contains(element)
  }

  // map: creates a new array populated with the results of calling a provided function on every element
  public func map<T>(_ transform: (Element) -> T) -> [T] {
    var result: [T] = []
    for element in self {
      result.append(transform(element))
    }
    return result
  }

  // reduce: executes a reducer function on each element, resulting in a single output value
  public func reduce<T>(_ initialResult: T, _ nextPartialResult: (T, Element) -> T) -> T {
    var result = initialResult
    for element in self {
      result = nextPartialResult(result, element)
    }
    return result
  }

  // reduceRight: applies a function against an accumulator and each value of the array (from right-to-left)
  public func reduceRight<T>(_ initialResult: T, _ nextPartialResult: (T, Element) -> T) -> T {
    var result = initialResult
    for i in (0..<count).reversed() {
      result = nextPartialResult(result, self[i])
    }
    return result
  }

  // shift: removes the first element from an array and returns that element
  @discardableResult
  public mutating func shift() -> Element? {
    return isEmpty ? nil : removeFirst()
  }

  // pop: removes the last element from an array and returns that element
  @discardableResult
  public mutating func pop() -> Element? {
    return isEmpty ? nil : removeLast()
  }

  // slice: returns a shallow copy of a portion of an array
  public func slice(start: Int = 0, end: Int? = nil) -> [Element] {
    let startIndex = Swift.max(0, start >= 0 ? start : count + start)
    let endIndex = Swift.min(end.map { $0 >= 0 ? $0 : count + $0 } ?? count, count)

    guard startIndex < endIndex else { return [] }

    return Array(self[startIndex..<endIndex])
  }

  // some: tests whether at least one element passes the provided function
  public func some(_ predicate: (Element) -> Bool) -> Bool {
    return contains(where: predicate)
  }

  // splice: changes the contents of an array by removing or replacing existing elements and/or adding new elements
  public mutating func splice(start: Int, deleteCount: Int = 0, elementsToAdd: [Element] = [])
    -> [Element]
  {
    let adjustedStart = Swift.max(0, start >= 0 ? start : count + start)
    let adjustedEnd = Swift.min(adjustedStart + deleteCount, count)

    let removedElements = Array(self[adjustedStart..<adjustedEnd])
    let rangeToReplace = adjustedStart..<adjustedEnd

    self.replaceSubrange(rangeToReplace, with: elementsToAdd)

    return removedElements
  }

  // sort: sorts the elements of an array in place
  public mutating func sort(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
    self = sorted(by: areInIncreasingOrder)
    return self
  }

  // toSorted: returns a new sorted array
  public func toSorted(by areInIncreasingOrder: (Element, Element) -> Bool) -> [Element] {
    return self.sorted(by: areInIncreasingOrder)
  }

  // toSpliced: returns a new array with splice result
  public func toSpliced(start: Int, deleteCount: Int = 0, elementsToAdd: [Element] = [])
    -> [Element]
  {
    var copy = self
    _ = copy.splice(start: start, deleteCount: deleteCount, elementsToAdd: elementsToAdd)
    return copy
  }

  // unshift: adds one or more elements to the beginning of an array
  public mutating func unshift(_ elements: Element...) -> Int {
    insert(contentsOf: elements, at: 0)
    return count
  }

  // reverse: reverses an array in place
  public mutating func reverse() -> [Element] {
    // Manually reverse the array
    let count = self.count
    for i in 0..<(count / 2) {
      let temp = self[i]
      self[i] = self[count - 1 - i]
      self[count - 1 - i] = temp
    }
    return self
  }

  // toReversed: returns a new reversed array
  public func toReversed() -> [Element] {
    return self.reversed()
  }

  // with: returns a new array with the element at the specified index replaced
  public func with(index: Int, value: Element) -> [Element] {
    guard index >= 0, index < count else { return self }

    var copy = self
    copy[index] = value
    return copy
  }

}
