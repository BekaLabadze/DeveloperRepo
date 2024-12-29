//
//  SpinView.swift
//  HomeAssignment33
//
//  Created by Beka on 18.12.24.
//

import SwiftUI

struct SpinView: View {
    @State private var rotation: Double = 0
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.top)
            VStack {
                Image(.fullWheel)
                    .resizable()
                    .scaledToFit()
                    .rotationEffect(.degrees(rotation))
                    .gesture(
                        DragGesture()
                            .onChanged { value in
                                rotation += Double(value.translation.height) / 2
                            }
                    )
            }
        }
    }
}
