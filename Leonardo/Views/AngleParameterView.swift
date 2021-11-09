//
//  AngleParameterView.swift
//  Leonardo
//
//  Created by Malte Klemm on 07.11.21.
//

import SwiftUI

struct AngleParameterView: View {
  @Binding var parameter: AngleParameter
    var body: some View {
      Slider(value: $parameter.angle, in: -180...180)
    }
}

struct AngleParameterView_Previews: PreviewProvider {
    static var previews: some View {
        AngleParameterView(parameter: .constant(AngleParameter(angle: 90)))
    }
}
