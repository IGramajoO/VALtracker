//
//  MmrSearchViewController.swift
//  VALtracker
//
//  Created by Matthew Peters on 11/14/22.
//

import UIKit
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
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var rankLabel: UILabel!
    
    @IBOutlet weak var eloLabel: UILabel!
    
    @IBOutlet weak var mmrLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(id as! String)
        var result = id?.split(separator: ch)
        nameID = String(result![0])
        tagline = String(result![1])
        print(nameID, " ", tagline)
        req()
        // Do any additional setup after loading the view.
    }
    
    func req(){
        let url = URL(string: "https://api.henrikdev.xyz/valorant/v1/mmr/na/\(nameID)/\(tagline)")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print(dataDictionary)
                print("-------------------")
                
                let data = dataDictionary["data"] as! [String: Any]
                for (key, value) in data {
                    print("(\(key),\(value))")
                }
                
                print("-------------------")
                self.nameLabel.text = data["name"] as! String
                
                self.rankLabel.text = data["currenttierpatched"] as! String
                
                //self.elo = data["elo"] as! Int
                self.eloLabel.text = String(data["elo"] as! Int)
                
                self.mmrLabel.text = String(data["mmr_change_to_last_game"] as! Int)
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
}
