//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Karim on 31/05/2023.
//

import Foundation


protocol AnyLeagueDetailsPresenter{
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen)
    func getRemoteUpcomingMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ())
}


class LeagueDetailsPresenter : AnyLeagueDetailsPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private var leagueDetailsScreen: AnyLeagueDetailsScreen? = nil
    
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen){
        self.leagueDetailsScreen = leagueDetailsScreen
    }
    
    func getRemoteUpcomingMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteUpcomingFootballMatches(leagueId: leagueId , onComplete: onComplete,updateUI: updateUI)
    }
}
