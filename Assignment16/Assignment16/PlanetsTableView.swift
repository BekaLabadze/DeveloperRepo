//
//  ViewController.swift
//  Assignment16
//
//  Created by Beka on 18.10.24.
//

import UIKit

struct Planet {
    var name: String
    var image: UIImage
    var size: String
}

class PlanetsTableView: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let tableView = UITableView()
    let label = UILabel()
    
    let planets: [Planet] = [
        Planet(name: "Mars", image: UIImage.mars, size: "144 million km2"),
        Planet(name: "Jupiter", image: UIImage.jupiter, size: "510 million km2"),
        Planet(name: "Earth", image: UIImage.earth, size: "61.4 million km2"),
        Planet(name: "Saturn", image: UIImage.saturn, size: "42.7 million km2")
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 128/255, green: 25/255, blue: 25/255, alpha: 0.9)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlanetViewCell.self, forCellReuseIdentifier: "PlanetViewCell")
        tableView.backgroundColor = UIColor(red: 128/255, green: 25/255, blue: 25/255, alpha: 0.9)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        view.addSubview(tableView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        label.text = "Planets"
        label.font = .systemFont(ofSize:25 , weight: .bold)
        
        NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant:10),
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        tableView.topAnchor.constraint(equalTo: label.topAnchor, constant: 100),
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)])
    }
    
    func sections (tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetViewCell", for: indexPath) as? PlanetViewCell {
            let planet = planets[indexPath.row]
            cell.setPlanets(planet: planet)
            return cell
        }
        return UITableViewCell()
    }
}
