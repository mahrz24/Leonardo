//
//  LeonardoDocument.swift
//  Leonardo
//
//  Created by Malte Klemm on 27.10.21.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
  static var leonardoProgram: UTType {
    UTType(exportedAs: "de.malteklemm.leonardo.program")
  }
}

struct LeonardoDocument: FileDocument {
  var program: Program
  var stateProgram: Program

  init(program: Program = Program(statements: [GoStatement().asAnyStatement(), PenDownStatement().asAnyStatement()]), stateProgram: Program = Program(statements: [])) {
    self.program = program
    self.stateProgram = stateProgram
  }

  static var readableContentTypes: [UTType] { [.leonardoProgram] }

  init(configuration: ReadConfiguration) throws {
    guard let data = configuration.file.regularFileContents else {
      throw CocoaError(.fileReadCorruptFile)
    }
    let programs = try JSONDecoder().decode([Program].self, from: data)
    self.program = programs[0]
    self.stateProgram = programs[1]
  }

  func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
    let data = try JSONEncoder().encode([self.program, self.stateProgram])
    return .init(regularFileWithContents: data)
  }
}
