//
//  Object.swift
//  FEKit
//
//  Object utilities inspired by lodash
//

import Foundation

/// Object utilities
extension FEKit {
  public enum Object {
    /// Assigns own enumerable string keyed properties of source objects to the destination object
    /// - Parameters:
    ///   - object: The destination object
    ///   - sources: The source objects
    /// - Returns: The destination object
    public static func assign<T: NSObject>(_ object: T, sources: [T]) -> T {
      let result = object

      for source in sources {
        let mirror = Mirror(reflecting: source)
        for (label, value) in mirror.children {
          guard let label = label else { continue }
          result.setValue(value, forKey: label)
        }
      }

      return result
    }

  }
}
