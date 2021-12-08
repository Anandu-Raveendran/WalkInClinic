//
//  DoctorsListTableViewCell.swift
//  WalkInClinic
//
//  Created by Anandu on 2021-12-08.
//

import UIKit

class DoctorsListTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var dpimage: UIImageView!
    
    @IBOutlet weak var specialisation: UILabel!
    
    @IBOutlet weak var consultation: UILabel!
    
    @IBOutlet weak var location: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
