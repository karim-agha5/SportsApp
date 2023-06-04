//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Karim on 31/05/2023.
//

import Foundation


protocol AnyLeagueDetailsPresenter{
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen)
    func getRemoteLatestResults(type: String,leagueId: Int)
    func getRemoteTeams(type: String, leagueId: Int)
    func getRemoteUpcomingMatches(type: String,leagueId: Int)
}


class LeagueDetailsPresenter : AnyLeagueDetailsPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private weak var leagueDetailsScreen: AnyLeagueDetailsScreen!
    
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen){
        self.leagueDetailsScreen = leagueDetailsScreen
    }
    
    func getRemoteLatestResults(type: String,leagueId: Int){
        sportsNetworkService.getRemoteLatestMatches(type: type, leagueId: leagueId, onComplete: leagueDetailsScreen.storeLatestResultsInArrayLocally, updateUI: leagueDetailsScreen.refreshTableView)
    }
 
    func getRemoteTeams(type: String, leagueId: Int){
        sportsNetworkService.getRemoteTeams(type: type,leagueId: leagueId, onComplete: leagueDetailsScreen.storeTeamsInArrayLocally, updateUI: leagueDetailsScreen.refreshTeamsCollectionViews)
    }
    
    func getRemoteUpcomingMatches(type: String,leagueId: Int){
        sportsNetworkService.getRemoteUpcomingMatches(type: type, leagueId: leagueId, onComplete: leagueDetailsScreen.storeUpcomingMatchesInArrayLocally, updateUI: leagueDetailsScreen.refreshUpcomingMatchesCollectionViews)
    }
    
}
