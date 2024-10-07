//
//  ViewController.swift
//  Assignment11
//
//  Created by Beka on 06.10.24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var numberOne: UITextField!
    @IBOutlet weak var numberTwo: UITextField!
    @IBOutlet weak var switcher: UISwitch!
    @IBOutlet weak var result: UILabel!
    @IBOutlet weak var switcherStatus: UILabel!
    
    @IBOutlet weak var switchAppearance: UISwitch!
    
    @IBOutlet weak var appearance: UILabel!
    @IBAction func calculate(_ sender: UIButton) {
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
    
    @IBAction func switcherAction(_ sender: UISwitch) {
        if switcher.isOn {
            switcherStatus.text = "უნაშთო გაყოფა"
        } else {
            switcherStatus.text = "ნაშთიანი გაყოფა"
        }
    }
    
    @IBAction func switchAppearance(_ sender: UISwitch) {
        if switchAppearance.isOn {
            appearance.text = "Appearance: Light Mode"
            overrideUserInterfaceStyle = .light
        } else {
            appearance.text = "Appearance: Dark Mode"
            overrideUserInterfaceStyle = .dark
        }
    }
}
