//
//  SportsNetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Karim on 05/06/2023.
//


import XCTest
@testable import SportsApp

class MockSportsNetworkService : AnySportsNetworkService{
    
    var shouldReturnError: Bool
    
    let mockFootballLeaguesResponse: String = """
{"success":1,"result":[{"league_key":4,"league_name":"UEFA Europa League","country_key":1,"country_name":"eurocups","league_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/","country_logo":null},{"league_key":1,"league_name":"European Championship","country_key":1,"country_name":"eurocups","league_logo":null,"country_logo":null},{"league_key":683,"league_name":"UEFA Europa Conference League","country_key":1,"country_name":"eurocups","league_logo":null,"country_logo":null},{"league_key":3,"league_name":"UEFA Champions League","country_key":1,"country_name":"eurocups","league_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/3_uefa_champions_league.png","country_logo":null},{"league_key":633,"league_name":"UEFA Nations League","country_key":1,"country_name":"eurocups","league_logo":null,"country_logo":null},{"league_key":28,"league_name":"World Cup","country_key":8,"country_name":"Worldcup","league_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/28_world-cup.png","country_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_country\\/8_worldcup.png"}]}
"""

    
    
    let mockUpcomingMatchesResponse = """
{\"success\":1,\"result\":[{\"event_key\":1220753,\"event_date\":\"2023-06-10\",\"event_time\":\"21:00\",\"event_home_team\":\"Manchester City\",\"home_team_key\":80,\"event_away_team\":\"Inter\",\"away_team_key\":79,\"event_halftime_result\":\"\",\"event_final_result\":\"-\",\"event_ft_result\":\"\",\"event_penalty_result\":\"\",\"event_status\":\"\",\"country_name\":\"eurocups\",\"league_name\":\"UEFA Champions League - Final\",\"league_key\":3,\"league_round\":\"Final\",\"league_season\":\"2022\\/2023\",\"event_live\":\"0\",\"event_stadium\":\"Atat\\u00fcrk Olimpiyat Stad\\u0131 (\\u0130stanbul)\",\"event_referee\":\"S. Marciniak\",\"home_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/80_manchester-city.jpg\",\"away_team_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/79_inter-milan.jpg\",\"event_country_key\":1,\"league_logo\":\"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/3_uefa_champions_league.png\",\"country_logo\":null,\"event_home_formation\":\"\",\"event_away_formation\":\"\",\"fk_stage_key\":7,\"stage_name\":\"Final\",\"league_group\":null,\"goalscorers\":[],\"substitutes\":[],\"cards\":[],\"lineups\":{\"home_team\":{\"starting_lineups\":[],\"substitutes\":[],\"coaches\":[],\"missing_players\":[]},\"away_team\":{\"starting_lineups\":[],\"substitutes\":[],\"coaches\":[],\"missing_players\":[]}},\"statistics\":[]}]}

"""
    
    
    let mockRemoteLatestMatchesResponse = """

{"success":1,"result":[{"event_key":1208512,"event_date":"2023-04-19","event_time":"21:00","event_home_team":"Inter Milan","home_team_key":79,"event_away_team":"Benfica","away_team_key":147,"event_halftime_result":"1 - 1","event_final_result":"3 - 3","event_ft_result":"3 - 3","event_penalty_result":"","event_status":"Finished","country_name":"eurocups","league_name":"UEFA Champions League - Quarter-finals","league_key":3,"league_round":"Quarter-finals","league_season":"2022\\/2023","event_live":"0","event_stadium":"Stadio Giuseppe Meazza (Milano)","event_referee":"Carlos del Cerro","home_team_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/79_inter-milan.jpg","away_team_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/147_benfica.jpg","event_country_key":1,"league_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/logo_leagues\\/3_uefa_champions_league.png","country_logo":null,"event_home_formation":"3-5-2","event_away_formation":"4-2-3-1","fk_stage_key":9,"stage_name":"Quarter-finals","league_group":null}]}

"""
    
    let mockRemoteTeamsResponse = """

{"success":1,"result":[{"team_key":72,"team_name":"Bayern Munich","team_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo\\/72_bayern-munich.jpg"}]}

"""
    
    
    
    let mockRemoteTennisPlayersResponse = """

{"success":1,"result":[{"player_key":1056,"player_name":"A. Martin","player_country":"USA","player_bday":"07.07.2001","player_logo":"https:\\/\\/apiv2.allsportsapi.com\\/logo-tennis\\/1056_a-martin.jpg"}]}

"""
    
    
    
    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
 
    func getRemoteLeagues(sportsType: String, onComplete: @escaping (Array<Dictionary<String, Any>>) -> Void, updateUI: @escaping () -> ()) {
        if shouldReturnError {
            onComplete([])
        }
        else{
            
            guard let mockData = mockFootballLeaguesResponse.data(using: .utf8) else {
                onComplete([])
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: mockData) as! Dictionary<String,Any>
               
                let remoteLeaguesList = json["result"] as! Array<Dictionary<String,Any>>
                onComplete(remoteLeaguesList)
                
            } catch {
                onComplete([])
            }
        }
    }
    
    func getRemoteUpcomingMatches(type: String, leagueId: Int, onComplete: @escaping (Array<SportsApp.UpcomingMatch>) -> Void, updateUI: @escaping () -> ()) {
       
        if shouldReturnError {
            onComplete([])
            
        } else {
            
            guard let mockData = mockUpcomingMatchesResponse.data(using: .utf8) else {
                onComplete([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: mockData)
                onComplete(response.result ?? [])
            } catch {
                onComplete([])
            }
        }
    }
    
    
    func getRemoteLatestMatches(type: String, leagueId: Int, onComplete: @escaping (Array<SportsApp.UpcomingMatch>) -> Void, updateUI: @escaping () -> ()) {
        
        if shouldReturnError {
            onComplete([])
            
        } else {
            
            guard let mockData = mockRemoteLatestMatchesResponse.data(using: .utf8) else {
                onComplete([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: mockData)
                onComplete(response.result ?? [])
            } catch {
                onComplete([])
            }
        }
    }
    
    func getRemoteTeams(type: String, leagueId: Int, onComplete: @escaping (Array<SportsApp.Team>) -> Void, updateUI: @escaping () -> ()) {
        if shouldReturnError {
            onComplete([])
            
        } else {
            
            guard let mockData = mockRemoteTeamsResponse.data(using: .utf8) else {
                onComplete([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(TeamResponse.self, from: mockData)
                onComplete(response.result ?? [])
            } catch {
                onComplete([])
            }
        }
    }
    
    func getRemoteTennnisPlayers(leagueId: Int, onComplete: @escaping (Array<SportsApp.Player>) -> Void, updateUI: @escaping () -> ()) {
        
        if shouldReturnError {
            onComplete([])
            
        } else {
            
            guard let mockData = mockRemoteTeamsResponse.data(using: .utf8) else {
                onComplete([])
                return
            }
            
            do {
                let response = try JSONDecoder().decode(PlayerResponse.self, from: mockData)
                onComplete(response.result ?? [])
            } catch {
                onComplete([])
            }
        }
    }
}
