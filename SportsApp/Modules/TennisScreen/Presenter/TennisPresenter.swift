//
//  TennisPresenter.swift
//  SportsApp
//
//  Created by Karim on 25/05/2023.
//

import Foundation


protocol AnyTennisPresenter{
    func attachView(tennisScreen: AnyTennisScreen)
    func getRemoteTennisLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ())
}


class TennisPresenter : AnyTennisPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private var tennisScreen: AnyTennisScreen? = nil
    
    func attachView(tennisScreen: AnyTennisScreen){
        self.tennisScreen = tennisScreen
    }
    
    func getRemoteTennisLeagues(onComplete: @escaping (Array<Dictionary<String, Any>>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteTennisLeagues(onComplete: onComplete,updateUI: updateUI)
    }
}
