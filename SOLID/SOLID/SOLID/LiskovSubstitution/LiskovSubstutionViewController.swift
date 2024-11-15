//
//  LiskovSubstutionViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//

// LiskovSubstitution პრინციპის გათვალისწინებით ჩვენ უნდა შევქმნათ პროტოკოლი, რომელიც ინდივიდუალურად მოაგვარებს მანქანის და ველოსიპედის დაძვრის ლოგიკას და არ გამოიწვევს კონფლიკტს მემკვიდრეობის დროს.

protocol Vehicle {
    func start()
}

class workingCar: Vehicle {
    var engineType: String
    
    init(engineType: String) {
        self.engineType = engineType
    }
    
    func start() {
        print("Starting \(engineType) engine in the car.")
    }
}

class workingBike: Vehicle {
    func start() {
        print("Moving bike with pedals.")
    }
}
