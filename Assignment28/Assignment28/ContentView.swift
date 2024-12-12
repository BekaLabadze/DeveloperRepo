//
//  ContentView.swift
//  Assignment28
//
//  Created by Beka on 06.12.24.
//

import SwiftUI

struct ContentView: View {
    @State var isOnline: Bool = false
    let skills = ["Swift UI", "iOS Development", "Problem Solving", "UI/UX Design"]
    var body: some View {
        ZStack{
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(.sRGB, red: 0, green: 0, blue: 255/255, opacity: 0.65),
                    Color(.sRGB, red: 128/255, green: 0, blue: 128/255, opacity: 0.65)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack {
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 120, height: 120)
                    .overlay (
                        Image(.profile)
                    )
                if isOnline {
                    Text("Online")
                        .padding(5)
                        .background(
                            Color.green
                                .clipShape(Capsule())
                        )
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: -20, leading: 90, bottom: 0, trailing: 0))
                } else {
                    Text("Offline")
                        .padding(5)
                        .background(
                            Color.red
                                .clipShape(Capsule())
                        )
                        .foregroundStyle(.white)
                        .padding(EdgeInsets(top: -20, leading: 90, bottom: 0, trailing: 0))
                }
                Text("John Doe")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundStyle(.white)
                Text("iOS Developer")
                    .foregroundStyle(.white)
                    .opacity(0.8)
                HStack(spacing: 30){
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2))
                        .overlay (
                            Image(systemName: "phone")
                                .foregroundStyle(.white)
                        )
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2))
                        .overlay (
                            Image(systemName: "envelope")
                                .foregroundStyle(.white)
                        )
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(Color(.sRGB, red: 0, green: 0, blue: 0, opacity: 0.2))
                        .overlay (
                            Image(systemName: "globe")
                                .foregroundStyle(.white)
                        )
                }
                .padding(5)
                VStack(alignment: .leading) {
                    
                    Text("Skills")
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold))
                        .opacity(0.85)
                        .padding(.leading, -10)
                    ForEach(skills, id: \.self) { skills in
                        HStack{
                            Circle()
                                .frame(width: 5, height: 5)
                                .foregroundStyle(.white)
                            Text(skills)
                                .padding(5)
                                .foregroundStyle(.white)
                                .opacity(0.7)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(EdgeInsets(top: 50, leading: 20, bottom: -50, trailing: 0))
                Spacer()
                    .frame(height: 190)
                
                    Rectangle()
                        .foregroundStyle(.white)
                        .clipShape(Capsule())
                        .frame(width: 190, height: 44)
                        .overlay(
                            HStack() {
                                Toggle(isOn: $isOnline) {
                                Text(isOnline ? "Set Offline" : "Set Online")
                            }
                        }
                                .padding()
                    )
            }
        }
        
    }
}

#Preview {
    ContentView()
}

