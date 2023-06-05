//
//  TeamDetailsPresenter.swift
//  SportsApp
//
//  Created by Karim on 05/06/2023.
//

import Foundation

protocol AnyTeamDetailsPresenter{
    func attachView(teamDetailsScreen: AnyTeamDetailsScreen)
    
    func isTeamInFavs(teamKey: String) -> Bool
    func deleteFromFavs(teamKey: String) -> Bool
    func fetchFavs() -> [TeamEntity]?
    func insertToFavs(_ sportType: String?, _ teamId: String, _ teamName: String, _ teamLogo: String?, _ leagueId: String?) -> Bool
}


class TeamDetailsPresenter : AnyTeamDetailsPresenter{
    
    private let databaseService = DatabaseService.shared
    
    private weak var teamDetailsScreen: AnyTeamDetailsScreen? = nil
    
    func attachView(teamDetailsScreen: AnyTeamDetailsScreen){
        self.teamDetailsScreen = teamDetailsScreen
    }
    
    func isTeamInFavs(teamKey: String) -> Bool{
        databaseService.isTeamInFavs(teamKey: teamKey)
    }
    
    func deleteFromFavs(teamKey: String) -> Bool{
        databaseService.deleteFromFavs(teamKey: teamKey)
    }
    
    func fetchFavs() -> [TeamEntity]?{
        return databaseService.fetchFavs() ?? []
    }
    
    func insertToFavs(_ sportType: String?,_ teamId: String,_ teamName: String,_ teamLogo: String?, _ leagueId: String?) -> Bool{
        
        databaseService.insertToFavs(sportType: sportType, teamId: teamId, teamName: teamName, teamLogo: teamLogo, leagueId: leagueId)
    }
}
