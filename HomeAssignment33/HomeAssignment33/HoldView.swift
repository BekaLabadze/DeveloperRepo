//
//  HoldView.swift
//  HomeAssignment33
//
//  Created by Beka on 18.12.24.
//

import SwiftUI

struct HoldView: View {
    @State private var didHold = false
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.top)
            
            if didHold {
                Image(.clearWheel)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.fullWheel)
                    .resizable()
                    .scaledToFit()
                    .onLongPressGesture(minimumDuration: 5) {
                        withAnimation {
                            didHold = true
                        }
                    }
            }
        }
    }
}
