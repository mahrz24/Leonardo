//
//  Go.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import DynamicColor
import Foundation
import SwiftUI

struct TurnStatement: ConcreteStatement {
  static var type: StatementType = .turn

  var id = UUID()
  
  var angleParameter = AngleParameter()
  var parameters: [AnyParameter] {
    get { [self.angleParameter.asAnyParameter()] }
    set {
      self.angleParameter = newValue[0].unbox(as: AngleParameter.self)!
    }
  }
  
  init(angle: Double) {
    self.angleParameter = AngleParameter(angle: angle)
  }
  
  init(id: UUID, angleParameter: AngleParameter) {
    self.id = id
    self.angleParameter = angleParameter
  }
  
  var color = Color(DynamicColor.purple.tinted(amount: 0.75))
  
  enum CodingKeys: String, CodingKey {
    case id
  }
  
  func copy() -> TurnStatement {
    TurnStatement(id: UUID(), angleParameter: self.angleParameter)
  }
  
  func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    var ctx = LeonardoContext(withContext: leonardoContext)
    ctx.angle += Angle(degrees: self.angleParameter.angle)
    return ctx
  }
}
