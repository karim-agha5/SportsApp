//
//  League.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import Foundation
import UIKit

class League{
    var title: String
    var image: String
    
    init(){
        self.title = "Unknown"
        self.image = "SportImagePlaceholder"
    }
    
    init(title: String,countryName: String,image: String){
        self.title = title
        self.image = image
    }
}
