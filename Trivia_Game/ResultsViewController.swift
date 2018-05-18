//
//  ResultsViewController.swift
//  Trivia_Game
//
//  Created by Michael Hu on 16-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ResultsViewController: UIViewController {
    
    //MARK: - Outlets
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var nameInput: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    //MARK: - Variables
    
    var score: Int = 0
    var ref: DatabaseReference!
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        scoreLabel.text = "Your score is \(score)!!"
//        updateSubmitButton()
    }
    
//    // Function to check if there is a input
//    @IBAction func textInput(_ sender: UITextField) {
//        updateSubmitButton()
//    }
    
    //MARK: - Functions
    
    // Function when submit button pressed
    @IBAction func uploadToLeaderboard(_ sender: UIButton) {
        upload()
    }
    
//    // Function that dismisses keyboard when return is pressed
//    @IBAction func returnPressed(_ sender: UITextField) {
//        nameInput.resignFirstResponder()
//    }
    
//    // Function to disable and enbale the submit button
//    func updateSubmitButton() {
//        let text = nameInput.text ?? ""
//        submitButton.isEnabled = !text.isEmpty
//    }
    
    // Function to upload the score and retrieve name
    func upload() {
        let name: String = nameInput.text!
        let leaderboardScore: String = String(score)
        
        self.ref.child("Results").childByAutoId().setValue(["name": name, "score": leaderboardScore])
    }
}

