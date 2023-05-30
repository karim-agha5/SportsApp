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
        
        let concurrentQueue = DispatchQueue(label: "My Custom ConcurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                   
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
    }
    
    
    func getRemoteBasketballLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.BASKETBALL + Constants.PRE_API_KEY + Constants.API_KEY
        
        let concurrentQueue = DispatchQueue(label: "My Custom ConcurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                   
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
    }
    
    func getRemoteCricketLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.CRICKET + Constants.PRE_API_KEY + Constants.API_KEY
        
        let concurrentQueue = DispatchQueue(label: "My Custom ConcurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                   
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
    }
    
    
    func getRemoteTennisLeagues(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
        let fullURL = Constants.BASE_URL + Constants.TENNIS + Constants.PRE_API_KEY + Constants.API_KEY
      
        
        let concurrentQueue = DispatchQueue(label: "My Custom ConcurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String,Any>
                   
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
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    func getRemoteUpcomingFootballMatches(onComplete: @escaping (Array<Dictionary<String,Any>>) -> Void,updateUI: @escaping () -> ()){
      //  let fullURL = Constants.BASE_URL + Constants.TENNIS + Constants.PRE_API_KEY + Constants.API_KEY
        
        let fullURL = Constants.UPCOMING_FOOTBALL_MATCHES
        
        let concurrentQueue = DispatchQueue(label: "My Custom ConcurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: data!)
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
        }
    }
    
    
    
    
    
    
    
    
}
