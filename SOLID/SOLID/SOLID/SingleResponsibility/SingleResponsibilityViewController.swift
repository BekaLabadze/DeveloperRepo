//
//  SingleResponsibilityViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//


// ამ შემთხვევაში ჩვენ შევქმენით ორი სხვადასხვა ლოგიკისთვის ორი სხვადასხვა კლასი, რომლის დახმარებითაც ჩვენ დავიცავით SingleResponsibility პრინციპი.

class ProductStorage {
    private var products: [String] = []
    
    func addProduct(product: String) {
        products.append(product)
    }
    
    func getProducts() -> [String] {
        return products
    }
}

class ProductPrinter {
    func printProducts(products: [String]) {
        for product in products {
            print(product)
        }
    }
}
