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
       // ivTeamLogo.sd_setImage(with:URL(string: teamLogo ?? ""), placeholderImage: UIImage(named:"SportImagePlaceholder")!)
        

        self.ivTeamLogo.sd_setImage(with: URL(string: teamLogo ?? ""), placeholderImage: UIImage(named: "SportImagePlaceholder")!){
            image,error,cacheType,url in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.ivTeamLogo.image = UIImage(named: "SportImagePlaceholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.ivTeamLogo.image = image
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
