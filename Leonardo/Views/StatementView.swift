//
//  StatementView.swift
//  Leonardo
//
//  Created by Malte Klemm on 04.11.21.
//

import SwiftUI

struct StatementView: View {
  @Binding var statement: AnyStatement

  var body: some View {
    Text(statement.description).background(statement.color).listRowBackground(statement.color)
  }
}

struct StatementView_Previews: PreviewProvider {
  static var previews: some View {
    StatementView(statement: .constant(GoStatement().asAnyStatement()))
  }
}
