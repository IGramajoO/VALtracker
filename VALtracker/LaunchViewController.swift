//
//  LaunchViewController.swift
//  VALtracker
//
//  Created by Matthew Peters on 11/14/22.
//

import UIKit
import Alamofire


class LaunchViewController: UIViewController {
    
    @IBOutlet weak var searchTextField: UITextField!
    //var jsonData;
    var mmr = [[String:Any]]()
    //    var data = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        req()
        //            let MmrSearchViewController = self.storyboard?.instantiateViewController(withIdentifier: "MmrSearchViewController") as! MmrSearchViewController
        //            MmrSearchViewController.id = searchTextField.text ?? "Tenz#6666"
        //            self.navigationController?.pushViewController(MmrSearchViewController, animated: true)
        
        //
        //api()
        
        
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
    
    //our same framework for mmr api
    func req(){
        let url = URL(string: "https://api.henrikdev.xyz/valorant/v3/matches/na/petes/3333?filter=competitive")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: [])
                print(dataDictionary)
                print("-------------------")
                
                
                
                //                let data = dataDictionary["data"] as! [String: Any]
                //                for (key, value) in data {
                //                    print("(\(key),\(value))")
                //                }
                //
                //                print("-------------------")
                //                print(data["name"] as! String)
                
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
    }
    //    struct Post:Codable{
    //        let data: Dictionary<String, Any>
    //    }
    ////
    //    func reqMmrData(){
    //        let url = URL(string: "https://api.henrikdev.xyz/valorant/v3/matches/na/petes/3333?filter=competitive")!
    //        let task = URLSession.shared.dataTask(with: url){
    //                data, response, error in
    //
    //                let decoder = JSONDecoder()
    //
    //                if let data = data{
    //                    do{
    //                        let tasks = try decoder.decode([Post].self, from: data)
    //                        tasks.forEach{ i in
    //                            print(i.data)
    //                        }
    //                    }catch{
    //                        print(error)
    //                    }
    //                }
    //            }
    //            task.resume()
    //
    //        }
    //    func api(){
    //
    //        guard let url = URL(string: "https://api.henrikdev.xyz/valorant/v3/matches/na/petes/3333?filter=competitive") else{
    //            return
    //        }
    //
    //
    //        let task = URLSession.shared.dataTask(with: url){
    //            data, response, error in
    //
    //            if let data = data, let string = String(data: data, encoding: .utf8){
    //                print(string)
    //            }
    //        }
    //
    //        task.resume()
    //    }
    //    }
    
    
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
