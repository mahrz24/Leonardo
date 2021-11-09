//
//  Parameter.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import Foundation

public enum ParameterType: String, Codable {
  case distance
  case angle
}

public protocol Parameter: Equatable, Identifiable, CustomStringConvertible {
  var id: UUID { get }
}

public protocol ConcreteParameter: Codable, Parameter {
  static var type: ParameterType { get }
}

public extension ConcreteParameter {
  func asAnyParameter() -> AnyParameter {
    AnyParameter(self)
  }
}

public extension ConcreteParameter {
  var description: String {
    "Parameter(\(Self.type))"
  }
}

private class AbstractParameter: Parameter, Encodable {
  var description: String { "AbstractParameter(\(type))" }

  public static func == (lhs: AbstractParameter, rhs: AbstractParameter) -> Bool {
    fatalError("Must override")
  }

  init<H: Parameter>(with parameter: H) {}

  var type: ParameterType { fatalError("Must override") }

  var id: UUID { fatalError("Must override") }

  func encode(to encoder: Encoder) throws {
    fatalError("Must override")
  }
}

private final class ParameterWrapper<H: ConcreteParameter>: AbstractParameter {
  var parameter: H

  init(with parameter: H) {
    self.parameter = parameter
    super.init(with: parameter)
  }

  required init(from decoder: Decoder) throws {
    fatalError("init(from:) has not been implemented")
  }

  override var type: ParameterType { H.type }

  override var id: UUID { parameter.id }

  public static func == (lhs: ParameterWrapper<H>, rhs: AbstractParameter) -> Bool {
    lhs.id == rhs.id
  }

  override func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(parameter)
  }
}

public struct AnyParameter: Parameter, Codable {
  private var abstractParameter: AbstractParameter

  public var description: String { "AnyParameter(\(type))" }

  public static func == (lhs: AnyParameter, rhs: AnyParameter) -> Bool {
    lhs.id == rhs.id
  }

  public var type: ParameterType { abstractParameter.type }
  public var id: UUID { abstractParameter.id }

  public init<T: ConcreteParameter>(_ parameter: T) {
    abstractParameter = ParameterWrapper(with: parameter)
  }

  private enum CodingKeys: CodingKey {
    case type, base
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let type = try container.decode(ParameterType.self, forKey: .type)
    switch type {
    case .distance:
      self.init(try container.decode(DistanceParameter.self, forKey: .base))
    case .angle:
      self.init(try container.decode(AngleParameter.self, forKey: .base))
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(abstractParameter.type, forKey: .type)
    try container.encode(abstractParameter, forKey: .base)
  }

  func unbox<B: ConcreteParameter>(as _: B.Type) -> B? {
    guard let unboxedBase = abstractParameter as? ParameterWrapper<B> else { return nil }
    return unboxedBase.parameter
  }
}
