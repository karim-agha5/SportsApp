//
//  AnyLeagueDetailsScreen.swift
//  SportsApp
//
//  Created by Karim on 31/05/2023.
//

import Foundation

protocol AnyLeagueDetailsScreen : AnyObject{
    func refreshUpcomingMatchesCollectionViews()
    func refreshTeamsCollectionViews()
    func refreshTableView()
    
    func storeUpcomingFootballMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>)
    func storeFootballLiveMatchesInArrayLocally(liveMatches: Array<UpcomingMatch>)
    
    func storeUpcomingBasketballMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>)
    func storeBasketballLiveMatchesInArrayLocally(liveMatches: Array<UpcomingMatch>)
    func storeBasketballTeamsInArrayLocally(teams: Array<Team>)
    
}
