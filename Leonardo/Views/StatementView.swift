//
//  StatementView.swift
//  Leonardo
//
//  Created by Malte Klemm on 04.11.21.
//

import SwiftUI

struct StatementIconView: View {
  @Binding var statement: AnyStatement

  var body: some View {
    GeometryReader { geom in
      switch statement.type {
      case .go:
        GoIconView(size: geom.size, animate: .constant(true))
      case .penDown:
        GoIconView(size: geom.size, animate: .constant(true))
      case .penUp:
        GoIconView(size: geom.size, animate: .constant(true))
      case .turn:
        GoIconView(size: geom.size, animate: .constant(true))
      }
    }
  }
}

struct StatementContentView: View {
  @Binding var statement: AnyStatement
  
  var body: some View {
    HStack(spacing: 10) {
      StatementIconView(statement: $statement).frame(maxWidth: 100)
      ForEach($statement.parameters) { $parameter in
        ParameterView(parameter: $parameter)
      }
      Spacer()
    }
  }
}

struct StatementView: View {
  @Binding var statement: AnyStatement

  var body: some View {
    VStack {
      StatementContentView(statement: $statement)
    }.frame(minWidth: 200)
    .padding(10)
    .background(statement.color)
    .cornerRadius(20).padding(5)
  }
}

struct StatementListView: View {
  @Binding var statement: AnyStatement
  var body: some View {
    StatementContentView(statement: $statement).listRowBackground(statement.color)
  }
}

struct StatementView_Previews: PreviewProvider {
  static var previews: some View {
    VStack {
      ScrollView(.horizontal) {
        HStack(spacing: 0) {
          StatementView(statement: .constant(GoStatement().asAnyStatement()))
          StatementView(statement: .constant(PenDownStatement().asAnyStatement()))
          StatementView(statement: .constant(GoStatement().asAnyStatement()))
        }
      }.frame(height: 100)
      List {
        StatementListView(statement: .constant(GoStatement().asAnyStatement()))
        StatementListView(statement: .constant(TurnStatement(angle: 50).asAnyStatement()))
        StatementListView(statement: .constant(GoStatement().asAnyStatement()))
      }
    }
  }
}
