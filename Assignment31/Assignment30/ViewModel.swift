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
    var activeTimers: [UUID: Timer] = [:]
    
    func addTimer(name: String, minutes: Int, seconds: Int) {
        let originalDuration = String(format: "%02d:%02d:%02d", minutes / 60, minutes % 60, seconds)
        
        let newTimer = TimerModel(
            name: name,
            minutes: minutes,
            seconds: seconds,
            isRunning: false,
            originalDuration: originalDuration
        )
            timers.append(newTimer)
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
                
                timers[i].minutes = 0
                timers[i].seconds = 0
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
