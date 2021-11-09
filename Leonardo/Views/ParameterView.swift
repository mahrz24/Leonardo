//
//  ParameterView.swift
//  Leonardo
//
//  Created by Malte Klemm on 07.11.21.
//

import SwiftUI


struct ParameterView: View {
  @Binding var parameter: AnyParameter
  var body: some View {
    switch parameter.type {
    case .angle:
      let binding = Binding<AngleParameter>(
        get: { parameter.unbox(as: AngleParameter.self)! },
        set: { parameter = $0.asAnyParameter() })
      AngleParameterView(parameter: binding)
    case .distance:
      let binding = Binding<DistanceParameter>(
        get: { parameter.unbox(as: DistanceParameter.self)! },
        set: { parameter = $0.asAnyParameter() })
      DistanceParameterView(parameter: binding)
    }
  }
}

struct ParameterView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ParameterView(parameter: .constant(DistanceParameter().asAnyParameter()))
      ParameterView(parameter: .constant(AngleParameter().asAnyParameter()))
    }
  }
}
