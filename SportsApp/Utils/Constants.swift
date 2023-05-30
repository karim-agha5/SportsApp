//
//  Constants.swift
//  SportsApp
//
//  Created by Karim on 23/05/2023.
//

import Foundation

class Constants{
    
    static let BASE_URL: String = "https://apiv2.allsportsapi.com/"
    
    static let PRE_API_KEY: String = "/?met=Leagues&APIkey="
    
    static let API_KEY: String = "437a0a08beafa927728387658df31aee617a02a2d90bba7fdbca43a37c594af7"
    
    static let FOOTBALL: String = "football"
    
    static let BASKETBALL: String = "basketball"
    
    static let CRICKET: String = "cricket"
    
    static let TENNIS: String = "tennis"
    
    static let UPCOMING_FOOTBALL_MATCHES = BASE_URL + "football/?met=Fixtures&" + API_KEY + "&from=2023-05-29&to=2023-06-10"
    
    static let UPCOMING_BASKETBALL_MATCHES = BASE_URL + "basketball/?met=Fixtures&" + API_KEY + "&from=2023-05-29&to=2023-06-10"
    
    static let UPCOMING_CRICKET_MATCHES = BASE_URL + "cricket/?met=Fixtures&" + API_KEY + "&from=2023-05-29&to=2023-06-10"
    
    static let UPCOMING_TENNIS_MATCHES = BASE_URL + "tennis/?met=Fixtures&" + API_KEY + "&from=2023-05-29&to=2023-06-10"
    
   /*
    private let footballUrlString = "https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=437a0a08beafa927728387658df31aee617a02a2d90bba7fdbca43a37c594af7"
    */
}
