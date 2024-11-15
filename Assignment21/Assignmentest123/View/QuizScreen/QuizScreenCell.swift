//
//  QuizScreenCell.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import UIKit

class QuizScreenCell: UITableViewCell {
    let quizButton = UIButton()
    var buttonAction: (() -> Void)?
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 90/255, alpha: 1)
        contentView.addSubview(quizButton)
        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        quizButton.translatesAutoresizingMaskIntoConstraints = false
        quizButton.setTitleColor(.black, for: .normal)
        quizButton.backgroundColor = .white
        quizButton.layer.cornerRadius = 15
        quizButton.clipsToBounds = true
        quizButton.addTarget(self, action: #selector(quizButtonTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            quizButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            quizButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            quizButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quizButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20)
        ])
    }
    
    func configure(name: String) {
        quizButton.setTitle(name, for: .normal)
        quizButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func quizButtonTapped() {
        buttonAction?()
    }
}
