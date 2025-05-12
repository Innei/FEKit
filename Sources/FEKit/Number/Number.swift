//
//  Number.swift
//  FEKit
//
//  Number utilities inspired by lodash
//

import Foundation

/// Number utilities
extension FEKit {
  public enum Number {

    /// Produces a random floating point number between min and max (inclusive)
    /// - Parameters:
    ///   - min: The minimum possible value
    ///   - max: The maximum possible value
    /// - Returns: The random number
    public static func random(min: Double, max: Double) -> Double {
      guard min <= max else { return min }
      return Double.random(in: min...max)
    }
  }
}
