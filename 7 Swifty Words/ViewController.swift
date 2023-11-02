//
//  ViewController.swift
//  7 Swifty Words
//
//  Created by Kriti on 2023-10-19.
//

import UIKit

class ViewController: UIViewController {
    var cluesLabel: UILabel!
    var answersLabel: UILabel!
    var scoreLabel: UILabel!
    var currentAnswer: UITextField!
    var letterButtons = [UIButton]()
    var solutions = [String]()
    var activatedButtons = [UIButton]()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var level = 1

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1.0)
        
        scoreLabel = UILabel()
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.textAlignment = .right
        scoreLabel.text = "Score: 0"
        scoreLabel.textColor = .darkGray
        scoreLabel.backgroundColor = UIColor(red: 204/255, green: 255/255, blue: 153/255, alpha: 1.0)
        view.addSubview(scoreLabel)
        
        cluesLabel = UILabel()
        cluesLabel.translatesAutoresizingMaskIntoConstraints = false
        cluesLabel.font = UIFont.systemFont(ofSize: 24)
        cluesLabel.text = "CLUES"
        cluesLabel.textColor = .darkGray
        cluesLabel.backgroundColor = UIColor(red: 255/255, green: 250/255, blue: 205/255, alpha: 1.0)
        cluesLabel.numberOfLines = 0
        view.addSubview(cluesLabel)
        
        answersLabel = UILabel()
        answersLabel.translatesAutoresizingMaskIntoConstraints = false
        answersLabel.font = UIFont.systemFont(ofSize: 24)
        answersLabel.text = "ANSWERS"
        answersLabel.textColor = .darkGray
        answersLabel.backgroundColor = UIColor(red: 245/255, green: 255/255, blue: 250/255, alpha: 1.0)
        answersLabel.numberOfLines = 0
        view.addSubview(answersLabel)
        
        cluesLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        answersLabel.setContentHuggingPriority(UILayoutPriority(1), for: .vertical)
        
        currentAnswer = UITextField()
        currentAnswer.translatesAutoresizingMaskIntoConstraints = false
        currentAnswer.placeholder = "Tap letters to guess"
        currentAnswer.textAlignment = .center
        currentAnswer.layer.borderWidth = 1
        currentAnswer.font = UIFont.systemFont(ofSize: 44)
        currentAnswer.backgroundColor = UIColor(red: 255/255, green: 245/255, blue: 238/255, alpha: 1.0)
        currentAnswer.isUserInteractionEnabled = false
        view.addSubview(currentAnswer)
        
        
        let submit = UIButton()
        submit.translatesAutoresizingMaskIntoConstraints = false
        submit.setTitle("SUBMIT", for: .normal)
        submit.setTitleColor(UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0), for: .normal)
        submit.addTarget(self, action: #selector(submitTapped), for: .touchUpInside)
        view.addSubview(submit)
        
        let clear = UIButton()
        clear.translatesAutoresizingMaskIntoConstraints = false
        clear.setTitle("CLEAR", for: .normal)
        clear.setTitleColor(UIColor(red: 255/255, green: 0/255, blue: 255/255, alpha: 1.0), for: .normal)
        clear.addTarget(self, action: #selector(clearTapped), for: .touchUpInside)
        view.addSubview(clear)
        
        let buttonsView = UIView()
        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        buttonsView.backgroundColor = UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0)
        buttonsView.layer.borderWidth = 1
        buttonsView.layer.borderColor = UIColor.darkGray.cgColor
        view.addSubview(buttonsView)
        
        
        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            cluesLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5),
            cluesLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor, constant: 100),
            cluesLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.6, constant: -100),
            answersLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 5),
            answersLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor, constant: -100),
            answersLabel.widthAnchor.constraint(equalTo: view.layoutMarginsGuide.widthAnchor, multiplier: 0.4, constant: -100),
            currentAnswer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            currentAnswer.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            currentAnswer.topAnchor.constraint(equalTo: cluesLabel.bottomAnchor, constant: 20),
            currentAnswer.topAnchor.constraint(equalTo: answersLabel.bottomAnchor, constant: 20),
            submit.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            submit.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -100),
            submit.heightAnchor.constraint(equalToConstant: 44),
            clear.topAnchor.constraint(equalTo: currentAnswer.bottomAnchor),
            clear.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 100),
            clear.heightAnchor.constraint(equalToConstant: 44),
            buttonsView.topAnchor.constraint(equalTo: submit.bottomAnchor, constant: 20),
            buttonsView.widthAnchor.constraint(equalToConstant: 750),
            buttonsView.heightAnchor.constraint(equalToConstant: 320),
            buttonsView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        let width = 150
        let height = 80
        
        for row in 0..<4 {
            for col in 0..<5 {
                let letterButton = UIButton(type: .system)
                letterButton.titleLabel?.font = UIFont.systemFont(ofSize: 54)
                letterButton.setTitleColor(UIColor(red: 100/255, green: 149/255, blue: 237/255, alpha: 1.0), for: .normal)
                letterButton.setTitle("\(row)\(col)", for: .normal)
                letterButton.addTarget(self, action: #selector(letterTapped), for: .touchUpInside)
                let frame = CGRect(x: col * width, y: row * height, width: width, height: height)
                letterButton.frame = frame
                buttonsView.addSubview(letterButton)
                letterButtons.append(letterButton)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            self?.loadLevel()
        }
    }
    
    @objc func letterTapped(_ sender: UIButton) {
        guard let buttonTitle = sender.titleLabel?.text else {return}
        currentAnswer.text = currentAnswer.text?.appending(buttonTitle)
        activatedButtons.append(sender)
        sender.isHidden = true
    }

    @objc func submitTapped(_ sender: UIButton) {
        guard let submittedAnswer = currentAnswer.text else {return}
        
        if let position = solutions.firstIndex(of: submittedAnswer){
            activatedButtons.removeAll()
            var splitAnswer = answersLabel.text?.components(separatedBy: "\n")
            splitAnswer?[position] = submittedAnswer
            answersLabel.text = splitAnswer?.joined(separator: "\n") // to make it string
            currentAnswer.text?.removeAll()
            score += 1
            
            if letterButtons.allSatisfy({button in button.isHidden}) {
                let ac = UIAlertController(title: "Well done!", message: "Are you ready for the next level?", preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "Let's go!", style: .default, handler: levelUp))
                present(ac, animated: true)
            }
        } else {
            let ac = UIAlertController(title: "Oops!", message: "Your guess is incorrect.", preferredStyle: .alert)
                    ac.addAction(UIAlertAction(title: "Try again", style: .default, handler: continuePlaying))
                    present(ac, animated: true)
        }
    }
    
    func continuePlaying(_ action: UIAlertAction){
        score -= 1
        currentAnswer.text?.removeAll()
        for sender in activatedButtons {
            sender.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func levelUp(_ action: UIAlertAction){
        level += 1
        solutions.removeAll(keepingCapacity: true)
        loadLevel()
        for button in letterButtons {
            button.isHidden = false
        }
    }

    @objc func clearTapped(_ sender: UIButton) {
        currentAnswer.text?.removeAll()
        for sender in activatedButtons {
            sender.isHidden = false
        }
        activatedButtons.removeAll()
    }
    
    func loadLevel(){
        var clueString = ""
        var solutionString = ""
        var letterBits = [String]()
        
        if let levelFileURL = Bundle.main.url(forResource: "level\(level)", withExtension: "txt"){
            if let levelContent = try? String(contentsOf: levelFileURL){
                var lines = levelContent.components(separatedBy: "\n").filter{ str in
                    return !str.isEmpty
                }
                lines.shuffle()
                
                for (index, line) in lines.enumerated(){
                    let parts = line.components(separatedBy: ": ")
                    let answer = parts[0]
                    let clue = parts[1]
                    
                    clueString.append("\(index + 1). \(clue)\n")
                    
                    let solutionWord = answer.replacingOccurrences(of: "|", with: "")
                    solutions.append(solutionWord)
                    solutionString.append("\(solutionWord.count) letters\n")
                    
                    let bits = answer.components(separatedBy: "|")
                    letterBits.append(contentsOf: bits)
                }
            }
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.cluesLabel.text =  clueString.trimmingCharacters(in: .whitespacesAndNewlines)
            self?.answersLabel.text = solutionString.trimmingCharacters(in: .whitespacesAndNewlines)
            letterBits.shuffle()
        
            if letterBits.count == self?.letterButtons.count {
                for i in 0..<self!.letterButtons.count{
                    self?.letterButtons[i].setTitle(letterBits[i], for: .normal)
                }
            }
        }
      
    }
}

