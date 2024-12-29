//
//  WinningAnimation.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import SwiftUI

struct WinningAnimationView: View {
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0.0
    @State private var rotation: Double = 0.0

    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Text("You Won!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.yellow)
                    .scaleEffect(scale)
                    .opacity(opacity)
                    .rotationEffect(.degrees(rotation))
                    .onAppear {
                        withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                            scale = 1.2
                            opacity = 1.0
                            rotation = 360
                        }
                    }
            }
        }
    }
}
