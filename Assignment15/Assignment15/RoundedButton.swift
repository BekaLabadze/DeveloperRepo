//
//  RoundedButton.swift
//  Assignment15
//
//  Created by Beka on 16.10.24.
//

import UIKit

class RoundedButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = self.bounds.size.width / 2
        self.layer.masksToBounds = true
    }
}
