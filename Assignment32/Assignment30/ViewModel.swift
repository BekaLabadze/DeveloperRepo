//
//  ViewModel.swift
//  Assignment30
//
//  Created by Beka on 10.12.24.
//

import Foundation
import SwiftUI

class TimerViewModel: ObservableObject {
    @Published var timers: [TimerModel] = []
    @Published var fastTimers: [FastTimer] = [
              FastTimer(name: "03:00", minutes: 3, seconds: 0, description: "დასვენება"),
              FastTimer(name: "07:00", minutes: 7, seconds: 0, description: "კარდიო"),
              FastTimer(name: "10:00", minutes: 10, seconds: 0, description: "ფიქრი"),
              FastTimer(name: "15:00", minutes: 15, seconds: 0, description: "შესვენება"),
              FastTimer(name: "20:00", minutes: 20, seconds: 0, description: "ყავის პაუზა"),
              FastTimer(name: "25:00", minutes: 25, seconds: 0, description: "ფორთხოალი"),
              FastTimer(name: "30:00", minutes: 30, seconds: 0, description: "მედიტაცია"),
              FastTimer(name: "45:00", minutes: 45, seconds: 0, description: "ვარჯიში"),
              FastTimer(name: "60:00", minutes: 60, seconds: 0, description: "სწავლა")
          ]

    var activeTimers: [UUID: Timer] = [:]

    func addTimer(name: String, minutes: Int, seconds: Int) {
        let originalDuration = String(format: "%02d:%02d:%02d", minutes / 60, minutes % 60, seconds)
        let newTimer = TimerModel(
            name: name,
            minutes: minutes,
            seconds: seconds,
            isRunning: false,
            originalDuration: originalDuration,
            usageHistory: [
                (date: "14 Dec 2024", time: originalDuration)
            ]
        )
        timers.append(newTimer)
    }


    func addFastTimer(_ fastTimer: FastTimer) {
        addTimer(name: fastTimer.description, minutes: fastTimer.minutes, seconds: fastTimer.seconds)
    }
    func removeTimer(timerID: UUID) {
        if let timer = activeTimers[timerID] {
            timer.invalidate()
            activeTimers[timerID] = nil
        }

        for i in 0..<timers.count {
            if timers[i].id == timerID {
                timers.remove(at: i)
                break
            }
        }
    }
    
    func resetTimer(timerID: UUID) {
        for i in 0..<timers.count {
            if timers[i].id == timerID {
                if timers[i].isRunning {
                    timers[i].isRunning = false
                    if let timer = activeTimers[timerID] {
                        timer.invalidate()
                        activeTimers[timerID] = nil
                    }
                }

                let components = timers[i].originalDuration.split(separator: ":").map { Int($0) ?? 0 }
                if components.count == 3 {
                    timers[i].minutes = components[0] * 60 + components[1]
                    timers[i].seconds = components[2]
                }
                break
            }
        }
    }
    
    func toggleTimer(timerID: UUID) {
        for i in 0..<timers.count {
            if timers[i].id == timerID {
                if timers[i].isRunning {
                    timers[i].isRunning = false
                    if let timer = activeTimers[timerID] {
                        timer.invalidate()
                        activeTimers[timerID] = nil
                    }

                    let currentDate = Date()
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM yyyy"
                    let dateString = formatter.string(from: currentDate)

                    let elapsedMinutes = timers[i].minutes
                    let elapsedSeconds = timers[i].seconds
                    let timeString = String(format: "%02d:%02d:%02d", elapsedMinutes / 60, elapsedMinutes % 60, elapsedSeconds)

                    timers[i].usageHistory.append((date: dateString, time: timeString))
                } else {
                    timers[i].isRunning = true
                    let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
                        guard let self = self else { return }

                        if self.timers[i].seconds > 0 {
                            self.timers[i].seconds -= 1
                        } else if self.timers[i].minutes > 0 {
                            self.timers[i].minutes -= 1
                            self.timers[i].seconds = 59
                        } else {
                            self.timers[i].isRunning = false
                            if let timer = self.activeTimers[timerID] {
                                timer.invalidate()
                                self.activeTimers[timerID] = nil
                            }
                        }
                    }
                    activeTimers[timerID] = timer
                }
                break
            }
        }
    }
}
