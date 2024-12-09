//
//  ContentView.swift
//  Assignment29
//
//  Created by Beka on 07.12.24.
//

import SwiftUI

struct ContentView: View {
    let titles = ["Company", "Role", "Duration"]
    let textFieldPlaceHolder = ["Company", "Role", "Duration"]
    var body: some View {
        VStack {
            Circle()
                .foregroundStyle(.gray)
                .frame(width: 120, height: 120)
                .opacity(0.25)
                .shadow(color: .black, radius: 10, x: 0, y: 0)
                .overlay (
                    Image(.profile)
                )
            Text("John Doe")
                .font(.system(size: 30, weight: .bold))
                .foregroundStyle(.black)
            HStack{
                Text("iOS Developer")
                    .foregroundStyle(.gray)
                    .opacity(0.8)
                Text("|")
                    .foregroundStyle(.gray)
                    .opacity(0.8)
                Text("Swift Enthusiast")
                    .foregroundStyle(.gray)
                    .opacity(0.8)
                Text("|")
                    .foregroundStyle(.gray)
                    .opacity(0.8)
                Text("Teach Lover")
                    .foregroundStyle(.gray)
                    .opacity(0.8)
            }
            .padding(EdgeInsets(top: 5, leading: 19, bottom: 10, trailing: 19))
            Text("Work Experience")
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.system(size: 25, weight: .bold))
                .padding(EdgeInsets(top: 0, leading: 30, bottom: 10, trailing: 10))
            
            VStack(alignment: .leading, spacing: 10) {
                    Text("HDR Solutions Inc.")
                        .foregroundStyle(.black)
                        .font(.system(size: 20, weight: .bold))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 25)
                    Text("iOS Developer")
                        .foregroundStyle(.gray)
                        .padding(.leading)
                    Text("2021 - Present")
                        .foregroundStyle(.gray)
                        .padding(.leading)
                }
                .frame(width: 351, height: 140)
                .background(.gray.opacity(0.15))
                .clipShape(RoundedRectangle(cornerRadius: 20))
            
        }
        VStack(alignment: .leading, spacing: 5) {
            Text("Add New Working Experience")
                .padding(.leading, 15)
                .font(.system(size: 20, weight: .bold))
            ForEach(titles, id: \.self) { title in
                Text(title)
                    .padding(.leading, 22)
                    .foregroundStyle(.gray)
                if title == "Company" {
                    TextField("Enter \(title) Name", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                } else {
                    TextField("Enter \(title)", text: .constant(""))
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal)
                }
            }
            Button("Add Experience") {
                
            }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color(CGColor(red: 59/255, green: 119/255, blue: 91/255, alpha: 1)))
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .padding(EdgeInsets(top:10, leading: 10, bottom: 0, trailing: 10))
        }
        .frame(width: 351, height: 298)
        .background(.gray.opacity(0.15))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.top, 15)
            }
        }

#Preview {
    ContentView()
}
