//
//  FastTimerSheet.swift
//  Assignment30
//
//  Created by Beka on 14.12.24.
//

import SwiftUI

struct FastTimerSheet: View {
    @ObservedObject var viewModel: TimerViewModel
    @Environment(\.presentationMode) var presentationMode

    let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            Text("სწრაფი ტაიმერები")
                .font(.headline)
                .padding()
                .foregroundColor(.white)

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(viewModel.fastTimers) { fastTimer in
                    Button(action: {
                        viewModel.addFastTimer(fastTimer)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        VStack {
                            Text(fastTimer.name)
                                .font(.headline)
                                .foregroundColor(.blue)
                            Text(fastTimer.description)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                    }
                }
            }
            .padding()
            .ignoresSafeArea()
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255))
        .presentationDetents([.fraction(0.5)])
    }
}
