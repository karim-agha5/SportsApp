//
//  FootballPresenter.swift
//  SportsApp
//
//  Created by Karim on 23/05/2023.
//

import Foundation

protocol AnyFootballPresenter{
    func attachView(footballScreen: AnyFootballScreen)
    func getRemoteFootballLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ())
}


class FootballPresenter : AnyFootballPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private weak var footballScreen: AnyFootballScreen? = nil
    
    func attachView(footballScreen: AnyFootballScreen){
        self.footballScreen = footballScreen
    }
    
    func getRemoteFootballLeagues(onComplete: @escaping (Array<Dictionary<String, Any>>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteLeagues(sportsType: Constants.FOOTBALL,onComplete: onComplete,updateUI: updateUI)
    }
}
