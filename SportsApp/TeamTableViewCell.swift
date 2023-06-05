//
//  TeamTableViewCell.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit
import SDWebImage

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var customView: UIView!
    
    @IBOutlet weak var teamImageView: UIImageView!
    
    @IBOutlet weak var teamLabel: UILabel!
    
    func setupCell(withTeamName teamName: String, andTeamImageUrl teamImageUrl: String){
        customView.layer.cornerRadius = 20
        self.teamImageView.layer.masksToBounds = false
        self.teamImageView.layer.cornerRadius = (self.teamImageView.frame.size.width + self.teamImageView.frame.size.height) / 4
        self.teamImageView.clipsToBounds = true
        self.teamImageView.contentMode = .scaleAspectFill
        
        
        self.teamLabel.text = teamName
        self.teamImageView.sd_setImage(with: URL(string: teamImageUrl), placeholderImage: UIImage(named: "SportImagePlaceholder")!){
            image,error,cacheType,url in
            
            if error != nil {
                DispatchQueue.main.async {
                    self.teamImageView.image = UIImage(named: "SportImagePlaceholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self.teamImageView.image = image
            }
        }
        
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
