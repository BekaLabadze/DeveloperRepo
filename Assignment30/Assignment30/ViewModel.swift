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
        let timer = TimerModel(name: name, minutes: minutes, seconds: seconds, isRunning: false)
        timers.append(timer)
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
