//
//  DetailsPage.swift
//  Assignment30
//
//  Created by Beka on 13.12.24.
//

import SwiftUI

struct DetailsPage: View {
    let timer: TimerModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.title2)
                }

                Text("ვარჯიშში")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(.white)

                Spacer()
            }
            .padding(.horizontal)
            .padding(.top)

            VStack(spacing: 8) {
                Image(systemName: "timer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)

                Text("ხანგრძლივობა")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)

                Text(timer.originalDuration)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.blue)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal)

            VStack(spacing: 16) {
                Text("სტატისტიკა")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("დამატებული ტაიმერები:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)

                        Text("საშუალო დრო აქტიურობის:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)

                        Text("საერთო დრო აქტიურობაში:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.white)
                    }

                    Spacer()

                    VStack(alignment: .trailing, spacing: 8) {
                        Text("\(timer.usageHistory.count)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)

                        Text(middleTime(of: timer.usageHistory))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)

                        Text(totalTimeSpent(of: timer.usageHistory))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 140)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal)

            VStack(spacing: 16) {
                Text("აქტივობის ისტორია")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)

                Divider()
                    .background(Color.white)

                HStack {
                    Text("თარიღი")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("დრო")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }

                ScrollView {
                    VStack(spacing: 8) {
                        ForEach(timer.usageHistory, id: \.date) { entry in
                            HStack {
                                Text(entry.date)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(entry.time)
                                    .font(.system(size: 14, weight: .regular))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
            .padding(.horizontal)

            Spacer()
        }
        .background(Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255).edgesIgnoringSafeArea(.all))
    }

    func middleTime(of history: [(date: String, time: String)]) -> String {
        let totalSeconds = history.map { timeStringToSeconds($0.time) }.reduce(0, +)
        let averageSeconds = totalSeconds / max(history.count, 1)
        return secondsToFormattedTime(averageSeconds)
    }

    func totalTimeSpent(of history: [(date: String, time: String)]) -> String {
        let totalSeconds = history.map { timeStringToSeconds($0.time) }.reduce(0, +)
        return secondsToFormattedTime(totalSeconds)
    }

    func timeStringToSeconds(_ time: String) -> Int {
        let components = time.split(separator: ":").map { Int($0) ?? 0 }
        guard components.count == 3 else { return 0 }
        return (components[0] * 3600) + (components[1] * 60) + components[2]
    }

    func secondsToFormattedTime(_ seconds: Int) -> String {
        let hours = seconds / 3600
        let minutes = (seconds % 3600) / 60
        let secs = seconds % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, secs)
    }
}

struct DetailsPage_Preview: PreviewProvider {
    static var previews: some View {
        DetailsPage(timer: TimerModel(
            name: "კარდიო",
            minutes: 25,
            seconds: 0,
            isRunning: false,
            originalDuration: "25:00",
            usageHistory: [
                (date: "12 დეკ 2024", time: "01:01:00"),
                (date: "11 დეკ 2024", time: "00:19:01"),
                (date: "01 დეკ 2024", time: "01:17:00")
            ]
        ))
    }
}
