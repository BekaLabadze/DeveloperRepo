//
//  Model.swift
//  Assignment30
//
//  Created by Beka on 10.12.24.
//
import Foundation

struct TimerModel: Identifiable {
    let id = UUID()
    var name: String
    var minutes: Int
    var seconds: Int
    var isRunning: Bool
    var originalDuration: String
    var usageHistory: [(date: String, time: String)] = []
}
