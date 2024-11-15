//
//  QuestionScreenViewModel.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import Foundation

class QuestionScreenViewModel {
    var questionList: QuestionList?
    func loadQuestions() {
        
        guard let url = Bundle.main.url(forResource: "Questions", withExtension: "json") else {
            print("Failed to find file: Questions.json")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            
            let quizResponse = try JSONDecoder().decode(QuestionList.self, from: data)
            questionList = quizResponse
        } catch {
            print("Error reading or decoding JSON: \(error)")
            return
        }
    }
}
