//
//  NotOpenClosedViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//


// OpenClosed პრინციპიდან გამომდინარე, ჩვენი კოდი უნდა გვაძლევდეს საშუალებას მოვახდინოთ მისი გაფართოება და არ მოგვიწიოს არსებული კოდის ყოველი ახალი ლოგიკის ან ცვლილების დროს მოდიფიცირება. ამ შემთხვევაში გვაქვს ორი ვარიანტი ერთი ფასდაკლება პროცენტის მიხედვით, ხოლო მეორე შემთხვევაში ფასდაკლება ფიქსირებული ფასის მიხედვით. სამომავლოდ თუ მოგვინდა დავამატოთ სხვა სახის ფასდაკლება მაგალითად საახალწლო, მოგვიწევს არსებული კოდის მოდიფიცირება ყოველ ჯერზე რამდენჯერაც ჩვენ ახალი ლოგიკის დამატება მოგვინდებოდა.

class DiscountCalculator {
    func calculateDiscount(orderAmount: Double, discountType: String) -> Double {
        if discountType == "Percentage" {
            return orderAmount * 0.10
        } else if discountType == "Fixed" {
            return 5.0
        }
        return 0.0
    }
}
