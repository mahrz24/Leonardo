//
//  LeonardoApp.swift
//  Leonardo
//
//  Created by Malte Klemm on 27.10.21.
//

import SwiftUI

@main
struct LeonardoApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: LeonardoDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
