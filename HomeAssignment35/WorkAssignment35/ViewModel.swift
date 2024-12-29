//
//  ViewModel.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published var score: Int {
        didSet {
            saveScore()
        }
    }
    @Published var currentQuestionIndex = 0
    @Published var selectedAnswerIndex: Int? = nil
    @Published var showWinAlert = false

    private let scoreKey = "SavedScore"

    init() {
        self.score = UserDefaults.standard.integer(forKey: scoreKey)
    }

    func buttonColor(index: Int, correctIndex: Int) -> Color {
        if let selected = selectedAnswerIndex {
            if index == correctIndex {
                return .green
            } else if index == selected {
                return .red
            }
        }
        return .blue
    }

    func handleAnswer(selectedIndex: Int, correctIndex: Int, totalQuestions: Int) {
        selectedAnswerIndex = selectedIndex

        if selectedIndex == correctIndex {
            score += 1
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            if self.score == 10 {
                self.showWinAlert = true
                self.resetGame()
            } else if self.currentQuestionIndex + 1 < totalQuestions {
                self.currentQuestionIndex += 1
                self.selectedAnswerIndex = nil
            }
        }
    }

    func resetGame() {
        score = 0
        currentQuestionIndex = 0
        selectedAnswerIndex = nil
    }

    private func saveScore() {
        UserDefaults.standard.set(score, forKey: scoreKey)
    }
}
