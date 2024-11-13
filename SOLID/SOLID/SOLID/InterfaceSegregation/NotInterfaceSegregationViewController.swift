//
//  NotInterfaceSegregationViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//


// Interface Segregation პრინციპის გათვალისწინებით კლასს არ უნდა ჭირდებოდეს ისეთი პროტოკოლის/ფუნქციონალის მიღება რომელიც მას არ ჭირდება. მაგალითად ცხოველთა მოქმედება ყველა ცხოველს აქვს მაგალითად თავისი გადაადგილების საშუალება იქნება ეს სიარული, ცურვა თუ ფრენა. აქედან გამომდინარე ზოგად პროტოკოლში ამ ყველაფრის შეტანა დაარღვევს არსებულ პრინციპს რადგანაც მაგალითად კატის შემთხვევაში რათქმაუნდა მას შეუძლია სიარული, მაგრამ პროტოკოლის პრინციპის გათვალისწინებით ემატება ისეთი ვალდებულებები რომელიც კატის შემთხვევაში არალოგიკურია.

protocol AnimalActions {
    func fly()
    func swim()
    func walk()
}

class Cat: AnimalActions {
    func fly() {
        print("Cats can't fly!")
    }

    func swim() {
        print("Cat is swimming!")
    }

    func walk() {
        print("Cat is walking!")
    }
}

class Fish: AnimalActions {
    func fly() {
        print("Fish can't fly!")
    }

    func swim() {
        print("Fish is swimming!")
    }

    func walk() {
        print("Fish can't walk!")
    }
}

class Bird: AnimalActions {
    func fly() {
        print("Bird is flying!")
    }

    func swim() {
        print("Bird can't swim!")
    }

    func walk() {
        print("Bird is walking!")
    }
}
