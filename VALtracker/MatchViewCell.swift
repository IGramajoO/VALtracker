//
//  MatchViewCell.swift
//  VALtracker
//
//  Created by Ignacio Gramajo on 12/1/22.
//

import UIKit

class MatchViewCell: UITableViewCell {

    @IBOutlet weak var userOperatorView: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var redTeamLabel: UILabel!
    @IBOutlet weak var blueTeamLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
