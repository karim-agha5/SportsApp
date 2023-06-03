//
//  BasketballPresenter.swift
//  SportsApp
//
//  Created by Karim on 24/05/2023.
//

import Foundation


protocol AnyBasketballPresenter{
    func attachView(basketballScreen: AnyBasketballScreen)
    func getRemoteBasketballLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ())
}


class BasketballPresenter : AnyBasketballPresenter{
    
    private let sportsNetworkService = SportsNetworkService()
    
    private weak var basketballScreen: AnyBasketballScreen? = nil
    
    func attachView(basketballScreen: AnyBasketballScreen){
        self.basketballScreen = basketballScreen
    }
    
    func getRemoteBasketballLeagues(onComplete: @escaping (Array<Dictionary<String, Any>>) -> Void,updateUI: @escaping () -> ()) {
        sportsNetworkService.getRemoteBasketballLeagues(onComplete: onComplete,updateUI: updateUI)
    }
}
