//
//  AnyFootballScreen.swift
//  SportsApp
//
//  Created by Karim on 23/05/2023.
//

import Foundation

protocol AnyFootballScreen : AnyObject{
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>)
}
