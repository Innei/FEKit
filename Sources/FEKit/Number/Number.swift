//
//  Number.swift
//  FEKit
//
//  Number utilities inspired by lodash
//

import Foundation

/// Number utilities

public enum Number {
  public static func toFixed(_ value: Double, digits: Int? = nil) -> String {
    return String(format: "%.\(digits ?? 2)f", value)
  }
}
