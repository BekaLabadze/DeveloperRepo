//
//  InterfaceSegregationViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//


// Interface Segregation პრინციპის გათვალისწინებით ჩვენ ყველა ცხოველის/ფრინველის გათვალისწინებით შევქმენით ცალკეული პროტოკოლები, რის შედეგადაც არსებულ ცხოველს/ფრინველს შეუძლია მხოლოდ იმ პროტოკოლის მიღება რომელიც მას ესაჭიროება.

protocol Flyable {
    func fly()
}

protocol Swimmable {
    func swim()
}

protocol Walkable {
    func walk()
}

class CatOne: Walkable, Swimmable {
    func swim() {
        print("Cat is swimming!")
    }

    func walk() {
        print("Cat is walking!")
    }
}

class FishOne: Swimmable {
    func swim() {
        print("Fish is swimming!")
    }
}

class BirdOne: Flyable, Walkable {
    func fly() {
        print("Bird is flying!")
    }

    func walk() {
        print("Bird is walking!")
    }
}
