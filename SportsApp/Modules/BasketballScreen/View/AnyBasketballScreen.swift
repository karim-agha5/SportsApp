//
//  AnyBasketballScreen.swift
//  SportsApp
//
//  Created by Karim on 24/05/2023.
//

import Foundation

protocol AnyBasketballScreen : AnyObject{
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>)
}
