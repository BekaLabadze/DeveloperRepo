//
//  GradientBackGround.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import SwiftUI

struct GradientBackground: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color.black, Color.gray]),
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}
