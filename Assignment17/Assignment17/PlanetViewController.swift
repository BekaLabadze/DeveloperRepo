//
//  ViewController.swift
//  Assignment17
//
//  Created by Beka on 20.10.24.
//

import UIKit

struct Planet {
    let name: String
    let size: String
    let image: UIImage
    let temperature: String
    let mass: String
    var isFavorite: Bool
}

class PlanetViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let planet = planets[indexPath.item]
        let planetDetails = PlanetDetailViewController()
        planetDetails.planet = planet
        navigationController?.pushViewController(planetDetails, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlanetCell", for: indexPath) as! PlanetCell
        let planet = planets[indexPath.item]
        cell.configure(cell: planet)
        cell.favoriteButton.tag = indexPath.item
        cell.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        planets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (view.frame.width / 2) - 10, height: 200)
    }
    
    private var planets: [Planet] = []
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Solar System"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor(red: 45/255, green: 11/255, blue: 3/255, alpha: 0.6)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PlanetCell.self, forCellWithReuseIdentifier: "PlanetCell")
        return collectionView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 45/255, green: 11/255, blue: 3/255, alpha: 0.6)
        self.navigationItem.hidesBackButton = true

        setSplashScreen()
        loadPlanets()
        setCollectionView()
        
        collectionView.alpha = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.showCollectionView()
        }
    }
    
    private func setSplashScreen() {
        view.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    private func setCollectionView() {
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadPlanets() {
        planets = [
            Planet(name: "Mercury", size: "Area: 74,800,000 km2", image: UIImage.mercury, temperature: "Temperature: 100", mass: "Mass: 100", isFavorite: false),
            Planet(name: "Venus", size: "Area: 460,200,000 km2", image: UIImage.venus, temperature: "Temperature: 100", mass: "Mass: 100", isFavorite: false),
            Planet(name: "Earth", size: "Area: 510,100,100 km2", image: UIImage.earth, temperature: "Temperature: 100", mass: "Mass: 100", isFavorite: false),
            Planet(name: "Mars", size: "Area: 144,400,000 km2", image: UIImage.mars, temperature: "Temperature: 100", mass: "Mass: 100", isFavorite: false),
            Planet(name: "Jupiter", size: "Area: 6,142E10 km2", image: UIImage.jupiter, temperature: "Temperature: 100", mass: "Mass: 100", isFavorite: false),
            Planet(name: "Uranus", size: "Area: 8,083E9 km2", image: UIImage.uranus, temperature: "Temperature: 100", mass: "Mass: 100", isFavorite: false),
        ]
    }
    
    private func showCollectionView() {
        UIView.animate(withDuration: 0.5) {
            self.titleLabel.alpha = 0
            self.collectionView.alpha = 1
        }
    }
    
    @objc func favoriteButtonTapped(_ sender: UIButton) {
        let index = sender.tag
        planets[index].isFavorite.toggle()
        
        planets.sort { (first, second) -> Bool in
            if first.isFavorite == second.isFavorite {
                return false
            }
            return first.isFavorite
        }
        collectionView.reloadData()
    }
}

class PlanetCell: UICollectionViewCell {
    
    let image = UIImageView()
    let name = UILabel()
    let size = UILabel()
    let favoriteButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        image.contentMode = .scaleAspectFit
        favoriteButton.setImage(UIImage.notFavorite, for: .normal)
        
        contentView.addSubview(image)
        contentView.addSubview(name)
        contentView.addSubview(size)
        contentView.addSubview(favoriteButton)
        image.translatesAutoresizingMaskIntoConstraints = false
        name.translatesAutoresizingMaskIntoConstraints = false
        size.translatesAutoresizingMaskIntoConstraints = false
        favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        name.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        size.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        
        NSLayoutConstraint.activate([
            image.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            image.topAnchor.constraint(equalTo: contentView.topAnchor),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            image.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -50),
            size.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            size.topAnchor.constraint(equalTo: name.bottomAnchor),
            favoriteButton.leadingAnchor.constraint(equalTo: name.trailingAnchor, constant: 15),
            favoriteButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: -55),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(cell planet: Planet) {
        image.image = planet.image
        name.text = planet.name
        name.textColor = .white
        size.text = planet.size
        size.textColor = .white
        if planet.isFavorite {
            favoriteButton.setImage(UIImage.star, for: .normal)
        } else {
            favoriteButton.setImage(UIImage.notFavorite, for: .normal)
        }
    }
}
