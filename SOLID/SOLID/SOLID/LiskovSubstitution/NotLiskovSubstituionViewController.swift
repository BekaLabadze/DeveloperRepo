//
//  NotLiskovSubstituionViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//

// LiskovSubstitution პრინციპის გათვალისწინებით, მემკვიდრეობითობის დროს მშობელი კლასის არ გამოყენების შემთხვევაში, შვილობილი კლასი ჩვეულებრივად უნდა ახერხებდეს არსებული დავალების შესრულებას და ასევე არ უნდა იწვევდეს რაიმე სახის პრობლემას, მას უნდა ქონდეს საშუალება რომ გააფართოვოს ან შეცვალოს არსებული ლოგიკა მაგრამ არ დაარღვიოს ის. ქვემოთ მოყვანილი მაგალითის შემთხვევაში ჩვენ გვაქვს ორი ობიექტი ერთი არის მანქანა მეორე ველოსიპედი. ამ შემთხვევაში ველოსიპედი არის მანქანის მემკვიდრე რაც თავისმხრივ გამოიწვევს პრობელმას რადგანაც, მემკვიდრეობის გამო ამ ლოგიკით ველოსიპედისგან გვაქვს მოლოდინი რომ მას ექნება ძრავი. აქედან გამომდინარე თუ ჩვენ გამოვიყენებთ მაგალითად მანქანის ნაცვლად ველოსიპედს ლოგიკა დაირღვევა.

class Car {
    var engineType: String
    
    init(engineType: String) {
        self.engineType = engineType
    }
    
    func startEngine() {
        print("Starting \(engineType) engine.")
    }
}

class Bike: Car {
    override init(engineType: String) {
        super.init(engineType: "None")
    }
    
    override func startEngine() {
        print("Bikes don’t have engines to start!")
    }
}
