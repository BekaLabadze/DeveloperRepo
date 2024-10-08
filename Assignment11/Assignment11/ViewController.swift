//
//  ViewController.swift
//  Assignment11
//
//  Created by Beka on 06.10.24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet private weak var numberOne: UITextField!
    @IBOutlet private weak var numberTwo: UITextField!
    @IBOutlet private weak var switcher: UISwitch!
    @IBOutlet private weak var result: UILabel!
    @IBOutlet private weak var switcherStatus: UILabel!
    @IBOutlet private weak var switchAppearance: UISwitch!
    @IBOutlet private weak var appearance: UILabel!
    
    @IBAction private func calculate(_ sender: UIButton) {
        calculation()
    }
    @IBAction private func switchAppearance(_ sender: UISwitch) {
        changeInterface()
    }
    @IBAction private func switcherAction(_ sender: UISwitch) {
        divideByZero()
    }
    
    private func calculation() {
        if let textOne = numberOne.text, let textTwo = numberTwo.text, let firstNum = Int(textOne), let secondNum = Int(textTwo) {
            if secondNum == 0 {
                result.text = ("0-ზე გაყოფა არ შეიძლება")
                return
            }
            if switcher.isOn {
                result.text = ("პასუხი : \(Double(firstNum) / Double(secondNum))")
            } else {
                result.text = ("პასუხი : \(firstNum % secondNum)")
            }
        }
    }
    
    private func divideByZero() {
        if switcher.isOn {
            switcherStatus.text = "უნაშთო გაყოფა"
        } else {
            switcherStatus.text = "ნაშთიანი გაყოფა"
        }
    }
    
    private func changeInterface() {
        if switchAppearance.isOn {
            appearance.text = "Appearance: Light Mode"
            overrideUserInterfaceStyle = .light
        } else {
            appearance.text = "Appearance: Dark Mode"
            overrideUserInterfaceStyle = .dark
        }
    }
}
