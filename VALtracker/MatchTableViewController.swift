//
//  MatchTableViewController.swift
//  VALtracker
//
//  Created by Ignacio Gramajo on 12/1/22.
//

import UIKit

class MatchTableViewController: UITableViewController {
    
    var myTeamScores: [Int] = []
    var enemyTeamScores: [Int] = []
    var agentsPlayed: [String] = []
    var redTeam: [[String]] = []
    var blueTeam: [[String]] = []
    var mySide: [Int] = []
    var mapsPlayed: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0;
    }

    override func numberOfSections(in tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return myTeamScores.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchViewCell", for: indexPath) as! MatchViewCell
        
        cell.scoreLabel.text = String(myTeamScores[indexPath.row]) + " - " + String(enemyTeamScores[indexPath.row])
        cell.agentLabel.text = agentsPlayed[indexPath.row]
        var blueTeamNames = ""
        var redTeamNames = ""
        
        //TODO check for users 
        for i in 0...4{
            //if red team, swap side
            if(mySide[indexPath.row] == 1){
                blueTeamNames += redTeam[indexPath.row][i] + "\n"
                redTeamNames += blueTeam[indexPath.row][i] + "\n"
            }
            else{
                blueTeamNames += blueTeam[indexPath.row][i] + "\n"
                redTeamNames += redTeam[indexPath.row][i] + "\n"
            }
        }
        cell.blueTeamLabel.text = blueTeamNames
        cell.redTeamLabel.text = redTeamNames
        var mapName = ""
        var agentNamePic = ""
        
        mapName = mapsPlayed[indexPath.row]
        if(agentsPlayed[indexPath.row] == "KAY/O"){
            agentNamePic = "agent_Kayo"
        }
        else{
            agentNamePic = "agent_" + agentsPlayed[indexPath.row]

        }
        cell.operatorView.image = UIImage(named: agentNamePic)
        cell.mapView.image = UIImage(named: mapName)
         
         return cell
    }



}
