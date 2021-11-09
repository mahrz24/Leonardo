//
//  DistanceParameter.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import Foundation
import SwiftUI

struct AngleParameter: ConcreteParameter {
  static var type: ParameterType = .angle
  var id: UUID = UUID()
  var angle: Double = 0
  
  init () {
    
  }
  
  init(angle: Double) {
    self.angle = angle
  }
}
