//
//  ContentView.swift
//  Leonardo
//
//  Created by Malte Klemm on 27.10.21.
//

import SwiftUI

struct ContentView: View {
  @State var recording: Bool = false

  @Binding var document: LeonardoDocument
  @State var statementDrawer: [AnyStatement] = [GoStatement().asAnyStatement(), PenDownStatement().asAnyStatement(), PenUpStatement().asAnyStatement(),
                                                TurnStatement(angle: 90).asAnyStatement()]

  var body: some View {
    VStack {
      HStack {
        VStack {
          HStack {
            Button(role: .destructive) { document.stateProgram.statements = [] } label: { Image(systemName: "clear").foregroundColor(.red) }.buttonStyle(.bordered)
            Button { recording.toggle() } label: { Image(systemName: recording ? "record.circle.fill" : "record.circle").foregroundColor(.red) }.buttonStyle(.bordered)
            Button {
              document.stateProgram.statements.append(contentsOf: document.program.statements)
            } label: { Image(systemName: "play") }.buttonStyle(.borderedProminent)
          }
          List($document.program.statements) { $statement in
            StatementListView(statement: $statement)
          }
        }.frame(width: 250)
        LeonardoCanvas(statements: $document.stateProgram.statements)
        Spacer()
      }
      ScrollView(.horizontal) {
        HStack(spacing: 10) {
          ForEach($statementDrawer) { $statement in
            StatementView(statement: $statement).onTapGesture {
              document.stateProgram.statements.insert(statement.copy(), at: document.stateProgram.statements.count)
              if recording {
                document.program.statements.insert(statement.copy(), at: document.program.statements.count)
              }
            }
          }
          Spacer()
        }.frame(height: 100).padding(10)
      }.frame(height: 100)
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(document: .constant(LeonardoDocument()))
      .previewInterfaceOrientation(.landscapeLeft)
  }
}
