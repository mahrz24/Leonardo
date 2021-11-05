//
//  LeonardoContext.swift
//  Leonardo
//
//  Created by Malte Klemm on 04.11.21.
//

import Foundation
import SwiftUI

public struct LeonardoContext {
  var path: Path
  var position: CGPoint
  var angle: Angle
  var penDown: Bool
  var stepSize: Double
  
  init(withContext context: LeonardoContext) {
    self.position = context.position
    self.angle = context.angle
    self.penDown = context.penDown
    self.stepSize = context.stepSize
    self.path = context.path
  }
  
  init(position: CGPoint, angle: Angle, penDown: Bool, stepSize: Double) {
    self.position = position
    self.angle = angle
    self.penDown = penDown
    self.stepSize = stepSize
    self.path = Path()
    self.path.move(to: self.position)
  }
}
