//
//  ProgressBar.swift
//  Assignment34
//
//  Created by Beka on 25.12.24.
//

import UIKit
import SwiftUI

struct ProgressBar: UIViewRepresentable {
    @Binding var currentTime: Double
    @Binding var duration: Double

    func makeUIView(context: Context) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = Float(duration)
        slider.isUserInteractionEnabled = false
        return slider
    }

    func updateUIView(_ uiView: UISlider, context: Context) {
        uiView.value = Float(currentTime)
        uiView.maximumValue = Float(duration)
    }
}
