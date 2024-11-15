//
//  AnswerScreenViewController.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import UIKit

class AnswerScreenViewController: UIViewController, AnswerResetDelegate{
    var viewModel = QuizScreenViewController()
    var questionLabel = UILabel()
    var button1 = UIButton()
    var button2 = UIButton()
    var button3 = UIButton()
    var button4 = UIButton()
    var backButton = UIButton()
    var numOfQuestion = UIButton()
    var answerLabel = UILabel()
    var stackView = UIStackView()
    weak var delegate: AnswerResetDelegate?
    let savedCountCorrect = UserDefaults.standard.integer(forKey: "correctAnswerCount")
    let savedCountIncorrect = UserDefaults.standard.integer(forKey: "IncorrectAnswerCount")
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var question: Questions
    init (question: Questions) {
        self.question = question
        super.init(nibName: nil, bundle: nil)

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        view.addSubview(backButton)
        view.addSubview(numOfQuestion)
        view.addSubview(button1)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(answerLabel)
        view.backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 90/255, alpha: 1)
        updateAnswerLabel()
        numOfQuestion.translatesAutoresizingMaskIntoConstraints = false
        numOfQuestion.backgroundColor = UIColor(red: 200/255, green: 162/255, blue: 255/255, alpha: 1)
        numOfQuestion.layer.cornerRadius = 15
        numOfQuestion.clipsToBounds = true
        numOfQuestion.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        numOfQuestion.setTitle("Question \(question.questionNumber)", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.tintColor = .white
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.text = "Corrent answers: \(savedCountCorrect), Incorrect answers: \(savedCountIncorrect)"
        answerLabel.layer.borderColor = CGColor(red: 200/255, green: 162/255, blue: 255/255, alpha: 1)
        answerLabel.backgroundColor = UIColor(red: 200/255, green: 162/255, blue: 255/255, alpha: 1)
        answerLabel.font = .systemFont(ofSize: 18, weight: .medium)
        answerLabel.layer.borderWidth = 5.0
        answerLabel.layer.cornerRadius = 15.0
        answerLabel.clipsToBounds = true
        answerLabel.textColor = .white
        answerLabel.textAlignment = .center
        button1.backgroundColor = .white
        button2.backgroundColor = .white
        button3.backgroundColor = .white
        button4.backgroundColor = .white
        button1.translatesAutoresizingMaskIntoConstraints = false
        button2.translatesAutoresizingMaskIntoConstraints = false
        button3.translatesAutoresizingMaskIntoConstraints = false
        button4.translatesAutoresizingMaskIntoConstraints = false
        button1.setTitle("\(question.correct_answer)", for: .normal)
        button1.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button1.setTitleColor(.black, for: .normal)
        button1.layer.cornerRadius = 15
        button1.clipsToBounds = true
        button2.setTitle("\(question.incorrect_answers[0])", for: .normal)
        button2.layer.cornerRadius = 15
        button2.clipsToBounds = true
        button2.setTitleColor(.black, for: .normal)
        button2.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button3.setTitle("\(question.incorrect_answers[1])", for: .normal)
        button3.layer.cornerRadius = 15
        button3.clipsToBounds = true
        button3.setTitleColor(.black, for: .normal)
        button3.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button4.setTitle("\(question.incorrect_answers[2])", for: .normal)
        button4.layer.cornerRadius = 15
        button4.clipsToBounds = true
        button4.setTitleColor(.black, for: .normal)
        button4.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button1.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button2.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button3.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        button4.addTarget(self, action: #selector(button1Tapped), for: .touchUpInside)
        questionLabel.text = question.question
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.numberOfLines = 0
        questionLabel.textColor = .white
        questionLabel.font = .systemFont(ofSize: 20, weight: .medium)
        view.addSubview(questionLabel)
        setupStackView()
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            numOfQuestion.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            numOfQuestion.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 60),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            answerLabel.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 50),
            answerLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            answerLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            answerLabel.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    private func setupStackView() {
        view.addSubview(stackView)
        stackView.backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 90/255, alpha: 1)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.addArrangedSubview(button1)
        stackView.addArrangedSubview(button2)
        stackView.addArrangedSubview(button3)
        stackView.addArrangedSubview(button4)
    }
    
    @objc private func button1Tapped(button: UIButton) {
        let currentCountCorrect = UserDefaults.standard.integer(forKey: "correctAnswerCount")
        let currentCountIncorrect = UserDefaults.standard.integer(forKey: "IncorrectAnswerCount")
        
        button.backgroundColor = UIColor(red: 200/255, green: 162/255, blue: 255/255, alpha: 1)
        
        if button.titleLabel?.text == question.correct_answer {
            let newCountCorrect = currentCountCorrect + 1
            UserDefaults.standard.set(newCountCorrect, forKey: "correctAnswerCount")
            answerLabel.text = "Correct answers: \(newCountCorrect), Incorrect answers: \(currentCountIncorrect)"
        } else {
            let newCountIncorrect = currentCountIncorrect + 1
            UserDefaults.standard.set(newCountIncorrect, forKey: "IncorrectAnswerCount")
            answerLabel.text = "Correct answers: \(currentCountCorrect), Incorrect answers: \(newCountIncorrect)"
        }
    }

    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func updateAnswerLabel() {
           let savedCountCorrect = UserDefaults.standard.integer(forKey: "correctAnswerCount")
           let savedCountIncorrect = UserDefaults.standard.integer(forKey: "IncorrectAnswerCount")
           answerLabel.text = "Correct answers: \(savedCountCorrect), Incorrect answers: \(savedCountIncorrect)"
       }

    func didResetAnswers() {
           answerLabel.text = "Correct answers: 0, Incorrect answers: 0"
       }
}
