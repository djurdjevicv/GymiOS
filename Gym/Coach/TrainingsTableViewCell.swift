//
//  TrainingsTableViewCell.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 6.3.22..
//

import UIKit

class TrainingsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var coachUsernameLabel: UILabel!
    
    @IBOutlet weak var beginnerUsernameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var buttonCancle: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func cancleTapped(_ sender: Any) {
    }
    
}
