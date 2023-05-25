//
//  Sport.swift
//  SportsApp
//
//  Created by Karim on 19/05/2023.
//

import Foundation
import UIKit

class Sport{
    var title: String
    var image: UIImage
    
    init(){
        title = "Unknown"
        image = UIImage(named: "SportImagePlaceholder")!
    }
    
    init(title: String,image: UIImage){
        self.title = title
        self.image = image
    }
}
