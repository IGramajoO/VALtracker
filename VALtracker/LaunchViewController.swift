//
//  LaunchViewController.swift
//  VALtracker
//
//  Created by Matthew Peters on 11/14/22.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    //var jsonData;
    var mmr = [[String:Any]]()
    //    var data = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //req()
        //            let MmrSearchViewController = self.storyboard?.instantiateViewController(withIdentifier: "MmrSearchViewController") as! MmrSearchViewController
        //            MmrSearchViewController.id = searchTextField.text ?? "Tenz#6666"
        //            self.navigationController?.pushViewController(MmrSearchViewController, animated: true)
        
        //
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendToSearchScreen(_ sender: Any) {
        self.performSegue(withIdentifier: "launchVCtoMmrVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "launchVCtoMmrVC"){
            let displayVC = segue.destination as! MmrSearchViewController
            displayVC.id = searchTextField.text
        }
    }
    
    //    var jsonData: [String: Any]
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if(segue.identifier == "launchVCtoMmrVC"){
    //                let displayVC = segue.destination as! MmrSearchViewController
    //                displayVC.id = searchTextField.text
    //        }
    //    }
    
    
    func req(){
        //NAME AND TAGLINE GO HERE LIKE THIS na/\(nameID)/\(tagline)
        // nameID and tagline come from the variables after the character split in ViewDidLoad before the req() call
        let url = URL(string: "https://api.henrikdev.xyz/valorant/v3/matches/na/petes/3333")!
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
                               // print("--------------------------------------------------------")
                //                print(arr[1]["players"])
                              //  print("========================================================")
                                let arrB = arr[1]["metadata"] as! [String: Any]
                                let arrA = arr[0]["metadata"] as! [String: Any]
                               // print(arrA)
                              //  print("*************")
                               // print(arrB)
                print("***********")
               //either red or blue team
                var myTeamsArray = []
                var enemyTeamsArray = []
            
              //scored depedning on if the users team is red or blue. The opposite is put into enemyTeamScores
                var myTeamScores = []
                var enemyTeamScores = []
                var agentsPlayed = []
                var myTeam = "none"
                var name = "noName"
                
                for i in 0...4{
                    let players = arr[i]["players"] as! [String: Any]
                    let indv = players["all_players"] as! Array<Any>
                    var me = indv[0] as! [String: Any]
                    var keyIndexPlayer = 0
            
                    for i in 0...9{
                        me = indv[i] as! [String: Any]
                        name = me["name"] as! String
                        //NAME CHANGE HERE
                        if(name as! String == "petes"){
                            keyIndexPlayer = i
                            myTeam = me["team"] as! String
                            myTeamsArray.append(myTeam)
                            agentsPlayed.append(me["character"] as! String)
                            break
                        }
                    }
                }
                //fill in red or blue teams in enemyTeamsArray
//                for i in 0...4{
//                    if(myTeamsArray[i] as! String == "Red"){
//                        enemyTeamsArray.append("Blue")
//                    }
//                    else{
//                        enemyTeamsArray.append("Red")
//                    }
//                }
                
               // let me = indv[1] as! [String: Any]
               // let name = me["name"]
                print(name)
                //print(myTeam)
                print(myTeamsArray)
                print(enemyTeamsArray)
                
                var redTeam = []
                var blueTeam = []
                for i in 0...4{
                    let teams = arr[i]["teams"] as! [String: Any]
                    let red = teams["red"] as! [String: Any]
                    let blue = teams["blue"] as! [String: Any]
                    redTeam.append(red["rounds_won"] as! Int)
                    blueTeam.append(blue["rounds_won"] as! Int)
                }
                print(redTeam)
                print(blueTeam)
                
                for i in 0...4{
                    if(myTeamsArray[i] as! String == "Red"){
                        myTeamScores.append(redTeam[i] as! Int)
                        enemyTeamScores.append(blueTeam[i] as! Int)
                    }
                    else{
                        myTeamScores.append(blueTeam[i] as! Int)
                        enemyTeamScores.append(redTeam[i] as! Int)
                    }
                }
                print("##############")
                print(myTeamScores)
                print(enemyTeamScores)
                print("^^^^^^^^^^^^^^^^^^^")
                print(agentsPlayed)
                
                
                
            }
        }
        task.resume()
        
        
        
        // MARK: - Navigation
        //  In a storyboard-based application, you will often want to do a little preparation before navigation
        //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //        //Get the new view controller using segue.destination.
        //        // Pass the selected object to the new view controller.
        //        if(segue.identifier == "launchVCtoMmrVC"){
        //            let displayVC = segue.destination as! MmrSearchViewController
        //            displayVC.id = searchTextField.text
        //        }
        //    }
        
        
        //}
    }
}
