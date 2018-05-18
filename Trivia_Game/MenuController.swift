//
//  MenuController.swift
//  Trivia_Game
//
//  Created by Michael Hu on 14-05-18.
//  Copyright © 2018 Michael Hu. All rights reserved.
//

import Foundation
import UIKit


class MenuController {

    //MARK: - Variables
    
    // variables
    static let shared = MenuController()
    
    let baseURL = URL(string: "http://jservice.io/api/random")!

    // MARK: - Functions

    // Function to fetch all questions and put them in the struct
    func fetchQuestions(completion: @escaping ([Question]?)-> Void) {
        
        let task = URLSession.shared.dataTask(with: baseURL) { (data, response, error) in
            
            let jsonDecoder = JSONDecoder()
            if let data = data, let question = try? jsonDecoder.decode([Question].self, from: data) {
                print(question)
                completion(question)
                
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
