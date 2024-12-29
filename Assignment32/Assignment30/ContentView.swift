//
//  ContentView.swift
//  Assignment30
//
//  Created by Beka on 10.12.24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = TimerViewModel()
    @State private var timerName: String = ""
    @State private var hoursInput: String = ""
    @State private var minutesInput: String = ""
    @State private var secondsInput: String = ""
    @State private var showFastTimerSheet: Bool = false
    @State private var selectedTimer: TimerModel?

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("ტაიმერები")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 16)

                    Button(action: {
                        showFastTimerSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.largeTitle)
                            .foregroundColor(.blue)
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical, 8)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

                ScrollView {
                    ForEach(viewModel.timers) { timer in
                        TimerRow(timer: timer, viewModel: viewModel)
                            .onTapGesture {
                                selectedTimer = timer
                            }
                    }
                }

                VStack {
                    ZStack(alignment: .leading) {
                        if timerName.isEmpty {
                            Text("ტაიმერის სახელი...")
                                .foregroundColor(Color.white.opacity(0.6))
                                .padding(.leading, 15)
                        }
                        TextField("", text: $timerName)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                    }
                    .padding(.bottom, 8)

                    HStack {
                        ZStack(alignment: .leading) {
                            if hoursInput.isEmpty {
                                Text("საათი (სთ)")
                                    .foregroundColor(Color.white.opacity(0.6))
                                    .padding(.leading, 15)
                            }
                            TextField("", text: $hoursInput)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
                        }

                        ZStack(alignment: .leading) {
                            if minutesInput.isEmpty {
                                Text("წუთი (წთ)")
                                    .foregroundColor(Color.white.opacity(0.6))
                                    .padding(.leading, 15)
                            }
                            TextField("", text: $minutesInput)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
                        }

                        ZStack(alignment: .leading) {
                            if secondsInput.isEmpty {
                                Text("წამი (წმ)")
                                    .foregroundColor(Color.white.opacity(0.6))
                                    .padding(.leading, 15)
                            }
                            TextField("", text: $secondsInput)
                                .padding()
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(8)
                                .foregroundColor(.white)
                                .keyboardType(.numberPad)
                        }
                    }
                    .padding(.bottom, 8)

                    Button(action: {
                        let hours = Int(hoursInput) ?? 0
                        let minutes = Int(minutesInput) ?? 0
                        let seconds = Int(secondsInput) ?? 0
                        if hours >= 0, minutes >= 0, seconds >= 0 {
                            viewModel.addTimer(
                                name: timerName.isEmpty ? "Untitled Timer" : timerName,
                                minutes: hours * 60 + minutes,
                                seconds: seconds
                            )
                            timerName = ""
                            hoursInput = ""
                            minutesInput = ""
                            secondsInput = ""
                        }
                    }) {
                        Text("დამატება")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            .background(Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255).edgesIgnoringSafeArea(.all))
            .sheet(item: $selectedTimer) { timer in
                DetailsPage(timer: timer)
            }
            .sheet(isPresented: $showFastTimerSheet) {
                FastTimerSheet(viewModel: viewModel)
                    .presentationDetents([.fraction(0.5)]) 
            }
        }
    }
}


struct TimerRow: View {
    let timer: TimerModel
    @ObservedObject var viewModel: TimerViewModel

    var body: some View {
        VStack {
            HStack {
                Text(timer.name)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.leading, 8)
                Spacer()
                Button(action: { viewModel.removeTimer(timerID: timer.id) }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                        .padding()
                }
            }

            Text("\(String(format: "%02d", timer.minutes / 60)):\(String(format: "%02d", timer.minutes % 60)):\(String(format: "%02d", timer.seconds))")
                .font(.largeTitle)
                .foregroundColor(.blue)

            HStack {
                Button(action: { viewModel.toggleTimer(timerID: timer.id) }) {
                    Text(timer.isRunning ? "პაუზა" : "დაწყება")
                        .foregroundColor(.white)
                        .padding()
                        .background(timer.isRunning ? Color.orange : Color.green)
                        .cornerRadius(8)
                }

                Button(action: { viewModel.resetTimer(timerID: timer.id) }) {
                    Text("გადატვირთვა")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
    }
}

#Preview {
    ContentView()
}
