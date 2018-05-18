//
//  Question.swift
//  Trivia_Game
//
//  Created by Michael Hu on 14-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseDatabase


//MARK: - Struct

struct Question: Codable {
    var id: Int
    var question: String
    var correctAnswer: String
    var value: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case question
        case correctAnswer = "answer"
        case value
    }
}

struct Player {
    var name: String!
    var score: String!
    
    init(snapshot: DataSnapshot) {
        let snapshotValue = snapshot.value as! [String:AnyObject]
        
        name = snapshotValue["name"] as! String
        score = snapshotValue["score"] as! String
    }

}



