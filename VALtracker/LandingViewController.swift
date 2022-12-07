//
//  LandingViewController.swift
//  VALtracker
//
//  Created by Ignacio Gramajo on 11/10/22.
//

import UIKit
import Parse

class LandingViewController: UIViewController {
    
    var id: String?
    var ch = Character("#")
    var nameID = String()
    var tagline = String()
    
    var myTeamScores: [Int] = []
    var enemyTeamScores: [Int] = []
    var agentsPlayed: [String] = []
    var mySide: [Int] = []
    var redTeamPlayers = [[String]]()
    var blueTeamPlayers = [[String]]()
    var mapsPlayed: [String] = []

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var viewMatchLabel: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        welcomeLabel.text = "Welcome, " + (currentUser?.username ?? "NULL") + "!"
        let riotId = currentUser?["riotID"] as! String
        IDLabel.text = "Riot ID: " + riotId
        req()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //SPLITING NAME FROM DB HERE
        let currentUser = PFUser.current()
        id = currentUser?["riotID"] as! String
        var result = id?.split(separator: ch)
        nameID = String(result![0])
        tagline = String(result![1])
        print(nameID)
        print(tagline)



        // Do any additional setup after loading the view.
    }
    
    @IBAction func searchById(_ sender: Any) {
        let riotID = IDField.text
        
        //Matt your stuff will go here
        // I will add the code for searching from this VC after - MATT
    }
    
    func req(){
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
                    let players = arr[k]["players"] as! [String: Any]
                    let indv = players["all_players"] as! Array<Any>
                    let testPlayers = []
                    var redTeamP = [String]()
                    var blueTeamP = [String]()
                    
                    var me = indv[0] as! [String: Any]
                    var keyIndexPlayer = 0
                    
                    for i in 0...9{
                        me = indv[i] as! [String: Any]
                        print("==================")
                        print(me) //me["stats"] for KDA
                        print("==================")
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

                print(self.redTeamPlayers)
                print(self.blueTeamPlayers)
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "viewMatchesSegue"){
            let displayVC = segue.destination as! MatchTableViewController
            displayVC.myTeamScores = myTeamScores
            displayVC.enemyTeamScores = enemyTeamScores
            displayVC.agentsPlayed = agentsPlayed
            displayVC.redTeam = redTeamPlayers
            displayVC.blueTeam = blueTeamPlayers
            displayVC.mySide = mySide
        }
    }
    

}
