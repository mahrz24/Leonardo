//
//  LeonardoCanvas.swift
//  Leonardo
//
//  Created by Malte Klemm on 04.11.21.
//

import SwiftUI

struct LeonardoCanvas: View {
  @Binding var statements: [AnyStatement]

  var body: some View {
    Canvas { graphicsContext, size in
      
      let turtle = graphicsContext.resolveSymbol(id: 0)!
      
      let midpoint = CGPoint(x: size.width / 2, y: size.height / 2)
      var leonardoContext = LeonardoContext(
        position: midpoint,
        angle: Angle(degrees: 0),
        penDown: true,
        stepSize: min(size.width, size.height) / 20
      )

      for statement in statements {
        leonardoContext = statement.execute(leonardoContext, graphicsContext)
      }
      graphicsContext.stroke(leonardoContext.path, with: .color(.black))
      
      // Draw the turtle
      graphicsContext.translateBy(x: leonardoContext.position.x, y: leonardoContext.position.y)
      graphicsContext.rotate(by: leonardoContext.angle)
      graphicsContext.scaleBy(x: 0.5, y: 0.5)
      graphicsContext.draw(turtle, at: .init(x: 0, y: 0), anchor: .center)
      
    } symbols: {
      Image("turtle").tag(0)
    }
  }
}

struct LeonardoCanvas_Previews: PreviewProvider {
  static var previews: some View {
    LeonardoCanvas(statements: .constant([PenDownStatement().asAnyStatement(), GoStatement().asAnyStatement(), TurnStatement(angle: 30).asAnyStatement()]))
  }
}
