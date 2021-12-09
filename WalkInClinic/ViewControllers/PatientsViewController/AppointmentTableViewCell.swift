//
//  AppointmentTableViewCell.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import UIKit

class AppointmentTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var doctor: UILabel!
    @IBOutlet weak var title: UILabel!
    
}
