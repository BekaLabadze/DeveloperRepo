//
//  PlanetViewCell.swift
//  Assignment16
//
//  Created by Beka on 18.10.24.
//

import UIKit

class PlanetViewCell: UITableViewCell {
    
    let planetImage = UIImageView()
    let name = UILabel()
    let size = UILabel()
    let infoButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.layoutMargins = UIEdgeInsets(top: 100, left: 0, bottom: 100, right: 0)
        contentView.backgroundColor = UIColor(red: 128/255, green: 25/255, blue: 25/255, alpha: 0.9)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setViews()
    }
    
    private func setViews() {
        planetImage.translatesAutoresizingMaskIntoConstraints = false
        planetImage.contentMode = .scaleAspectFit
        name.translatesAutoresizingMaskIntoConstraints = false
        size.translatesAutoresizingMaskIntoConstraints = false
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        
        name.font = .systemFont(ofSize: 30, weight: .bold)
        size.font = .systemFont(ofSize: 20, weight: .medium)
        contentView.addSubview(planetImage)
        contentView.addSubview(name)
        contentView.addSubview(size)
        contentView.addSubview(infoButton)
        
        infoButton.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        
        NSLayoutConstraint.activate([
            planetImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            planetImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, constant: -10),
            planetImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            planetImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            name.leadingAnchor.constraint(equalTo: planetImage.trailingAnchor, constant: 20),
            name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            size.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10),
            size.leadingAnchor.constraint(equalTo: name.leadingAnchor),
            infoButton.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -30),
            infoButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10)
        ])
        
          }
    
    func setPlanets(planet: Planet) {
        planetImage.image = planet.image
        name.text = planet.name
        size.text = planet.size
    }
}
