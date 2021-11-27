//
//  GoIconView.swift
//  Leonardo
//
//  Created by Malte Klemm on 10.11.21.
//

import SwiftUI

struct GoIconContentView: View {
  @State var top: Bool = false
  @Binding var animate: Bool

  var size = CGSize()
  var turtleSize: Double { min(self.size.width, self.size.height) * 0.3 }

  let date: Date

  var body: some View {
    ZStack {
      HStack {
        Image(systemName: "arrow.up").padding(10)
        if animate {
          Spacer()
        }
      }
      if animate {
        HStack {
          Image("turtle").resizable().scaledToFit().frame(width: turtleSize, height: turtleSize).offset(x: 0, y: top ? -turtleSize : turtleSize)
        }.animation(.easeIn(duration: 1 * (top ? 1 : 0)), value: top)
          .onChange(of: date) { _ in
            if animate {
              beat()
            }
          }
          .onAppear { beat() }.frame(width: size.width, height: size.height)
      }
    }.frame(width: size.width, height: size.height).background(Color.blue.cornerRadius(5))
  }

  func beat() {
    self.top.toggle()
  }
}

struct GoIconView: View {
  var size: CGSize
  @Binding var animate: Bool

  var body: some View {
    TimelineView(.periodic(from: .now, by: 1)) { timeline in
      GoIconContentView(animate: $animate, size: size, date: timeline.date)
    }
  }
}

struct GoIconView_Previews: PreviewProvider {
  static var previews: some View {
    HStack {
      GoIconView(size: CGSize(width: 100, height: 100), animate: .constant(true))
      GoIconView(size: CGSize(width: 100, height: 100), animate: .constant(false))
    }
  }
}
