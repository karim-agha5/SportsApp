//
//  SportsCollectionViewCell.swift
//  SportsApp
//
//  Created by Karim on 19/05/2023.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sportImageView: UIImageView!
    
    @IBOutlet weak var sportTitle: UILabel!
    
    func initCell(sport: Sport){
        sportTitle.text = sport.title
        sportImageView.image = sport.image
    }
}
