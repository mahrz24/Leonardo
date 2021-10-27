//
//  ContentView.swift
//  Leonardo
//
//  Created by Malte Klemm on 27.10.21.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: LeonardoDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(document: .constant(LeonardoDocument()))
    }
}
