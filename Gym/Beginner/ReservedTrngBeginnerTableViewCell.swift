//
//  ReservedTrngBeginnerTableViewCell.swift
//  Gym
//
//  Created by Vladimir Djurdjevic on 7.3.22..
//

import UIKit

class ReservedTrngBeginnerTableViewCell: UITableViewCell {

    @IBOutlet weak var reserveButton: UIButton!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var beginnerLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }
    
}
