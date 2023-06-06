//
//  AnySportsNetworkService.swift
//  SportsApp
//
//  Created by Karim on 05/06/2023.
//

import Foundation

protocol AnySportsNetworkService{
    
    func getRemoteLeagues(sportsType: String,onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ())
    
    func getRemoteUpcomingMatches(type: String,leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ())
    
    func getRemoteLatestMatches(type: String,leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ())
    
    func getRemoteTeams(type: String,leagueId: Int,onComplete: @escaping (Array<Team>) -> Void,updateUI: @escaping () -> ())
    
    func getRemoteTennnisPlayers(leagueId: Int,onComplete: @escaping (Array<Player>) -> Void,updateUI: @escaping () -> ())
    
}
