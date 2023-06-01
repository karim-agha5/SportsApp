//
//  CustomLeagueDetailsCollectionViewCell.swift
//  SportsApp
//
//  Created by Karim on 30/05/2023.
//

import UIKit

class CustomLeagueDetailsCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var ivTeamOne: UIImageView!
    
    
    @IBOutlet weak var ivTeamTwo: UIImageView!
    
    
    @IBOutlet weak var labelTeamOne: UILabel!
    
    
    
    @IBOutlet weak var labelTeamTwo: UILabel!
    
    
    @IBOutlet weak var labelDate: UILabel!
    
    
    
    @IBOutlet weak var labelScore: UILabel!
    
    
    
    @IBOutlet weak var labelTime: UILabel!
    
    
    func setupCell(firstLogo: String?,
                      secondLogo: String?,
                      firstName: String?,
                      secondName: String?,
                      date: String?,
                      score: String?,
                      time: String?){
           
           ivTeamOne.sd_setImage(with:URL(string: firstLogo ?? ""), placeholderImage: UIImage(named:"SportImagePlaceholder")!)
           
           ivTeamTwo.sd_setImage(with:URL(string: secondLogo ?? ""), placeholderImage: UIImage(named:"SportImagePlaceholder")!)
           
           labelTeamOne.text = firstName
           labelTeamTwo.text = secondName
           
           labelDate.text = date
           labelScore.text = score
           labelTime.text = time
       }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
