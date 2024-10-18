//
//  calculationHistory.swift
//  Assignment15
//
//  Created by Beka on 16.10.24.
//

import UIKit

class CalculationHistory: UIViewController {
    
    var history: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let textField = UITextView()
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        textField.backgroundColor = .lightGray
        textField.text = history.joined(separator: "\n")
        textField.scrollRangeToVisible(NSRange(location: textField.text.count - 1, length: 1))
        textField.isEditable = false
        textField.font = .systemFont(ofSize: 15, weight: .light)
        textField.textAlignment = .right
        textField.textContainerInset = UIEdgeInsets(top: 240, left: 0, bottom: 0, right: 0)
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            textField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            textField.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3)])
        
    }
}
