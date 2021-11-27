//
//  Statement.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import Foundation
import SwiftUI

public enum StatementType: String, Codable {
  case go
  case penDown
  case penUp
  case turn
}

public protocol Statement: Equatable, Identifiable, CustomStringConvertible {
  var id: UUID { get }
  var parameters: [AnyParameter] { get set }
  var color: Color { get }
    
  func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext
}

public protocol ConcreteStatement: Codable, Statement {
  static var type: StatementType { get }
  func copy() -> Self
}

public extension ConcreteStatement {
  func asAnyStatement() -> AnyStatement {
    AnyStatement(self)
  }
}

public extension ConcreteStatement {
  var description: String {
    "Statement(\(Self.type))"
  }
}

private class AbstractStatement: Statement, Encodable {
  var description: String { "AbstractStatement(\(type))" }

  public static func == (lhs: AbstractStatement, rhs: AbstractStatement) -> Bool {
    fatalError("Must override")
  }

  init<H: Statement>(with statement: H) {}

  var type: StatementType { fatalError("Must override") }

  var id: UUID { fatalError("Must override") }
  var parameters: [AnyParameter] { get { fatalError("Must override") } set { fatalError("Must override") } }
  var color: Color { fatalError("Must override") }
  
  func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    fatalError("Must override")
  }


  func encode(to encoder: Encoder) throws {
    fatalError("Must override")
  }
  
}

private final class StatementWrapper<H: ConcreteStatement>: AbstractStatement {
  var statement: H

  init(with statement: H) {
    self.statement = statement
    super.init(with: statement)
  }

  required init(from decoder: Decoder) throws {
    fatalError("init(from:) has not been implemented")
  }

  override var type: StatementType { H.type }

  override var id: UUID { statement.id }

  override var parameters: [AnyParameter] { get { statement.parameters } set { statement.parameters = newValue } }
  override var color: Color { statement.color }
  
  override func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    statement.execute(leonardoContext, graphicsContext)
  }

  public static func == (lhs: StatementWrapper<H>, rhs: AbstractStatement) -> Bool {
    lhs.id == rhs.id
  }

  override func encode(to encoder: Encoder) throws {
    var container = encoder.singleValueContainer()
    try container.encode(statement)
  }
  
}

public struct AnyStatement: Statement, Codable {
  private var abstractStatement: AbstractStatement

  public var description: String { "AnyStatement(\(type))" }

  public static func == (lhs: AnyStatement, rhs: AnyStatement) -> Bool {
    lhs.id == rhs.id
  }

  public var type: StatementType { abstractStatement.type }
  public var id: UUID { abstractStatement.id }
  public var parameters: [AnyParameter] { get { abstractStatement.parameters } set { abstractStatement.parameters = newValue } }
  public var color: Color { abstractStatement.color }
  
  public func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    abstractStatement.execute(leonardoContext, graphicsContext)
  }

  public init<T: ConcreteStatement>(_ statement: T) {
    abstractStatement = StatementWrapper(with: statement)
  }

  private enum CodingKeys: CodingKey {
    case type, base
  }

  public init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    let type = try container.decode(StatementType.self, forKey: .type)
    switch type {
    case .go:
      self.init(try container.decode(GoStatement.self, forKey: .base))
    case .penDown:
      self.init(try container.decode(PenDownStatement.self, forKey: .base))
    case .penUp:
      self.init(try container.decode(PenUpStatement.self, forKey: .base))
    case .turn:
      self.init(try container.decode(TurnStatement.self, forKey: .base))
    }
  }

  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(abstractStatement.type, forKey: .type)
    try container.encode(abstractStatement, forKey: .base)
  }

  func unbox<B: ConcreteStatement>(as _: B.Type) -> B? {
    guard let unboxedBase = abstractStatement as? StatementWrapper<B> else { return nil }
    return unboxedBase.statement
  }
  
  func copy() -> AnyStatement {
    let type = abstractStatement.type
    switch type {
    case .go:
      if let unboxed = self.unbox(as: GoStatement.self) {
        return unboxed.copy().asAnyStatement()
      } else {
        fatalError("Internal type and boxed type do not match.")
      }
    case .penDown:
      if let unboxed = self.unbox(as: PenDownStatement.self) {
        return unboxed.copy().asAnyStatement()
      } else {
        fatalError("Internal type and boxed type do not match.")
      }
    case .penUp:
      if let unboxed = self.unbox(as: PenUpStatement.self) {
        return unboxed.copy().asAnyStatement()
      } else {
        fatalError("Internal type and boxed type do not match.")
      }
    case .turn:
      if let unboxed = self.unbox(as: TurnStatement.self) {
        return unboxed.copy().asAnyStatement()
      } else {
        fatalError("Internal type and boxed type do not match.")
      }
    }
  }
}
