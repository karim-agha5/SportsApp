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
    
    func storeUpcomingMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>)
    func storeLatestResultsInArrayLocally(latestResults: Array<UpcomingMatch>)
    func storeTeamsInArrayLocally(teams: Array<Team>)
    
}
