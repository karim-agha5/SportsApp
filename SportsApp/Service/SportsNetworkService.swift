//
//  SportsNetworkService.swift
//  SportsApp
//
//  Created by Karim on 23/05/2023.
//

import Foundation

class SportsNetworkService{
    
    func getRemoteFootballLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.FOOTBALL + Constants.PRE_API_KEY + Constants.API_KEY
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    
                    guard let actualData = data
                    else{return}
                    
                    let json = try JSONSerialization.jsonObject(with: actualData) as! Dictionary<String,Any>
                   
                    let remoteLeaguesList = json["result"] as! Array<Dictionary<String,Any>>
                
                    onComplete(remoteLeaguesList)
                    updateUI()
                  
                }
                catch{
                    print("Football Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
    }
    
    
    func getRemoteBasketballLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.BASKETBALL + Constants.PRE_API_KEY + Constants.API_KEY
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    
                    guard let actualData = data
                    else{return}
                    
                    let json = try JSONSerialization.jsonObject(with: actualData) as! Dictionary<String,Any>
                   
                    let remoteLeaguesList = json["result"] as! Array<Dictionary<String,Any>>
                
                    onComplete(remoteLeaguesList)
                    updateUI()
                  
                }
                catch{
                    print("Basketball Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
    }
    
    func getRemoteCricketLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.CRICKET + Constants.PRE_API_KEY + Constants.API_KEY
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    
                    guard let actualData = data
                    else{return}
                    
                    let json = try JSONSerialization.jsonObject(with: actualData) as! Dictionary<String,Any>
                   
                    let remoteLeaguesList = json["result"] as! Array<Dictionary<String,Any>>
                    
                    onComplete(remoteLeaguesList)
                    updateUI()
                  
                }
                catch{
                    print("Cricket Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
    }
    
    
    func getRemoteTennisLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.TENNIS + Constants.PRE_API_KEY + Constants.API_KEY
      
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    
                    guard let actualData = data
                    else{return}
                    
                    let json = try JSONSerialization.jsonObject(with: actualData) as! Dictionary<String,Any>
                   
                    let remoteLeaguesList = json["result"] as! Array<Dictionary<String,Any>>
                
                    onComplete(remoteLeaguesList)
                    updateUI()
                  
                }
                catch{
                    print("Tennis Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
    }
    
    
    
    
    
    
    
    func getRemoteUpcomingMatches(type: String,leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        
        var fullURL = Constants.BASE_URL + type + "/?met=Fixtures&APIkey="
        fullURL += Constants.API_KEY + "&from=" + Constants.startDateAsString
        fullURL += "&to=" + Constants.endDateAsString + "&leagueId=" + "\(leagueId)"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    guard let actualData = data
                    else{return}
                    
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: actualData)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch upcoming matches' data!")
                }
                
            }
            
            
            task.resume()
    }
    
    
    
    
    
    func getRemoteLatestMatches(type: String,leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = Constants.BASE_URL + type + "/?met=Fixtures&leagueId=" + "\(leagueId)" + "&APIkey=" + Constants.API_KEY + "&from=2023-01-01&to=2023-05-23"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    guard let actualData = data
                    else{return}
                    
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: actualData)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Latest Matches Service -----> Unable to fetch Latest Matches' data!")
                }
                
            }
            
            
            task.resume()
        
    }

    
    
    
    func getRemoteTeams(type: String,leagueId: Int,onComplete: @escaping (Array<Team>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = Constants.BASE_URL + type + "/?met=Teams&APIkey=" + Constants.API_KEY + "&leagueId=" + "\(leagueId)"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    guard let actualData = data
                    else{return}
                    let result = try JSONDecoder().decode(TeamResponse.self, from: actualData)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Get Remote Teams Service -----> Unable to fetch Remote Teams' data!")
                }
                
            }
            
            
            task.resume()
        
    }
    
    func getRemoteTennnisPlayers(leagueId: Int,onComplete: @escaping (Array<Player>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = Constants.BASE_URL + Constants.TENNIS + "/?met=Players&APIkey=" + Constants.API_KEY + "&leagueId=" + "\(leagueId)"
        
        let request = URLRequest(url: URL(string: fullURL)!)
        let session = URLSession(configuration: URLSessionConfiguration.default)
        
        let task = session.dataTask(with: request){
            (data, response,error) in
            
            do{
                
                guard let actualData = data
                else{return}
                let result = try JSONDecoder().decode(PlayerResponse.self, from: actualData)
                
                onComplete(result.result ?? [])
                updateUI()
            }
            catch{
                print("Get Remote Participants Service -----> Unable to fetch Remote Teams' data!")
            }
            
        }
        
        
        task.resume()
    }
}
