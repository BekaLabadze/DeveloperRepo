//
//  QuizScreenViewController.swift
//  Assignmentest123
//
//  Created by Beka on 02.11.24.
//

import UIKit

class QuizScreenViewController: UIViewController, AnswerResetDelegate {
    
    let tableView = UITableView()
    let questionsViewModel = QuestionScreenViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setTableView()
        questionsViewModel.loadQuestions()
        tableView.reloadData()
    }
    
    func setTableView() {
        let quizLabel = UILabel()
        quizLabel.text = "Quiz"
        quizLabel.textColor = .white
        quizLabel.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        quizLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(quizLabel)
        view.addSubview(tableView)
        let resetButton = UIButton()
        resetButton.setTitle("Reset", for: .normal)
        resetButton.setTitleColor(.white, for: .normal)
        resetButton.backgroundColor = UIColor(red: 200/255, green: 162/255, blue: 255/255, alpha: 1)
        resetButton.layer.cornerRadius = 15
        resetButton.clipsToBounds = true
        resetButton.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resetButton)
        view.backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 90/255, alpha: 1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = UIColor(red: 20/255, green: 30/255, blue: 90/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(QuizScreenCell.self, forCellReuseIdentifier: "cell")
        NSLayoutConstraint.activate([
            quizLabel.leadingAnchor.constraint(equalTo: tableView.leadingAnchor, constant: 15),
            quizLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            resetButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor, constant: -15),
            resetButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.topAnchor.constraint(equalTo: resetButton.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

extension QuizScreenViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        questionsViewModel.questionList?.results.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! QuizScreenCell
           
        cell.configure(name: "Question \(indexPath.row + 1)")
           cell.buttonAction = { [weak self] in
               self?.navigateToAnswerScreen(for: indexPath)
           }
           
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           navigateToAnswerScreen(for: indexPath)
       }
    
    @objc private func resetButtonTapped() {
            UserDefaults.standard.set(0, forKey: "correctAnswerCount")
            UserDefaults.standard.set(0, forKey: "IncorrectAnswerCount")
            if let answerVC = navigationController?.topViewController as? AnswerResetDelegate {
                answerVC.didResetAnswers()
            }
        }
    
    func didResetAnswers() {
    }
        private func navigateToAnswerScreen(for indexPath: IndexPath) {
            guard let question = questionsViewModel.questionList?.results[indexPath.row] else { return }
            let answerVC = AnswerScreenViewController(question: question)
            answerVC.delegate = self
            navigationController?.pushViewController(answerVC, animated: true)
        }
}
