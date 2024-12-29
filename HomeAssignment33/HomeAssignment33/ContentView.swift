//
//  ContentView.swift
//  HomeAssignment33
//
//  Created by Beka on 18.12.24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            SpinView()
                .tabItem {
                    Image(systemName: "steeringwheel")
                    Text("Spin")
                }
            
            HoldView()
                .tabItem {
                    Image(systemName: "hand.tap")
                    Text("Hold")
                }
            
            RotateView()
                .tabItem {
                    Image(systemName: "arrow.clockwise")
                    Text("Rotate")
                }
            
            TrashView()
                .tabItem {
                    Image(systemName: "trash")
                    Text("Trash")
                }
        }
        .accentColor(.green)
    }
}

#Preview {
    ContentView()
}
