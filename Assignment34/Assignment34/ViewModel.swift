//
//  ViewModel.swift
//  Assignment34
//
//  Created by Beka on 25.12.24.
//

import AVFoundation

class ViewModel: ObservableObject {
    @Published var isPlaying: Bool = false
    @Published var currentSong: String = ""
    @Published var currentTime: Double = 0
    @Published var duration: Double = 1

    private var audioPlayer: AVAudioPlayer?
    let songs = ["Illusion", "Changing Heart", "A Box of HeartBreaks with Blue Love", "I'm Good", "Small Talks"]

    func playSong(named song: String) {
        if currentSong == song && isPlaying {
            audioPlayer?.pause()
            isPlaying = false
        } else {
            if currentSong != song {
                currentSong = song
                if let url = Bundle.main.url(forResource: song, withExtension: "m4a") {
                    do {
                        audioPlayer = try AVAudioPlayer(contentsOf: url)
                        duration = audioPlayer?.duration ?? 1
                        audioPlayer?.play()
                        isPlaying = true
                        startTimer()
                    } catch {
                        print("Error loading song: \(error)")
                    }
                } else {
                    print("Song file not found")
                }
            } else {
                audioPlayer?.play()
                isPlaying = true
            }
        }
    }

    private func startTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if let player = self.audioPlayer {
                self.currentTime = player.currentTime
                if !player.isPlaying {
                    timer.invalidate()
                    self.isPlaying = false
                }
            }
        }
    }
}
