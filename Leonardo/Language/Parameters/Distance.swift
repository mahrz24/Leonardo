//
//  DistanceParameter.swift
//  Leonardo
//
//  Created by Malte Klemm on 30.10.21.
//

import Foundation

struct DistanceParameter: ConcreteParameter {
  static var type: ParameterType = .distance
  var id: UUID = UUID()
  
  var length: Double = 1.0
  
  init () {
    
  }
  
  init(distance: Double) {
    self.length = distance
  }
}
