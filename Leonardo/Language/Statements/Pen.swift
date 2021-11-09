//
//  Go.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import Foundation
import DynamicColor
import SwiftUI

struct PenDownStatement: ConcreteStatement {
  static var type: StatementType = .penDown

  var id: UUID = UUID()
  
  var parameters: [AnyParameter] { get { [] }  set { } }
  var color: Color = Color(DynamicColor.red.tinted(amount: 0.75))
  
  enum CodingKeys: String, CodingKey {
    case id
  }
  
  func copy() -> PenDownStatement {
    return PenDownStatement(id: UUID())
  }
  
  func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    var ctx = LeonardoContext(withContext: leonardoContext)
    ctx.penDown = true
    return ctx
  }
}

struct PenUpStatement: ConcreteStatement {
  static var type: StatementType = .penUp

  var id: UUID = UUID()
  
  var parameters: [AnyParameter] { get { [] } set {} }
  var color: Color = Color(DynamicColor.red.tinted(amount: 0.5))
  
  enum CodingKeys: String, CodingKey {
    case id
  }
  
  func copy() -> PenUpStatement {
    return PenUpStatement(id: UUID())
  }
  
  func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    var ctx = LeonardoContext(withContext: leonardoContext)
    ctx.penDown = false
    return ctx
  }
}
