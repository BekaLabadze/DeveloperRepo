//
//  OpenClosedViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//

// Discount პროტოკოლის დამატებით ჩვენ გვეძლევა საშუალება მოვახდინოთ ჩვენი კოდის გაფართოება და არ მოგვიწიოს ერთი კოდის ბლოკის შეცვლა ყოველ ჯერზე რამდენეჯერაც ჩვენ ახალი ლოგიკის დამატება მოგვინდება. ამ შემთხვევაში ყოველი ფასდაკლების ტიპისთვის ჩვენ შეგვიძლია შექვმნათ ცალკეული კლასები, რომელბსაც პროტოკოლის დახმარებით შეეძლებათ განსხვავებულ ლოგიკებთან/სიტუაციებთან იმუშაონ.

protocol Discount {
    func calculateDiscount(orderAmount: Double) -> Double
}

class PercentageDiscount: Discount {
    func calculateDiscount(orderAmount: Double) -> Double {
        return orderAmount * 0.10
    }
}

class FixedDiscount: Discount {
    func calculateDiscount(orderAmount: Double) -> Double {
        return 5.0
    }
}
