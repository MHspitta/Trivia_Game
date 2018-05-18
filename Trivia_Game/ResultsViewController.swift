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
    }
    
    //MARK: - Functions

    // Function when submit button pressed
    @IBAction func uploadToLeaderboard(_ sender: UIButton) {
        upload()
        nameInput.text = ""
        submitButton.isEnabled = false
    }
    
    // Function to upload the score and retrieve name
    func upload() {
        var name: String = nameInput.text!
        let leaderboardScore: String = String(score)
        
        // Check if name is not empty
        if name == "" {
            name = "Anonymous"
        }
        
        // Send data to Firebase database
        self.ref.child("Results").childByAutoId().setValue(["name": name, "score": leaderboardScore])
    }
}

