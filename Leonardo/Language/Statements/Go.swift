//
//  Go.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import Foundation
import DynamicColor
import SwiftUI

struct GoStatement: ConcreteStatement {
  static var type: StatementType = .go

  var id: UUID = UUID()
  
  var distanceParameter: DistanceParameter = DistanceParameter()
  var parameters: [AnyParameter] { get { [distanceParameter.asAnyParameter()] } }
  
  var color: Color = Color(DynamicColor.blue.tinted(amount: 0.75))
  
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
    return GoStatement(id: UUID())
  }
  
  
}
