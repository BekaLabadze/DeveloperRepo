//
//  CustomNavigation.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import SwiftUI

struct CustomNavigationBar: View {
    let title: String
    let backAction: () -> Void

    var body: some View {
        HStack {
            Button(action: backAction) {
                HStack {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                    Text("Back")
                        .foregroundColor(.white)
                }
            }
            Spacer()
            Text(title)
                .font(.headline)
                .foregroundColor(.white)
            Spacer()
            Spacer()
        }
        .padding()
        .background(Color.black.opacity(0.8))
    }
}
