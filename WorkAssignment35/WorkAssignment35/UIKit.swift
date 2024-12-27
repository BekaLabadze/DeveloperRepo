//
//  ViewController.swift
//  WorkAssignment35
//
//  Created by Beka on 27.12.24.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private let categories = [
        ("Anime ⚔️", "animeImage"),
        ("Books 📚", "bookImage"),
        ("Movies 🎥", "movieImage")
    ]

    private var collectionView: UICollectionView!
    private let goalLabel: UILabel = {
        let label = UILabel()
        label.text = "You need 10 points to win!"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reset Score", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = UIColor.systemRed
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(resetScore), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGradientBackground()
        setupCollectionView()
        setupBottomContainer()
    }

    private func setupGradientBackground() {
        view.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.darkGray.cgColor, UIColor.black.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.frame = view.bounds

        view.layer.insertSublayer(gradientLayer, at: 0)
    }

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width * 0.9, height: 150)
        layout.minimumLineSpacing = 20

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "CategoryCell")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -100)
        ])
    }

    private func setupBottomContainer() {
        let bottomContainer = UIView()
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomContainer)

        NSLayoutConstraint.activate([
            bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            bottomContainer.heightAnchor.constraint(equalToConstant: 100)
        ])

        setupGoalLabel(in: bottomContainer)
        setupResetButton(in: bottomContainer)
    }

    private func setupGoalLabel(in container: UIView) {
        let goalLabel = UILabel()
        goalLabel.text = "You need 10 points to win!"
        goalLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        goalLabel.textColor = .white
        goalLabel.textAlignment = .center
        goalLabel.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(goalLabel)

        NSLayoutConstraint.activate([
            goalLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            goalLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            goalLabel.topAnchor.constraint(equalTo: container.topAnchor),
            goalLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }

    private func setupResetButton(in container: UIView) {
        let resetButton = UIButton(type: .system)
        resetButton.setTitle("Reset Score", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        resetButton.backgroundColor = UIColor.systemRed
        resetButton.layer.cornerRadius = 10
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.addTarget(self, action: #selector(resetScore), for: .touchUpInside)
        container.addSubview(resetButton)

        NSLayoutConstraint.activate([
            resetButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 16),
            resetButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -16),
            resetButton.topAnchor.constraint(equalTo: container.subviews.first!.bottomAnchor, constant: 10),
            resetButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func resetScore() {
        let viewModel = ViewModel()
        viewModel.resetGame()

        let alert = UIAlertController(title: "Score Reset", message: "Your score has been reset to 0.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        let category = categories[indexPath.item]
        cell.configure(with: category.0, imageName: category.1)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = categories[indexPath.item].0
        let emojiRiddlesView = SwiftUIView(category: selectedCategory)
        let hostingController = UIHostingController(rootView: emojiRiddlesView)
        navigationController?.pushViewController(hostingController, animated: true)
    }
}
