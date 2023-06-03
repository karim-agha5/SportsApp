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
    
    
    
    
    
    
    
    
    
    
    
    func getRemoteUpcomingFootballMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = Constants.UPCOMING_FOOTBALL_MATCHES + "\(leagueId)"
        
        let concurrentQueue = DispatchQueue(label: "My Custom ConcurrentQueue", attributes: .concurrent)
        
        concurrentQueue.async {
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: data!)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
        }
    }
    
    
    
    
   /*
    
    func getRemoteFootballLiveMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = "https://apiv2.allsportsapi.com/" + Constants.FOOTBALL + "/?met=Fixtures&leagueId=" + "\(leagueId)" + "&APIkey=" + Constants.API_KEY + "&from=2023-01-01&to=2023-05-23"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: data!)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
        
    }

    
    
    
    
    func getRemoteFootballTeams(leagueId: Int,onComplete: @escaping (Array<Team>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = "https://apiv2.allsportsapi.com/football/?met=Teams&APIkey=" + Constants.API_KEY + "&leagueId=" + "\(leagueId)"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(TeamResponse.self, from: data!)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
        
    }
    
    
    */
    
    
    
    
    
    
    
    func getRemoteBasketballUpcomingMatches(leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = Constants.UPCOMING_BASKETBALL_MATCHES + "\(leagueId)"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: data!)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
    }
    
    
    
    
    
    
    func getRemoteLatestMatches(type: String,leagueId: Int,onComplete: @escaping (Array<UpcomingMatch>) -> Void,updateUI: @escaping () -> ()){
        
        //let fullURL = Constants.CURRENT_BASKETBALL_MATCHES + "\(leagueId)"
     //   let fullURL = Constants.BASE_URL + type + "/?met=Livescore&APIkey=" + Constants.API_KEY + "&leagueId=" + "\(leagueId)"
        
        let fullURL = Constants.BASE_URL + type + "/?met=Fixtures&leagueId=" + "\(leagueId)" + "&APIkey=" + Constants.API_KEY + "&from=2023-01-01&to=2023-05-23"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(UpcomingTeamsRemoteResponse.self, from: data!)
                    onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Latest Matches Service -----> Unable to fetch Latest Matches' data!")
                }
                
            }
            
            
            task.resume()
        
    }

    
    
    
    /*
    func getRemoteBasketballTeams(leagueId: Int,onComplete: @escaping (Array<Team>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = "https://apiv2.allsportsapi.com/basketball/?met=Teams&APIkey=" + Constants.API_KEY + "&leagueId=" + "\(leagueId)"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(TeamResponse.self, from: data!)
                                        onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Upcoming Matches Service -----> Unable to fetch leagues' data!")
                }
                
            }
            
            
            task.resume()
        
    }
     */
    
    
    func getRemoteTeams(type: String,leagueId: Int,onComplete: @escaping (Array<Team>) -> Void,updateUI: @escaping () -> ()){
        
        let fullURL = Constants.BASE_URL + type + "/?met=Teams&APIkey=" + Constants.API_KEY + "&leagueId=" + "\(leagueId)"
        
            let request = URLRequest(url: URL(string: fullURL)!)
            let session = URLSession(configuration: URLSessionConfiguration.default)
            
            let task = session.dataTask(with: request){
                (data, response,error) in
                
                do{
                    let result = try JSONDecoder().decode(TeamResponse.self, from: data!)
                                        onComplete(result.result ?? [])
                    updateUI()
                }
                catch{
                    print("Get Remote Teams Service -----> Unable to fetch Remote Teams' data!")
                }
                
            }
            
            
            task.resume()
        
    }
    
}
