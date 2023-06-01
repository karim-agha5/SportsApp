//
//  CustomLeagueDetailsTableViewCell.swift
//  SportsApp
//
//  Created by Karim on 31/05/2023.
//

import UIKit

class CustomLeagueDetailsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var ivTeamOne: UIImageView!
    
    
    @IBOutlet weak var ivTeamTwo: UIImageView!
    
    
    @IBOutlet weak var labelTeamOne: UILabel!
    
    
    @IBOutlet weak var labelTeamTwo: UILabel!
    
    
    @IBOutlet weak var labelScore: UILabel!
    
    
    func setupCell(firstLogo: String?,
                   secondLogo: String?,
                   firstName: String?,
                   secondName: String?,
                   score: String?
    ){
        ivTeamOne.sd_setImage(with:URL(string: firstLogo ?? ""), placeholderImage: UIImage(named:"SportImagePlaceholder")!)
        
        ivTeamTwo.sd_setImage(with:URL(string: secondLogo ?? ""), placeholderImage: UIImage(named:"SportImagePlaceholder")!)
        
        labelTeamOne.text = firstName
        labelTeamTwo.text = secondName
        
        labelScore.text = score
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
