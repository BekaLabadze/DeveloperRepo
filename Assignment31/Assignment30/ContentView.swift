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
    @State private var selectedTimer: TimerModel?
    
    var body: some View {
        NavigationView {
            VStack {
                Text("ტაიმერები")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal, 16)
                
                Spacer()
                
                ScrollView {
                    ForEach(viewModel.timers) { timer in
                        VStack {
                            HStack {
                                Text(timer.name)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                    .padding(.leading, 8)
                                Spacer()
                                Button(action: {
                                    viewModel.removeTimer(timerID: timer.id)
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                        .padding()
                                }
                            }
                            
                            Text("\(String(format: "%02d", timer.minutes / 60)):\(String(format: "%02d", timer.minutes % 60)):\(String(format: "%02d", timer.seconds))")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                .padding(.bottom, 8)
                                .frame(maxWidth: .infinity, alignment: .center)
                            
                            HStack(spacing: 16) {
                                Button(action: {
                                    viewModel.toggleTimer(timerID: timer.id)
                                }) {
                                    Text(timer.isRunning ? "პაუზა" : "დაწყება")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(timer.isRunning ? Color.orange : Color.green)
                                        .cornerRadius(8)
                                }
                                
                                Button(action: {
                                    viewModel.resetTimer(timerID: timer.id)
                                }) {
                                    Text("გადატვირთვა")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.red)
                                        .cornerRadius(8)
                                }
                            }
                            .padding(.horizontal, 12)
                            .padding(.bottom, 7)
                        }
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            selectedTimer = timer
                        }
                    }
                }
                
                Spacer()
                
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
                                Text("სთ")
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
                                Text("წთ")
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
                                Text("წმ")
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
                        if let hours = Int(hoursInput), let minutes = Int(minutesInput), let seconds = Int(secondsInput), hours >= 0, minutes >= 0, seconds >= 0 {
                            let totalMinutes = hours * 60 + minutes
                            viewModel.addTimer(name: timerName, minutes: totalMinutes, seconds: seconds)
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
        }
    }
}

#Preview {
    ContentView()
}
