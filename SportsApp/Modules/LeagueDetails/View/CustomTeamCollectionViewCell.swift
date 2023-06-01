//
//  CustomTeamCollectionViewCell.swift
//  SportsApp
//
//  Created by Karim on 01/06/2023.
//

import UIKit

class CustomTeamCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ivTeamLogo: UIImageView!
    
    func setupCell(teamLogo: String?){
        ivTeamLogo.sd_setImage(with:URL(string: teamLogo ?? ""), placeholderImage: UIImage(named:"SportImagePlaceholder")!)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
