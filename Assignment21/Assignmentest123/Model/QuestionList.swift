//
//  QuestionList.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import Foundation

struct Questions: Codable {
    var questionNumber: String
    var question: String
    var difficulty: String
    var category: String
    var correct_answer: String
    var incorrect_answers: [String]
}

struct QuestionList: Codable {
    var results: [Questions]
}
