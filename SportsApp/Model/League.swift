//
//  League.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import Foundation
import UIKit

class League{
    var title: String?
    var image: String?
    var league_key: Int?
    
    init(){
        self.title = "Unknown"
        self.league_key = -1
        self.image = "SportImagePlaceholder"
    }
    
    init(title: String,league_key: Int,image: String){
        self.title = title
        self.league_key = league_key
        self.image = image
    }
}
