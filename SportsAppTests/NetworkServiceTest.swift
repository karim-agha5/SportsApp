//
//  NetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Karim on 05/06/2023.
//

import XCTest

@testable import SportsApp
final class NetworkServiceTest: XCTestCase {

    var sportsNetwork: SportsNetworkService? = nil
    var leaguesArray: [League] = []
    var upcomingMatchesArray: [UpcomingMatch] = []
    var latestMatches: [UpcomingMatch] = []
    var teamsArray: [Team] = []
    var playersArray: [Player] = []
    
    override func setUp() {
        sportsNetwork = SportsNetworkService()
    }

    func testGetFootballLeagues_SuccessfulRequest_ReturnFootballLeagues(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        sportsNetwork?.getRemoteLeagues(sportsType: Constants.FOOTBALL, onComplete: onLeaguesDownloadedComplete){
            XCTAssertTrue(!self.leaguesArray.isEmpty,"Leagues array should not be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    func testGetFootballLeagues_FailedRequest_ReturnNoLeagues(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        sportsNetwork?.getRemoteLeagues(sportsType: "karim", onComplete: onLeaguesDownloadedComplete){
            XCTAssertTrue(self.leaguesArray.isEmpty,"Leagues array should be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    
    func testGetRemoteUpcomingFootballMatches_SuccessfulRequest_ReturnUpcomingMatches(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let championsLeagueId = 3
        
        sportsNetwork?.getRemoteUpcomingMatches(type: Constants.FOOTBALL, leagueId: championsLeagueId, onComplete: storeUpcomingMatchesInArrayLocally){
            XCTAssertTrue(!self.upcomingMatchesArray.isEmpty,"upcoming matches array should not be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    
    func testGetRemoteUpcomingFootballMatches_FailedRequest_RetunNoUpcomingMatches(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        sportsNetwork?.getRemoteUpcomingMatches(type: "", leagueId: 3, onComplete: onUpcomingMatchesDownloadedComplete){
            XCTAssertTrue(self.upcomingMatchesArray.isEmpty,"upcoming matches array should be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    
    func testGetRemoteLatestMatches_SuccessfulRequest_ReturnLatestMatches(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let championsLeagueId = 3
        
        sportsNetwork?.getRemoteUpcomingMatches(type: Constants.FOOTBALL, leagueId: championsLeagueId, onComplete: storeLatestMatchesInArrayLocally){
            XCTAssertTrue(!self.latestMatches.isEmpty,"upcoming matches array should not be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    
    func testGetRemoteLatestMatches_failedRequest_ReturnNoLatestMatches(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let championsLeagueId = 3
        
        sportsNetwork?.getRemoteUpcomingMatches(type: "", leagueId: championsLeagueId, onComplete: storeLatestMatchesInArrayLocally){
            XCTAssertTrue(self.latestMatches.isEmpty,"upcoming matches array should be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    func testGetRemoteTeams_SuccessfulRequest_ReturnTeams(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let serieA = 206
        
        sportsNetwork?.getRemoteTeams(type: Constants.FOOTBALL, leagueId: serieA, onComplete: storeTeamsInArrayLocally){
            XCTAssertTrue(!self.teamsArray.isEmpty,"upcoming matches array should not be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    func testGetRemoteTeams_FailedRequest_ReturnNoTeams(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let serieA = 206
        
        sportsNetwork?.getRemoteTeams(type: "test", leagueId: serieA, onComplete: storeTeamsInArrayLocally){
            XCTAssertTrue(self.teamsArray.isEmpty,"upcoming matches array should be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    func testGetRemoteTennnisPlayers_SuccessfulRequest_ReturnTennisPlayers(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let leagueId = 2833
        
        sportsNetwork?.getRemoteTennnisPlayers(leagueId: leagueId, onComplete: storeTennisPlayersInArrayLocally){
            XCTAssertTrue(!self.playersArray.isEmpty,"tennis players array should not be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    func testGetRemoteTennnisPlayers_FailedRequest_ReturnTennisPlayers(){
        let expectation = XCTestExpectation(description: "onCompleted called!")
        
        let leagueId = 2833
        
        sportsNetwork?.getRemoteTennnisPlayers(leagueId: -1, onComplete: storeTennisPlayersInArrayLocally){
            XCTAssertTrue(self.playersArray.isEmpty,"tennis players array should be empty!")
            print("Updated the UI!")
            expectation.fulfill()
        }
        wait(for: [expectation],timeout: 10.0)
    }
    
    func storeTennisPlayersInArrayLocally(players: Array<Player>) {
        for player in players {
            playersArray.append(player)
        }
    }
    
    func storeTeamsInArrayLocally(teams: Array<Team>){
        for team in teams{
            teamsArray.append(team)
        }
    }
    
    func storeLatestMatchesInArrayLocally(latestResults: Array<UpcomingMatch>) {
        for latestResult in latestResults {
            latestMatches.append(latestResult)
        }
    }
    
    func onLeaguesDownloadedComplete(response: Array<Dictionary<String,Any>>){
        storeLeaguesAsDictionaryLocally(remoteLeaguesList: response)
    }
    
    func onUpcomingMatchesDownloadedComplete(upcomingMatches: Array<UpcomingMatch>){
        storeUpcomingMatchesInArrayLocally(upcomingMatches: upcomingMatches)
    }
    
    func storeUpcomingMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>) {
        for upcomingMatch in upcomingMatches {
            upcomingMatchesArray.append(upcomingMatch)
        }
    }
    
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>){
        for i in remoteLeaguesList {
            storeLeaguesLocallyInArray(leaguesDictionary: i)
        }
    }
    
    private func storeLeaguesLocallyInArray(leaguesDictionary: Dictionary<String,Any>){
        let leagueName: String = leaguesDictionary["league_name"] as! String
        var leagueLogo: String?
        var leagueKey: Int?
        let league = League()
        
        league.title = leagueName
        if leaguesDictionary["league_logo"] != nil{
            leagueLogo = leaguesDictionary["league_logo"] as? String
            league.image = leagueLogo ?? "SportImagePlaceholder"
        }
        else{
            league.image = "SportImagePlaceholder"
        }
       
        if leaguesDictionary["league_key"] != nil {
            leagueKey = leaguesDictionary["league_key"] as? Int
            league.league_key = leagueKey
        }
                        
        leaguesArray.append(league)
    }
    
}
