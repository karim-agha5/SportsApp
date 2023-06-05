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


class TeamResponse : Decodable{
    let success: Int?
    let result: [Team]?
}

class Team : Decodable{
    var team_key: Int?
    var team_name: String?
    var team_logo: String?
    var players: [Player]?
    
    init(){
        team_key = 0
        team_name = ""
        team_logo = ""
        players = []
    }
}


class PlayerResponse : Decodable{
    let success: Int?
    let result: [Player]?
}

class Player : Decodable{
    var player_key: Int?
    var player_name: String?
    var player_number: String?
    var player_type: String?
    var player_age: String?
    var player_match_played: String?
    var player_goals: String?
    var player_yello_cards: String?
    var player_red_cards: String?
    var player_image: String?
    var player_logo: String?
    
    
    init(){
        self.player_key = 0
        self.player_name = ""
        self.player_number = ""
        self.player_type = ""
        self.player_age = ""
        self.player_match_played = ""
        self.player_goals = ""
        self.player_yello_cards = ""
        self.player_red_cards = ""
        self.player_image = ""
        self.player_logo = ""
    }
}
