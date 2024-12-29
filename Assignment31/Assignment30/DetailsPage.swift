//
//  DetailsPage.swift
//  Assignment30
//
//  Created by Beka on 13.12.24.
//

import Foundation
import SwiftUI

struct DetailsPage: View {
    let timer: TimerModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.title2)
                        .padding(.trailing, 8)
                }
                
                Text(timer.name)
                    .font(.title2)
                    .bold()
                    .foregroundColor(.white)
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)

            VStack {
                Image(.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.orange)
                    .padding(.bottom, 8)

                Text("ხანგრძლივობა")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.bottom, 4)

                Text(timer.originalDuration)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)

            VStack(alignment: .leading, spacing: 8) {
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("აქტივობის ისტორია")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.bottom, 8)
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white)
                    HStack{
                        Text("თარიღი")
                            .padding(.leading, 15)
                            .foregroundStyle(.white)
                        Spacer()
                        Text("დრო")
                            .padding(.trailing, 15)
                            .foregroundStyle(.white)
                    }
                        ForEach(timer.usageHistory, id: \.date) { entry in
                            HStack {
                                Text(entry.date)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                Text(entry.time)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }
                            .padding(.horizontal)
                            .font(.body)
                        }
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
            }
            .padding(.horizontal)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            Spacer()
        }
        .padding(.top, 16)
        .background(Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255).edgesIgnoringSafeArea(.all))
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
