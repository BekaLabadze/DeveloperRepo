//
//  SecondView.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import SwiftUI

struct SwiftUIView: View {
    let category: String
    @StateObject private var viewModel = ViewModel()
    @Environment(\.presentationMode) var presentationMode

    @State private var showWinningAnimation = false

    let allQuestions: [String: [(String, [String], Int)]] = [
        "Anime ⚔️": [
            ("👹🐊", ["Re:Zero", "Steins Gate", "Dorohedoro", "Ninja Kamui"], 2),
            ("🤠🎺🚀", ["Samurai Champloo", "Code Geass", "Cowboy Bebop", "Bleach"], 2),
            ("🐻🏔️⚔️🍜", ["Golden Kamuy", "Attack on Titan", "Vinland Saga", "Dororo"], 0),
            ("🍥👦🦊", ["Naruto", "One Piece", "Dragon Ball Z", "Bleach"], 0),
            ("👻⚔️🌊", ["Code Geass", "Demon Slayer", "Bleach", "Jujutsu Kaisen"], 2),
            ("👒🏴‍☠️🌊", ["One Piece", "Black Lagoon", "Naruto", "Fairy Tail"], 0),
            ("🗡️👹🌙", ["Attack on Titan", "Vinland Saga", "Berserk", "Claymore"], 2),
            ("🤴🌀🤖", ["Fullmetal Alchemist", "Code Geass", "Evangelion", "Steins Gate"], 1),
            ("📱🕰️🥼", ["Ninja Kamui", "Hellsing", "Evangelion", "Steins Gate"], 3),
            ("🤖⭕️", ["Demon Slayer", "Hellsing", "Evangelion", "Naruto"], 2),
        ],
        "Movies 🎥": [
            ("🎥🦈", ["Jaws", "Titanic", "Avatar", "Pirates Of Caribbean"], 0),
            ("🕶️🔴🔵", ["The Matrix", "Avatar", "The Incredibles", "Spiderman"], 0),
            ("🕷️👋🦸", ["Flash", "Batman", "Superman", "Spider-Man"], 3),
            ("🗡️🏃", ["Guardians of the Galaxy", "Blade Runner", "Dune", "Inception"], 1),
            ("😴⭕️", ["Inception", "The Dark Knight", "Forrest Gump", "Pulp Fiction"], 0),
            ("🏜️👑🪱", ["The Matrix", "Avengers: Endgame", "Dune", "Gladiator"], 2),
            ("🚗👴🚌", ["Scarface", "KingsMan", "The GodFather", "Bronx Tale"], 3),
            ("🦸‍♂️🌲🌍", ["Jurassic Park", "Star Wars", "Avengers", "Guardians of the Galaxy"], 3),
            ("🧍🧍‍♂️📜", ["Titanic", "The Silence of the Lambs", "Fight Club", "The Godfather"], 2),
            ("📚🕰️", ["Star Wars", "Back to the Future", "Interstellar", "Batman"], 2),
        ],
        "Books 📚": [
            ("🧙‍♂️📖", ["Harry Potter", "Twilight", "The Hobbit", "Percy Jackson"], 0),
            ("🐉🌄", ["Dune", "Game of Thrones", "The Shannara Chronicles", "The Hobbit"], 3),
            ("👩🐻‍❄️", ["The Chronicles of Narnia", "Crime and Punishment", "The Cather in the Rye", "The Great Gatsby"], 0),
            ("🐳⚓📖", ["The Odyssey", "Moby Dick", "The Lord of the Rings", "The Hobbit"], 1),
            ("👩‍🎤🎤", ["The Hunger Games", "Divergent", "Twilight", "The Maze Runner"], 0),
            ("🧛🌒👑", ["Twilight", "Dracula", "Vampire Diaries", "Interview with the Vampire"], 1),
            ("🌾🍞🎯", ["Divergent", "The Hobbit", "The Maze Runner", "The Hunger Games"], 3),
            ("🌊🏝️👦", ["Life of Pi", "Treasure Island", "Robinson Crusoe", "The Call of the Wild"], 2),
            ("🕵️🔍📜", ["Sherlock Holmes", "The Da Vinci Code", "Crime and Punishment", "Interview with the Vampire"], 0),
            ("🐞📖😱", ["The Myth of Sisyphus", "The Castle", "The Metamorphosis", "The Stranger"], 2),
        ],
    ]

    var body: some View {
        ZStack {
            GradientBackground()

            VStack(spacing: 20) {
                CustomNavigationBar(title: category) {
                    dismissView()
                }
                .padding(.top, -150)

                Text("Category: \(category)")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    .padding()

                Text("Score: \(viewModel.score)")
                    .font(.headline)
                    .foregroundColor(.white)

                if let questions = allQuestions[category], viewModel.currentQuestionIndex < questions.count {
                    let currentQuestion = questions[viewModel.currentQuestionIndex]

                    VStack {
                        Text(currentQuestion.0)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding()

                        ForEach(0..<currentQuestion.1.count, id: \.self) { index in
                            Button(action: {
                                viewModel.handleAnswer(selectedIndex: index, correctIndex: currentQuestion.2, totalQuestions: questions.count)
                                if viewModel.score == 10 {
                                    triggerWinningAnimation()
                                }
                            }) {
                                Text(currentQuestion.1[index])
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(viewModel.buttonColor(index: index, correctIndex: currentQuestion.2))
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .shadow(color: .black.opacity(0.5), radius: 5, x: 0, y: 2)
                            }
                            .padding(.horizontal)
                            .disabled(viewModel.selectedAnswerIndex != nil)
                        }
                    }
                    .padding()
                } else {
                    Text("You’ve answered all the questions!")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
            }
            .padding()

            if showWinningAnimation {
                WinningAnimationView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    private func triggerWinningAnimation() {
        withAnimation {
            showWinningAnimation = true
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            showWinningAnimation = false
            presentationMode.wrappedValue.dismiss()
        }
    }

    private func dismissView() {
        presentationMode.wrappedValue.dismiss()
    }
}

