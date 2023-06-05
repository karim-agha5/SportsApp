//
//  CustomPlayerDetailsCollectionViewCell.swift
//  SportsApp
//
//  Created by Karim on 04/06/2023.
//

import UIKit

class CustomPlayerDetailsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var ivPlayer: UIImageView!
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    @IBOutlet weak var playerAgeLabel: UILabel!
    
    func setupCell(
        playerImageUrl: String?,
        playerName: String?,
        playerAge: String?
    ){
        
        self.ivPlayer.sd_setImage(with: URL(string: playerImageUrl ?? ""), placeholderImage: UIImage(named: "FootballImage")!){
            image,error,cacheType,url in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.ivPlayer.image = UIImage(named: "FootballImage")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.ivPlayer.image = image
            }
        }
        
        self.playerNameLabel.text = playerName ?? "Unknown"
        self.playerAgeLabel.text = playerAge ?? "Unknown"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
