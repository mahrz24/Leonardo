//
//  DistanceParameterView.swift
//  Leonardo
//
//  Created by Malte Klemm on 07.11.21.
//

import SwiftUI

struct DistanceParameterView: View {
  @Binding var parameter: DistanceParameter
  var body: some View {
    Slider(value: $parameter.length, in: 1...5)
  }
}

struct DistanceParameterView_Previews: PreviewProvider {
  static var previews: some View {
    DistanceParameterView(parameter: .constant(DistanceParameter()))
  }
}
