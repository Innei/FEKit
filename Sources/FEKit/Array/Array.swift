//
//  Array.swift
//  FEKit
//
//  Array utilities inspired by lodash
//

import Foundation

/// Array utilities
extension FEKit {
  public enum Array {
    /// Returns the first element of an array
    /// - Parameter array: The array to query
    /// - Returns: The first element of the array or nil if array is empty
    public static func first<T>(_ array: [T]) -> T? {
      return array.first
    }
 
  }
}
