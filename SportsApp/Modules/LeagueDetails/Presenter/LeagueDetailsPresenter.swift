//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Karim on 31/05/2023.
//

import Foundation


protocol AnyLeagueDetailsPresenter{
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen)
    func getRemoteFootballLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ())
    func getRemoteUpcomingMatches()
}


class LeagueDetailsPresenter /*: AnyLeagueDetailsPresenter */{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private var leagueDetailsScreen: AnyLeagueDetailsScreen? = nil
    
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen){
        self.leagueDetailsScreen = leagueDetailsScreen
    }
    
    func getRemoteFootballLeagues(onComplete: @escaping (Array<Dictionary<String, Any>>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteFootballLeagues(onComplete: onComplete,updateUI: updateUI)
    }
}
