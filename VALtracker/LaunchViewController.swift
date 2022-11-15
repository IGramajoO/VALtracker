//
//  LaunchViewController.swift
//  VALtracker
//
//  Created by Matthew Peters on 11/14/22.
//

import UIKit

class LaunchViewController: UIViewController {
    
    //var jsonData;
    var mmr = [[String:Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        req()
        
//
        
       
        // Do any additional setup after loading the view.
    }
//    var jsonData: [String: Any]
    
    func req(){
        let url = URL(string: "https://api.henrikdev.xyz/valorant/v1/mmr/na/petes/3333")!
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
                print(dataDictionary["data"]["elo"])
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
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
