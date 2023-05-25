//
//  CricketPresenter.swift
//  SportsApp
//
//  Created by Karim on 24/05/2023.
//

import Foundation


protocol AnyCricketPresenter{
    func attachView(cricketScreen: AnyCricketScreen)
    func getRemoteCricketLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ())
}


class CricketPresenter : AnyCricketPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private var cricketScreen: AnyCricketScreen? = nil
    
    func attachView(cricketScreen: AnyCricketScreen){
        self.cricketScreen = cricketScreen
    }
    
    func getRemoteCricketLeagues(onComplete: @escaping (Array<Dictionary<String, Any>>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteCricketLeagues(onComplete: onComplete,updateUI: updateUI)
    }
}
