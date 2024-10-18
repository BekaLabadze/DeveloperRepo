//
//  ViewController.swift
//  Assignment15
//
//  Created by Beka on 16.10.24.
//

import UIKit

class CalculatorUI: UIViewController {
    
    let mainContainer = UIStackView()
    let columnViewOne = UIStackView()
    let columnViewTwo = UIStackView()
    let columnViewThree = UIStackView()
    let columnViewFour = UIStackView()
    let labelOne = UILabel()
    let labelTwo = UILabel()
    var currentInput: String = ""
    var buttons: [UIButton] = []
    var titleColor: UIColor = UIColor(red: 30, green: 30, blue: 30, alpha: 1)
    var isLightMode: Bool = true
    var colorOne = UIColor(red: 237 / 255.0, green:14 / 255.0, blue: 152 / 255.0, alpha: 1.0)
    var colorTwo = UIColor(red: 254 / 255.0, green:90 / 255.0, blue: 45 / 255.0, alpha: 1.0)
    var historyTextView = UITextView()
    var historyButton = RoundedButton()
    var calculationHistory: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addButtons(to: columnViewOne, titles: ["", "7", "4", "1", "AC"])
        addButtons(to: columnViewTwo, titles: ["%", "8", "5", "2", "0"])
        addButtons(to: columnViewThree, titles: ["/", "9", "6", "3", "."])
        addButtons(to: columnViewFour, titles: ["X", "-", "+", "="])
        buttons[0].setImage(UIImage.moonIcon, for: .normal)
        buttons[17].bottomAnchor.constraint(equalTo: buttons[18].topAnchor, constant: -20).isActive = true
        buttons[18].heightAnchor.constraint(equalTo: columnViewFour.heightAnchor, multiplier: 0.31).isActive = true
        buttons[18].backgroundColor = .systemGray2
        modifyButton(at: 5, to: .systemGray2)
        modifyButton(at: 10, to: .systemGray2)
        modifyButton(at: 15, to: .systemGray2)
        modifyButton(at: 16, to: .systemGray2)
        modifyButton(at: 17, to: .systemGray2)
        mainContainerRounded()
        interfaceButton()
        calculationHistoryTapper()
        view.backgroundColor = .systemGray5
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        buttons[4].applyGradient(colors: [colorOne, colorTwo], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
        buttons[18].applyGradient(colors: [colorOne, colorTwo], startPoint: CGPoint(x: 0, y: 0), endPoint: CGPoint(x: 1, y: 1))
    }
    
    private func setupUI() {
        view.addSubview(labelOne)
        labelOne.translatesAutoresizingMaskIntoConstraints = false
        labelOne.text = ""
        labelOne.font = UIFont.systemFont(ofSize:35 , weight: .bold)
        labelOne.textColor = .black
        view.addSubview(labelTwo)
        labelTwo.translatesAutoresizingMaskIntoConstraints = false
        labelTwo.text = ""
        labelTwo.font = UIFont.systemFont(ofSize:30 , weight: .thin)
        labelTwo.textColor = .black
        
        historyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(historyButton)
        historyButton.setImage(UIImage(systemName: "arrow.left.circle"), for: .normal)
        NSLayoutConstraint.activate([
            historyButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            historyButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -300),
            historyButton.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0)
        ])
        
        view.addSubview(mainContainer)
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        mainContainer.backgroundColor = .systemGray4
        mainContainer.spacing = 7
        mainContainer.axis = .horizontal
        mainContainer.distribution = .fillEqually
        
        NSLayoutConstraint.activate([
            mainContainer.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            mainContainer.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            mainContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            mainContainer.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.53),
            labelOne.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            labelOne.bottomAnchor.constraint(equalTo: mainContainer.topAnchor, constant: -20),
            labelTwo.bottomAnchor.constraint(equalTo: labelOne.topAnchor, constant: -15),
            labelTwo.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        addColumns()
    }
    
    private func calculationHistoryTapper() {
        historyButton.addTarget(self, action: #selector(showCalculationHistory), for: .touchUpInside)
    }
    
    @objc func showCalculationHistory() {
        let historyViewController = CalculationHistory()
        historyViewController.history = calculationHistory
        navigationController?.pushViewController(historyViewController, animated: true)
    }
    
    private func addColumns() {
        let stacks = [columnViewOne, columnViewTwo, columnViewThree, columnViewFour]
        for columnStackView in stacks {
            columnStackView.axis = .vertical
            columnStackView.distribution = .fillEqually
            columnStackView.alignment = .center
            columnStackView.spacing = 10
            columnStackView.isLayoutMarginsRelativeArrangement = true
            columnStackView.layoutMargins = UIEdgeInsets(top: 16, left: 5, bottom: 16, right: 5)
            columnStackView.backgroundColor = .systemGray4
            columnStackView.translatesAutoresizingMaskIntoConstraints = false
            
            columnViewFour.distribution = .fillProportionally
            
            mainContainer.addArrangedSubview(columnStackView)
        }
    }
    
    private func addButtons(to columns: UIStackView, titles: [String]) {
        for title in titles {
            let button = RoundedButton()
            button.backgroundColor = .systemGray4
            button.setTitle(title, for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.translatesAutoresizingMaskIntoConstraints = false
            columns.addArrangedSubview(button)
            button.heightAnchor.constraint(equalTo: button.widthAnchor, multiplier: 1).isActive = true
            buttons.append(button)
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        }
    }
    
    @objc func buttonTapped(_ sender: RoundedButton) {
        if let currentTitle = sender.currentTitle {
            if currentTitle == "=" {
                if currentInput.isEmpty {
                    labelOne.text = "Choose a number"
                } else {
                    labelTwo.text = currentInput
                    calculate()
                }
            } else if currentTitle == "AC" {
                labelOne.text = ""
                labelTwo.text = ""
                currentInput = ""
                calculationHistory.append("AC")
            } else {
                currentInput += currentTitle
                labelTwo.text = currentInput
            }
        }
    }

    private func calculate() {
        let currentInput = currentInput.replacingOccurrences(of: "X", with: "*")
        let calculation = NSExpression(format: currentInput)
        
        if let result = calculation.expressionValue(with: nil, context: nil) as? NSNumber {
            labelOne.text = "\(result)"
            if let labelTwoText = labelTwo.text {
                calculationHistory.append("\(labelTwoText) = \(result)")
            } else {
                calculationHistory.append("\(result)")

            }
        } else {
            labelOne.text = "Error"
        }
    }
    
    private func interfaceButton() {
            buttons[0].addTarget(self, action: #selector(changeInterface), for: .touchUpInside)
    }
    
    @objc func changeInterface() {
        isLightMode.toggle()
        if isLightMode {
            overrideUserInterfaceStyle = .light
            view.backgroundColor = .systemGray4
            mainContainer.backgroundColor = .systemGray4
            columnViewOne.backgroundColor = .systemGray4
            columnViewTwo.backgroundColor = .systemGray4
            columnViewThree.backgroundColor = .systemGray4
            columnViewFour.backgroundColor = .systemGray4
            buttons[0].setImage(UIImage.moonIcon, for: .normal)
            for index in 0...18 {
                buttons[index].setTitleColor(.black, for: .normal)
                labelOne.textColor = .black
                labelTwo.textColor = .black
            }
        } else {
            overrideUserInterfaceStyle = .dark
            view.backgroundColor = .black
            mainContainer.backgroundColor = .black
            columnViewOne.backgroundColor = .black
            columnViewTwo.backgroundColor = .black
            columnViewThree.backgroundColor = .black
            columnViewFour.backgroundColor = .black
            buttons[0].setImage(UIImage(systemName: "sun.min"), for: .normal)
            for index in 0...18 {
                buttons[index].setTitleColor(.white, for: .normal)
                labelOne.textColor = .white
                labelTwo.textColor = .white
            }
        }
    }
    
    private func mainContainerRounded() {
        mainContainer.layer.cornerRadius = 20
        mainContainer.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        mainContainer.layer.masksToBounds = true
    }
    
    private func modifyButton(at index: Int, to color: UIColor) {
        buttons[index].backgroundColor = color
    }
}

extension UIButton {
    func applyGradient(colors: [UIColor], startPoint: CGPoint, endPoint: CGPoint) {
        let gradient = CAGradientLayer()
        var cgColors: [CGColor] = []
        for color in colors {
            cgColors.append(color.cgColor)
        }
        gradient.colors = cgColors
        gradient.startPoint = startPoint
        gradient.endPoint = endPoint
        gradient.frame = self.bounds
        self.layer.insertSublayer(gradient, at: 0)
    }
}
