//
//  FavoritesPresenter.swift
//  SportsApp
//
//  Created by Karim on 05/06/2023.
//

import Foundation

protocol AnyFavoritesPresenter{
    func attachView(favoritesScreen: AnyFavoritesScreen)
    
    func deleteFromFavs(teamKey: String)
    func fetchFavs() -> [TeamEntity]?
}


class FavoritesPresenter : AnyFavoritesPresenter{
    
    private let databaseService = DatabaseService.shared
    
    private weak var favoritesScreen: AnyFavoritesScreen? = nil
    
    func attachView(favoritesScreen: AnyFavoritesScreen){
        self.favoritesScreen = favoritesScreen
    }
    
    func deleteFromFavs(teamKey: String){
        databaseService.deleteFromFavs(teamKey: teamKey)
    }
    
    func fetchFavs() -> [TeamEntity]?{
        return databaseService.fetchFavs() ?? []
    }
}
