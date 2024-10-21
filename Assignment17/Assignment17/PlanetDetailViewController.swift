//
//  PlanetDetailViewController.swift
//  Assignment17
//
//  Created by Beka on 21.10.24.
//


import UIKit

class PlanetDetailViewController: UIViewController {
    
    var planet: Planet?
    private let stackView = UIStackView()
    private let innerStackOne = UIStackView()
    private let innerStackTwo = UIStackView()
    
    private let image = UIImageView()
    private let name = UILabel()
    private let size = UILabel()
    private let temperature = UILabel()
    private let mass = UILabel()
    private let backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        setupView()
        
        if let planet = planet {
            image.image = planet.image
            name.text = planet.name
            size.text = planet.size
            temperature.text = planet.temperature
            mass.text = planet.mass
        }
    }
    
    private func setupView() {
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        size.translatesAutoresizingMaskIntoConstraints = false
        temperature.translatesAutoresizingMaskIntoConstraints = false
        mass.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 45/255, green: 11/255, blue: 3/255, alpha: 0.6)
        view.addSubview(image)
        view.addSubview(name)
        view.addSubview(size)
        view.addSubview(temperature)
        view.addSubview(mass)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .orange
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        name.font = .systemFont(ofSize: 30, weight: .bold)
        name.textColor = .white
        size.textColor = .white
        temperature.textColor = .white
        mass.textColor = .white
        
        let labels = [size, temperature, mass]
        for label in labels {
            label.layer.borderColor = UIColor.red.cgColor
            label.layer.borderWidth = 1.0
            label.layer.cornerRadius = 10.0
            label.layer.masksToBounds = true
        }
        
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            image.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            image.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -100),
            image.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.8),
            image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            size.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            size.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -50),
            temperature.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            temperature.topAnchor.constraint(equalTo: size.bottomAnchor, constant: 15),
            mass.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            mass.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 15)
        ])
    }
    @objc func backButtonTapped() {
        navigationController?.pushViewController(PlanetViewController(), animated: true)
    }
}

