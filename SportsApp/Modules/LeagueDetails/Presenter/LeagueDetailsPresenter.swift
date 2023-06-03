//
//  LeagueDetailsPresenter.swift
//  SportsApp
//
//  Created by Karim on 31/05/2023.
//

import Foundation


protocol AnyLeagueDetailsPresenter{
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen)
    func getRemoteFootballUpcomingMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ())
    //func getRemoteFootballLiveMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ())
    
    func getRemoteBasketballUpcomingMatches(leagueId: Int)
    //func getRemoteBasketballLiveMatches(leagueId: Int)
    func getRemoteLatestMatches(type: String,leagueId: Int)
    //func getRemoteBasketballTeams(leagueId: Int)
    func getRemoteBasketballTeams(type: String, leagueId: Int)
}


class LeagueDetailsPresenter : AnyLeagueDetailsPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private weak var leagueDetailsScreen: AnyLeagueDetailsScreen!
    
    func attachView(leagueDetailsScreen: AnyLeagueDetailsScreen){
        self.leagueDetailsScreen = leagueDetailsScreen
    }
  
    func getRemoteFootballUpcomingMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteUpcomingFootballMatches(leagueId: leagueId , onComplete: onComplete,updateUI: updateUI)
    }
   
  /*
    func getRemoteFootballLiveMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        sportsNetworkService.getRemoteFootballLiveMatches(leagueId: leagueId, onComplete: onComplete,updateUI: updateUI)
    }
    */
    
    func getRemoteBasketballUpcomingMatches(leagueId: Int){
        sportsNetworkService.getRemoteBasketballUpcomingMatches(leagueId: leagueId, onComplete: leagueDetailsScreen.storeUpcomingBasketballMatchesInArrayLocally, updateUI: leagueDetailsScreen.refreshUpcomingMatchesCollectionViews)
    }
   /*
    func getRemoteBasketballLiveMatches(leagueId: Int){
        sportsNetworkService.getRemoteBasketballLiveMatches(leagueId: leagueId, onComplete: leagueDetailsScreen.storeBasketballLiveMatchesInArrayLocally, updateUI: leagueDetailsScreen.refreshTableView)
    }*/
    
    func getRemoteLatestMatches(type: String,leagueId: Int){
        sportsNetworkService.getRemoteLatestMatches(type: type, leagueId: leagueId, onComplete: leagueDetailsScreen.storeBasketballLiveMatchesInArrayLocally, updateUI: leagueDetailsScreen.refreshTableView)
    }
    
   /*
    func getRemoteBasketballTeams(leagueId: Int){
        sportsNetworkService.getRemoteBasketballTeams(leagueId: leagueId, onComplete: leagueDetailsScreen.storeBasketballTeamsInArrayLocally, updateUI: leagueDetailsScreen.refreshTeamsCollectionViews)
    }
    */
    
    func getRemoteBasketballTeams(type: String, leagueId: Int){
        sportsNetworkService.getRemoteTeams(type: type,leagueId: leagueId, onComplete: leagueDetailsScreen.storeBasketballTeamsInArrayLocally, updateUI: leagueDetailsScreen.refreshTeamsCollectionViews)
    }
    
}
