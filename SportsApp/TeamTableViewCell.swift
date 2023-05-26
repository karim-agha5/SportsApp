//
//  TeamTableViewCell.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit
import SDWebImage

class TeamTableViewCell: UITableViewCell {

    
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBOutlet weak var teamLabel: UILabel!
    
    
    func setupCell(withTeamName teamName: String, andTeamImage teamImage: UIImage){
        self.teamLabel.text = teamName
        self.teamImageView.image = teamImage
        self.teamImageView.layer.masksToBounds = false
        self.teamImageView.layer.cornerRadius = self.teamImageView.frame.size.width / 2
        self.teamImageView.clipsToBounds = true
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
