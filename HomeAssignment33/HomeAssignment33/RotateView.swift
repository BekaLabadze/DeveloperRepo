//
//  RotateView.swift
//  HomeAssignment33
//
//  Created by Beka on 18.12.24.
//

import SwiftUI

struct RotateView: View {
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.top)
            
            Image(.calculator)
                .resizable()
                .frame(width: 150, height: 150)
                .rotationEffect(.degrees(rotationAngle))
                .gesture(
                    RotationGesture()
                        .onChanged { value in
                            rotationAngle = value.degrees
                        }
                        .onEnded { value in
                            rotationAngle += value.degrees
                        }
                )
        }
    }
}
