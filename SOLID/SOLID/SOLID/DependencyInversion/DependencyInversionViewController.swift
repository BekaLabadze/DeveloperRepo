//
//  DependencyInversionViewController.swift
//  SOLID
//
//  Created by Beka on 13.11.24.
//

// Dependency Inversion პრინციპის გათვალისიწნებით ჩვენ შევქმენით ცალკეული პროტოკოლი/აბსტრაქცია, რომელიც საშაულებას გვაძლევს რომ ჩვენი კლასი, რომელიც პასუხისმგებელია უფრო დიდ სურათზე არ იყოს დამოკიდებული კოდის ბლოკების იმ ნაწილზე რომელიც ასრულებენ შედარებით მცირე საქმეს და ასევე მათი ცვლილება არ გამოიწვევს არსებული Switch კლასის ფუნქციონალის დარღვევას ან მისი ცვლილების საჭიროებას.

protocol Device {
    func turnOn()
    func turnOff()
}

class TVOne: Device {
    func turnOn() {
        print("TV is ON")
    }

    func turnOff() {
        print("TV is OFF")
    }
}

class AC: Device {
    func turnOn() {
        print("AC is ON")
    }

    func turnOff() {
        print("AC is OFF")
    }
}

class SwitchOne {
    var device: Device
    
    init(device: Device) {
        self.device = device
    }

    func pressSwitch() {
        device.turnOn()
    }
}
