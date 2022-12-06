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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc func loadMatches(){
        
//        numberOfTweet = 20
//        let myUrl = "https://api.twitter.com/1.1/statuses/home_timeline.json"
//        let myParams = ["count": numberOfTweet]
        
//        TwitterAPICaller.client?.getDictionariesRequest(url: myUrl, parameters: myParams, success:
//            { (tweets: [NSDictionary]) in
//
//            self.tweetArray.removeAll()
//            for tweet in tweets{
//                self.tweetArray.append(tweet)
//            }
//            self.tableView.reloadData()
//            self.refreshControl?.endRefreshing()
//
//        }, failure: { (Error) in
//            print("Could not retrieve tweets!")
//        })
        
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0;
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        
        var agentNamePic = ""
        if(agentsPlayed[indexPath.row] == "KAY/O"){
            agentNamePic = "agent_Kayo"
        }
        else{
            agentNamePic = "agent_" + agentsPlayed[indexPath.row]

        }
        cell.operatorView.image = UIImage(named: agentNamePic)
//
//         let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
//         let data = try? Data(contentsOf: imageUrl!)
//
//         if let imageData = data {
//
//             cell.profileImage.image = UIImage(data: imageData)
//         }
//
         
         return cell
    }



}
