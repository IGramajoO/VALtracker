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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
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
        return 180.0;//Choose your custom row height
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //TODO: temp value of 5, change to allow loading more matches if we want
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "matchViewCell", for: indexPath) as! MatchViewCell
        
//         let user = tweetArray[indexPath.row]["user"] as! NSDictionary
        
//        cell.blueTeamLabel.text = "test1\ntest2\ntest1\ntest2\ntest1"
        cell.scoreLabel.text = String(myTeamScores[indexPath.row]) + " - " + String(enemyTeamScores[indexPath.row])
        cell.agentLabel.text = agentsPlayed[indexPath.row]
        
//         cell.userNameLabel.text = user["name"] as? String
//         cell.tweetContent.text = tweetArray[indexPath.row]["text"] as? String
//
//         let imageUrl = URL(string: (user["profile_image_url_https"] as? String)!)
//         let data = try? Data(contentsOf: imageUrl!)
//
//         if let imageData = data {
//
//             cell.profileImage.image = UIImage(data: imageData)
//         }
//
//         cell.setFavorited(tweetArray[indexPath.row]["favorited"] as! Bool)
//         cell.tweetId = tweetArray[indexPath.row]["id"] as! Int
//         cell.setRetweeted(tweetArray[indexPath.row]["retweeted"] as! Bool)
         
         return cell
    }



}
