//
//  LandingViewController.swift
//  VALtracker
//
//  Created by Ignacio Gramajo on 11/10/22.
//

import UIKit
import Parse

class LandingViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var IDField: UITextField!
    @IBOutlet weak var IDLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        let currentUser = PFUser.current()
        welcomeLabel.text = "Welcome, " + (currentUser?.username ?? "NULL") + "!"
        let riotId = currentUser?["riotID"] as! String
        IDLabel.text = "Riot ID: " + riotId
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func searchById(_ sender: Any) {
        let riotID = IDField.text
        
        //Matt your stuff will go here
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
