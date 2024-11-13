//
//  NotSingleResponsibilityViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//

// SingleResponsibility პრინციპიდან გამომდინარე კლასი უნდა იყოს პასუხისმეგებელი მხოლოდ ერთი დავალების შესრულებაზე, ამ შემთხვევაში ერთი კლასი ProductsInStorage არის პასუხისმგებელი როგორც პროდუქტების დამატებაზე მასივში ასევე მათ ვიზუალურად გამოტანაზე, ანუ გვაქვს გაერთიანებული ორი ლოგიკა ერთ კლასში რაც ეწინააღმდეგება SingleResponsibility პრინციპს.

class ProductsInStorage {
    var products: [String] = []
    
    func addProduct(product: String) {
        products.append(product)
    }
    
    func printProducts() {
        for product in products {
            print(product)
        }
    }
}
