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
      // TODO: move execution out
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
    }
  }
}

struct LeonardoCanvas_Previews: PreviewProvider {
  static var previews: some View {
    LeonardoCanvas(statements: .constant([PenDownStatement().asAnyStatement(), GoStatement().asAnyStatement()]))
  }
}
