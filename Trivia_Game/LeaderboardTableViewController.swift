//
//  LeaederboardTableViewController.swift
//
//
//  Created by Michael Hu on 17-05-18.
//

import UIKit
import Firebase
import FirebaseDatabase

class LeaderboardTableViewController: UITableViewController {
    
    // MARK: - Variables
    
    var ref: DatabaseReference!
    var refHandle: UInt!
    var players: [Player] = []
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        fetchPlayers()
    }
    
    // Update the tableview
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardCell", for: indexPath)
        let playerStat = players[indexPath.row]
        
        // Update textlabel en detail label
        cell.textLabel?.text = playerStat.name
        cell.detailTextLabel?.text = playerStat.score
        
        return cell
        
    }
    
    // Set number of sections
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    //MARK: - Functions
    
    // Function to fetch players from database
    func fetchPlayers() {
        refHandle = ref.child("Results").observe(.value, with: { (snapshot) in
            
            if (snapshot.value as? [String : AnyObject]) != nil {
                
                var PlayerX: [Player] = []
                
                // Itereate over snapshot en save each snapshot
                for child in snapshot.children {
                    let player = Player(snapshot: child as! DataSnapshot)
                    PlayerX.append(player)
                }
                
                self.players = PlayerX
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        })
    }
}
