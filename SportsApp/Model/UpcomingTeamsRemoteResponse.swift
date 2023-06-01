//
//  UpcomingTeamsRemoteResponse.swift
//  SportsApp
//
//  Created by Karim on 29/05/2023.
//

import Foundation

class UpcomingTeamsRemoteResponse : Decodable{
    let success: Int?
    let result: [UpcomingMatch]?
}

class UpcomingMatch : Decodable{
    
    init(){
        self.event_date = ""
        self.event_date_start = ""
        self.event_time = ""
        self.event_home_team = ""
        self.event_away_team = ""
        self.event_first_player = ""
        self.event_second_player = ""
        self.home_team_logo = ""
        self.away_team_logo = ""
        self.event_home_team_logo = ""
        self.event_away_team_logo = ""
        self.event_first_player_logo = ""
        self.event_second_player_logo = ""
    }
    
    //football / basketball / tennis
    var event_date: String?
    
    // cricket
    var event_date_start: String?
    
    // football / basketball / cricket / tennis
    var event_time: String?
    
    // football/ basketball / cricket
    var event_home_team: String?
    var event_away_team: String?
    
    // tennis
    var event_first_player: String?
    var event_second_player: String?
    
    // football
    var home_team_logo: String?
    var away_team_logo: String?
    
    // basketball / cricket
    var event_home_team_logo: String?
    var event_away_team_logo: String?
    
    // tennis
    var event_first_player_logo: String?
    var event_second_player_logo: String?
    
    // football
    var event_final_result: String?
    
}
