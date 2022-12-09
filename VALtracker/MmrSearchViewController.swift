//
//  MmrSearchViewController.swift
//  VALtracker
//
//  Created by Matthew Peters on 11/14/22.
//

import UIKit
import AlamofireImage
import Foundation


class MmrSearchViewController: UIViewController {
    
    
    //var id = String();
    var id: String?
    var ch = Character("#")
    var nameID = String()
    var tagline = String()
    var elo = 0;
    //    var result = id.split(separator: ch)
    //    print("Result : \(result)")
    
    //For recent matches
    var myTeamScores: [Int] = []
    var enemyTeamScores: [Int] = []
    var agentsPlayed: [String] = []
    var mySide: [Int] = []
    var redTeamPlayers = [[String]]()
    var blueTeamPlayers = [[String]]()
    var mapsPlayed: [String] = []
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var mmrLabel: UILabel!
    
    @IBOutlet weak var rankImageView: UIImageView!
    
    @IBOutlet weak var pfpImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id as! String)
        var result = id?.split(separator: ch)
        nameID = String(result![0])
        tagline = String(result![1])
        print(nameID, " ", tagline)
        reqAccountInfo()
        reqMmrData()
        // Do any additional setup after loading the view.
    }
    
    
    func reqAccountInfo(){
        let url = URL(string: "https://api.henrikdev.xyz/valorant/v1/account/\(nameID)/\(tagline)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                print(dataDictionary)
                print("-------------------")
                
                let data = dataDictionary["data"] as! [String: Any]
                for (key, value) in data {
                    print("(\(key),\(value))")
                }
                
                print("-------------------")
                
                let accountImageData = data["card"] as! [String:Any]
                let pfpUrl = URL(string:accountImageData["small"] as! String)!
                self.pfpImageView.af.setImage(withURL: pfpUrl)
                //                for (key, value) in imageData {
                //                    print("(\(key),\(value))")
                //                }
                
                
                
                //FOR rank TO SHOW NEXT TO NAME: NEEDS ALAMOFIREIMAGE
                //                let rankUrl = URL(string:rankImageData["small"] as! String)!
                //                self.rankImageView.af.setImage(withURL: rankUrl)
                //
            }
        }
        task.resume()
    }
        
        
        func reqMmrData(){
            let url = URL(string: "https://api.henrikdev.xyz/valorant/v1/mmr/na/\(nameID)/\(tagline)")!
            let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
            let task = session.dataTask(with: request) { (data, response, error) in
                // This will run when the network request returns
                if let error = error {
                    print(error.localizedDescription)
                } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    //                print(dataDictionary)
                    print("-------------------")
                    
                    let data = dataDictionary["data"] as! [String: Any]
                    //                for (key, value) in data {
                    //                    print("(\(key),\(value))")
                    //                }
                    //
                    //                print("-------------------")
                    let rankImageData = data["images"] as! [String:Any]
                    //                for (key, value) in imageData {
                    //                    print("(\(key),\(value))")
                    //                }
                    print(data["name"] as! String)
                    let name = data["name"] as! String
                    //self.nameLabel.text = data["name"] as! String
                    self.nameLabel.text = name
                    
                    let rank = data["currenttierpatched"] as! String
                    self.rankLabel.text = rank
                    
                    //self.elo = data["elo"] as! Int
                    self.eloLabel.text = "Elo: " + String(data["elo"] as! Int)
                    
                    self.mmrLabel.text = "MMR Change " +  String(data["mmr_change_to_last_game"] as! Int)
                    
                    //FOR rank TO SHOW NEXT TO NAME: NEEDS ALAMOFIREIMAGE
                    let rankUrl = URL(string:rankImageData["small"] as! String)!
                    self.rankImageView.af.setImage(withURL: rankUrl)
                    
                    //                print(self.data)
                    // let dict: [[String:Any]]() = dataDictionary["data"]
                    //print(dict{0})
                    //  self.mmr = dataDictionary["data"] as! [[String:Any]]
                    //let mmrArray = self.mmr[indexPath.row]
                    //print(mmr["name"])
                    //  print(self.mmr)
                    //
                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                    
                }
            }
            task.resume()
            
            /*
             // MARK: - Navigation
             
             // In a storyboard-based application, you will often want to do a little preparation before navigation
             override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             // Get the new view controller using segue.destination.
             // Pass the selected object to the new view controller.
             }
             */
            
        }
    
    func reqMatches(){
//        viewMatchLabel.isEnabled = false

        //NAME AND TAGLINE GO HERE LIKE THIS na/\(nameID)/\(tagline)
        // nameID and tagline come from the variables after the character split in ViewDidLoad before the req() call
        let url = URL(string: "https://api.henrikdev.xyz/valorant/v3/matches/na/\(nameID)/\(tagline)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDict = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //                print(dataDict)
                let arr = dataDict["data"] as! [[String: Any]]
           
                // print(arrA)
                //  print("*************")
                // print(arrB)
//                print("***********")
                //either red or blue team
                var myTeamsArray = []
                var enemyTeamsArray = []
                
                //scored depedning on if the users team is red or blue. The opposite is put into enemyTeamScores

                var myTeam = "none"
                var name = "noName"
                
                for k in 0...4{
                    let metadata = arr[k]["metadata"] as! [String: Any]
                    let players = arr[k]["players"] as! [String: Any]
                    let indv = players["all_players"] as! Array<Any>
                    let testPlayers = []
                    var redTeamP = [String]()
                    var blueTeamP = [String]()
                    
                    self.mapsPlayed.append(metadata["map"] as! String)
                    
                    var me = indv[0] as! [String: Any]
                    var keyIndexPlayer = 0
                    
                    for i in 0...9{
                        me = indv[i] as! [String: Any]
//                        print("==================")
//                        print(me["stats"]) //me["stats"] for KDA
//                        print("==================")
                        name = me["name"] as! String
                        //NAME CHANGE HERE
                        if(me["team"] as! String == "Red"){
                            redTeamP.append(name)
                        }
                        else{
                            blueTeamP.append(name)
                        }
                        
                        if(name == self.nameID){
                            keyIndexPlayer = i
                            myTeam = me["team"] as! String
                            myTeamsArray.append(myTeam)
                            self.agentsPlayed.append(me["character"] as! String)
//                            break
                        }
                    }
                    self.redTeamPlayers.append(redTeamP)
                    self.blueTeamPlayers.append(blueTeamP)

                }
                print("==================")

//                print(self.redTeamPlayers)
//                print(self.blueTeamPlayers)
//                print(arr[i])
                print("==================")


                //print(name)
                //print(myTeam)
                //print(myTeamsArray)
                //print(enemyTeamsArray)
                
                var redTeam = []
                var blueTeam = []
                for i in 0...4{
                    let teams = arr[i]["teams"] as! [String: Any]
                    let red = teams["red"] as! [String: Any]
                    let blue = teams["blue"] as! [String: Any]
                    redTeam.append(red["rounds_won"] as! Int)
                    blueTeam.append(blue["rounds_won"] as! Int)
                }
//                print(redTeam)
//                print(blueTeam)
                
                for i in 0...4{
                    if(myTeamsArray[i] as! String == "Red"){
                        self.mySide.append(1)
                        self.myTeamScores.append(redTeam[i] as! Int)
                        self.enemyTeamScores.append(blueTeam[i] as! Int)
                    }
                    else{
                        self.mySide.append(0)
                        self.myTeamScores.append(blueTeam[i] as! Int)
                        self.enemyTeamScores.append(redTeam[i] as! Int)
                    }
                }
//                print("##############")
//                print(self.myTeamScores)
//                print(self.enemyTeamScores)
//                print("^^^^^^^^^^^^^^^^^^^")
//                print(self.agentsPlayed)
                
            }
        }
        
//        viewMatchLabel.alpha = 1.0
        task.resume()
    }
    }

