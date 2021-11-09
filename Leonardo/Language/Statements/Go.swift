//
//  Go.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import DynamicColor
import Foundation
import SwiftUI

struct GoStatement: ConcreteStatement {
  static var type: StatementType = .go

  var id = UUID()
  
  var distanceParameter = DistanceParameter()
  var parameters: [AnyParameter] {
    get { [self.distanceParameter.asAnyParameter()] }
    set {
      self.distanceParameter = newValue[0].unbox(as: DistanceParameter.self)!
    }
  }
  
  init(distance: Double = 1) {
    self.distanceParameter = DistanceParameter(distance: distance)
  }
  
  init(id: UUID, distanceParameter: DistanceParameter) {
    self.id = id
    self.distanceParameter = distanceParameter
  }
  
  var color = Color(DynamicColor.blue.tinted(amount: 0.75))
  
  func execute(_ leonardoContext: LeonardoContext, _ graphicsContext: GraphicsContext) -> LeonardoContext {
    var ctx = LeonardoContext(withContext: leonardoContext)
    ctx.position.x += sin(ctx.angle.radians) * self.distanceParameter.length * ctx.stepSize
    ctx.position.y -= cos(ctx.angle.radians) * self.distanceParameter.length * ctx.stepSize
    
    if ctx.penDown {
      ctx.path.addLine(to: ctx.position)
    } else {
      ctx.path.move(to: ctx.position)
    }
    return ctx
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case distanceParameter
  }
  
  func copy() -> GoStatement {
    GoStatement(id: UUID(), distanceParameter: self.distanceParameter)
  }
}
