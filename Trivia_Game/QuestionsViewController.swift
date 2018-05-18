//
//  QuestionsViewController.swift
//  Trivia_Game
//
//  Created by Michael Hu on 15-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import UIKit

class QuestionsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answer: UITextField!
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    //MARK: - Variables
    
    var questions = [Question]()
    var answerGiven: String = ""
    let maxQuestions = 10
    var questionIndex = 0
    var correctAnswer: String = ""
    var score: Int = 0
    var value: Int = 0
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    // Function to push over to menu detail table
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultSegue" {
            let resultsViewController = segue.destination as! ResultsViewController
            resultsViewController.score = score
        }
    }
    
    //MARK: - Functions
    
    // Submit answer button function
    @IBAction func submitAnswer(_ sender: Any) {
        answerGiven = answer.text ?? "No Answer"
        
        if answer.text != "No Answer" {
            checkAnswer()
        }
        nextQuestion()
    }
    
    // Function to update the question and labels etc
    func updateUI() {
        MenuController.shared.fetchQuestions { (questions) in
            if let questions = questions {
                DispatchQueue.main.async {
                    self.questions = questions
                    self.questionLabel.text = questions[0].question
                }
                self.correctAnswer = questions[0].correctAnswer
                if questions[0].value != nil {
                    self.value = questions[0].value!
                } else {
                    self.value = 200
                }
            }
        }
        scoreLabel.text = "Score: \(score)"
        answer.text = ""
    }
    
    // Function to go to the next questions
    func nextQuestion() {
        questionIndex += 1
        
        if questionIndex < maxQuestions {
            updateUI()
        } else {
            performSegue(withIdentifier: "ResultSegue", sender: nil)
        }
    }
    
    // Function to check the answer
    func checkAnswer() {
        if answerGiven.lowercased() == correctAnswer.lowercased() {
            score += value
        }
    }
}



