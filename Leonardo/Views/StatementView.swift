//
//  StatementView.swift
//  Leonardo
//
//  Created by Malte Klemm on 04.11.21.
//

import SwiftUI

struct StatementContentView : View {
  @Binding var statement: AnyStatement
  var gridColumns: [GridItem]
  
  var body: some View {
    LazyVGrid(columns: gridColumns) {
      Text(statement.description)
      ForEach($statement.parameters) { $parameter in
        ParameterView(parameter: $parameter)
      }
    }
  }
}

struct StatementView: View {
  @Binding var statement: AnyStatement
  
  var body: some View {
    VStack {
      StatementContentView(statement: $statement, gridColumns: [GridItem(.flexible()), GridItem(.flexible())])
      Spacer()
    }
    .padding(10)
    .background(statement.color)
    .cornerRadius(10)
  }
}

struct StatementListView: View {
  @Binding var statement: AnyStatement
  var body: some View {
    StatementContentView(statement: $statement, gridColumns: [GridItem(.flexible())]).listRowBackground(statement.color)
  }
}

struct StatementView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      HStack {
        StatementView(statement: .constant(GoStatement().asAnyStatement()))
        StatementView(statement: .constant(PenDownStatement().asAnyStatement()))
        StatementView(statement: .constant(GoStatement().asAnyStatement()))
      }.frame(height: 100)
      List {
        StatementListView(statement: .constant(GoStatement().asAnyStatement()))
        StatementListView(statement: .constant(TurnStatement(angle: 50).asAnyStatement()))
        StatementListView(statement: .constant(GoStatement().asAnyStatement()))
      }
    }
  }
}
