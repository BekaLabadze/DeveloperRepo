//
//  ContentView.swift
//  Assignment34
//
//  Created by Beka on 25.12.24.
//

import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                List(viewModel.songs, id: \.self) { song in
                    HStack {
                        Text(song)
                            .foregroundColor(.white)
                        Spacer()
                        Button(action: {
                            viewModel.playSong(named: song)
                        }) {
                            Image(systemName: viewModel.currentSong == song && viewModel.isPlaying ? "pause.circle" : "play.circle")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                        }
                    }
                    .listRowBackground(Color(UIColor.init(red: 0.1, green: 0.1, blue: 0.15, alpha: 1.0)))
                }
                .background(Color(UIColor.init(red: 0.1, green: 0.1, blue: 0.15, alpha: 1.0)))
                .scrollContentBackground(.hidden)
                
                HStack {
                    Image(systemName: "waveform.circle")
                        .padding(.trailing, -20)
                    Text("Now Playing: \(viewModel.currentSong)")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                ProgressBar(currentTime: $viewModel.currentTime, duration: $viewModel.duration)
                    .frame(height: 50)
                    .padding()
                
                Spacer()

                Link("Check out Naive Man's Youtube Channel", destination: URL(string: "https://www.youtube.com/@naiveman")!)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding()
            }
            .background(Color(UIColor.init(red: 0.1, green: 0.1, blue: 0.15, alpha: 1.0)))
            .navigationTitle("Naive Man Music Player")
            .foregroundColor(.white)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
