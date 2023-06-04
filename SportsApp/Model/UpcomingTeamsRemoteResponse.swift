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
    
    // football - Basketball - tennis
    var event_final_result: String?
    
    // Cricket
    var event_home_final_result: String?
    var event_away_final_result: String?
    
    
    
    
    
    
 
    
}


class TeamResponse: Decodable{
    let success: Int?
    let result: [Team]?
}

class Team : Decodable{
    let team_name: String?
    let team_logo: String?
    
    init(){
        team_name = ""
        team_logo = ""
    }
}


class PlayerResponse: Decodable{
    let success: Int?
    let result: [Player]?
}

class Player : Decodable{
    let player_key: Int?
    let player_name: String?
    let player_number: String?
    let player_type: String?
    let player_age: String?
    let player_match_played: String?
    let player_goals: String?
    let player_yello_cards: String?
    let player_red_cards: String?
    let player_image: String?
    let player_logo: String?
    
}
