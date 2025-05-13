//
//  String.swift
//  FEKit
//
//  String utilities inspired by JavaScript
//

import Foundation

/// String utilities
extension String {

  /// Creates a String from the specified sequence of UTF-16 code units
  /// - Parameter charCode: Array of UTF-16 code unit values
  /// - Returns: A String created by using the specified sequence of UTF-16 code units
  static func fromCharCode(charCode: [Int]) -> String {
    var result = ""
    var i = 0

    while i < charCode.count {
      // Check if we have a potential surrogate pair
      if i + 1 < charCode.count && (charCode[i] >= 0xD800 && charCode[i] <= 0xDBFF)
        && (charCode[i + 1] >= 0xDC00 && charCode[i + 1] <= 0xDFFF)
      {

        // Convert surrogate pair to code point
        let highSurrogate = charCode[i]
        let lowSurrogate = charCode[i + 1]
        let codePoint = ((highSurrogate - 0xD800) * 0x400) + (lowSurrogate - 0xDC00) + 0x10000

        if let scalar = UnicodeScalar(codePoint) {
          result.append(String(scalar))
        }
        i += 2
      } else {
        // Regular character
        if let scalar = UnicodeScalar(charCode[i]) {
          result.append(String(scalar))
        }
        i += 1
      }
    }

    return result
  }

  /// Creates a String from the specified sequence of code points
  /// - Parameter codePoint: Array of Unicode code point values
  /// - Returns: A String created by using the specified sequence of code points
  static func fromCodePoint(codePoint: [Int]) -> String {
    return codePoint.compactMap {
      guard $0 >= 0 && $0 <= 0x10FFFF else { return nil }
      return UnicodeScalar($0)
    }.map { String($0) }.joined()
  }
}

/// Prototype methods
extension String {
  /// Returns the character at the specified index
  /// - Parameter index: The index of the character to return
  /// - Returns: The character at the specified index
  public func at(_ index: Int) -> String? {
    let length = self.count
    // If index is negative, convert to positive index
    let adjustedIndex = index < 0 ? length + index : index
    // If index is out of bounds, return an empty string
    guard adjustedIndex >= 0 && adjustedIndex < length else { return nil }
    return String(self[String.Index(utf16Offset: adjustedIndex, in: self)])
  }

  /// Returns the character at the specified index
  /// - Parameter index: The index of the character to return
  /// - Returns: The character at the specified index
  public func charAt(_ index: Int) -> String {

    if index < 0 {
      return ""
    }

    let length = self.count
    if length <= index {
      return ""
    }

    return String(self[String.Index(utf16Offset: index, in: self)])
  }

  /// Returns the Unicode code point at the specified index
  /// - Parameter index: The index of the Unicode code point to return
  /// - Returns: The Unicode code point at the specified index
  public func charCodeAt(_ index: Int) -> Int? {
    // 检查索引是否有效
    guard index >= 0, index < self.count else {
      return nil
    }

    // 获取指定索引的字符
    let charIndex = self.index(self.startIndex, offsetBy: index)
    let character = self[charIndex]

    // 将字符转换为 Unicode 标量值
    return Int(character.unicodeScalars.first!.value)
  }

  /// Returns the Unicode code point at the specified index
  /// - Parameter index: The index of the Unicode code point to return
  /// - Returns: The Unicode code point at the specified index
  public func codePointAt(_ index: Int) -> Int? {
    // 检查索引是否有效
    guard index >= 0, index < self.count else {
      return nil
    }

    // 获取指定索引的字符
    let charIndex = self.index(self.startIndex, offsetBy: index)

    // 获取字符的 Unicode 标量
    let unicodeScalars = self[charIndex...].unicodeScalars
    let firstScalar = unicodeScalars.first!

    // 返回 Unicode 码点
    return Int(firstScalar.value)
  }

  /// Concatenates the specified strings
  /// - Parameter strings: The strings to concatenate
  /// - Returns: A new string containing the concatenated strings
  public func concat(_ strings: String...) -> String {
    let mutableString = NSMutableString(string: self)

    for string in strings {
      mutableString.append(string)
    }
    return mutableString as String
  }

  /// Determines whether a string ends with the characters of a specified string
  /// - Parameter searchString: The string to search for
  /// - Parameter position: The position to start searching from
  /// - Returns: true if the string ends with the specified string, false otherwise
  public func endsWith(_ searchString: String, position: Int? = nil) -> Bool {
    let length = self.count
    let start = position ?? length
    let end = start - searchString.count
    return self[
      String.Index(utf16Offset: end, in: self)..<String.Index(utf16Offset: start, in: self)]
      == searchString
  }

  /// Determines whether a string includes the characters of a specified string
  /// - Parameter searchString: The string to search for
  /// - Parameter position: The position to start searching from
  /// - Returns: true if the string includes the specified string, false otherwise
  public func includes(_ searchString: String, position: Int? = nil) -> Bool {

    let start = position ?? 0
    let end = start + searchString.count
    return self[
      String.Index(utf16Offset: start, in: self)..<String.Index(utf16Offset: end, in: self)]
      == searchString
  }

  /// Returns the index of the first occurrence of a substring in a string
  /// - Parameter substring: The substring to search for
  /// - Parameter startIndex: The position to start searching from
  /// - Returns: The index of the first occurrence of the substring, or -1 if the substring is not found

  func indexOf(_ substring: String, startIndex: Int = 0) -> Int {
    // 检查起始索引是否有效
    guard startIndex >= 0, startIndex <= self.count else {
      return -1
    }

    // 将起始索引转换为字符串的索引
    let start = self.index(self.startIndex, offsetBy: startIndex)

    // 在从 startIndex 开始的子字符串中查找
    if let range = self[start...].range(of: substring) {
      // 返回找到的子字符串的起始索引
      return self.distance(from: self.startIndex, to: range.lowerBound)
    }

    return -1
  }

  /// Returns the index of the last occurrence of a substring in a string
  /// - Parameter substring: The substring to search for
  /// - Parameter startIndex: The position to start searching from
  /// - Returns: The index of the last occurrence of the substring, or -1 if the substring is not found
  public func lastIndexOf(_ substring: String, startIndex: Int? = nil) -> Int {
    // 处理空字符串情况
    if substring.isEmpty {
      let maxIndex = self.count
      let searchIndex = startIndex ?? maxIndex
      return min(searchIndex, maxIndex)
    }

    // 默认从字符串末尾开始查找
    let searchIndex = startIndex ?? self.count

    // 检查起始索引是否有效
    guard searchIndex >= 0 else {
      return -1
    }

    // 限制查找范围到 [0, searchIndex]
    let endOffset = min(searchIndex, self.count)
    guard endOffset > 0 else {
      return substring.isEmpty ? 0 : -1
    }

    // 将 endOffset 转换为字符串索引
    let endIndex = self.index(self.startIndex, offsetBy: endOffset)

    // 使用 backwards 选项进行反向查找
    if let range = self[..<endIndex].range(of: substring, options: .backwards) {
      // 返回找到的子字符串的起始索引
      return self.distance(from: self.startIndex, to: range.lowerBound)
    }

    // 未找到子字符串，返回 -1
    return -1
  }

  /// Compares two strings lexicographically
  /// - Parameter other: The string to compare to
  /// - Parameter locale: The locale to use for comparison
  /// - Parameter options: The options to use for comparison
  /// - Returns: A ComparisonResult indicating the lexical relationship between the two strings
  public func localeCompare(
    _ other: String, locale: Locale? = nil, options: String.CompareOptions = []
  ) -> ComparisonResult {
    // 使用指定的语言环境（默认使用当前语言环境）
    let comparisonLocale = locale ?? Locale.current

    return self.compare(other, options: options, range: nil, locale: comparisonLocale)
  }

  public enum NormalizationForm: String {
    case NFC
    case NFD
    case NFKC
    case NFKD
  }

  /// Normalizes the string to the specified form
  /// - Parameter form: The form to normalize the string to
  /// - Returns: The normalized string
  public func normalize(_ form: NormalizationForm = .NFC) -> String {
    switch form {
    case .NFC:
      return self.precomposedStringWithCanonicalMapping
    case .NFD:
      return self.decomposedStringWithCanonicalMapping
    case .NFKC:
      return self.precomposedStringWithCompatibilityMapping
    case .NFKD:
      return self.decomposedStringWithCompatibilityMapping
    }
  }

  public func padEnd(_ targetLength: Int, padString: String = " ") -> String {
    let count = self.count
    if count >= targetLength {
      return self
    }

    let padLength = targetLength - count
    let repeatPadString: Int = padLength / padString.length

    var paddedString = self + padString.repeat(repeatPadString)

    if paddedString.count < targetLength {
      let remainingLength = targetLength - paddedString.count
      paddedString += padString.slice(0, remainingLength)
    }
    return paddedString
  }

  /// Extracts a section of a string and returns it as a new string
  /// - Parameters:
  ///   - start: The index to the beginning of the specified portion of the string (inclusive)
  ///   - end: The index to the end of the specified portion of the string (exclusive)
  /// - Returns: A new string containing the extracted section of the string
  public func slice(_ start: Int, _ end: Int? = nil) -> String {
    let length = self.count

    // Handle start index, including negative indices
    var adjustedStart = start
    if start < 0 {
      adjustedStart = max(length + start, 0)
    } else {
      adjustedStart = min(start, length)
    }

    // Handle end index, including negative indices and nil
    var adjustedEnd = end ?? length
    if adjustedEnd < 0 {
      adjustedEnd = max(length + adjustedEnd, 0)
    } else {
      adjustedEnd = min(adjustedEnd, length)
    }

    // If start is greater than or equal to end, return empty string
    if adjustedStart >= adjustedEnd {
      return ""
    }

    // Calculate the string indices
    let startIndex = self.index(self.startIndex, offsetBy: adjustedStart)
    let endIndex = self.index(self.startIndex, offsetBy: adjustedEnd)

    // Return the substring
    return String(self[startIndex..<endIndex])
  }

  public func `repeat`(_ count: Int) -> String {
    return String(repeating: self, count: count)
  }

  /// Removes whitespace from both ends of a string
  /// - Returns: A new string with whitespace removed from both ends
  func trim() -> String {
    // 使用 Unicode 空白字符集
    return self.trimmingCharacters(in: .whitespacesAndNewlines)
  }

  /// Removes whitespace from the beginning of a string
  /// - Returns: A new string with whitespace removed from the beginning
  func trimStart() -> String {
    // 从开头移除空白字符
    var start = self.startIndex
    while start < self.endIndex, self[start].isWhitespace || self[start].isNewline {
      start = self.index(after: start)
    }
    return String(self[start...])
  }

  /// Removes whitespace from the end of a string
  /// - Returns: A new string with whitespace removed from the end
  func trimEnd() -> String {
    // 从结尾移除空白字符
    var end = self.endIndex
    while end > self.startIndex {
      let prev = self.index(before: end)
      if self[prev].isWhitespace || self[prev].isNewline {
        end = prev
      } else {
        break
      }
    }
    return String(self[..<end])
  }
  public var length: Int {
    return self.count
  }

}
