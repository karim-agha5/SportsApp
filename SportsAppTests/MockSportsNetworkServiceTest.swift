//
//  MockSportsNetworkServiceTest.swift
//  SportsAppTests
//
//  Created by Karim on 05/06/2023.
//

import XCTest
@testable import SportsApp

final class MockSportsNetworkServiceTest: XCTestCase {

    var networkService: AnySportsNetworkService!
    var leaguesArray: Array<Dictionary<String,Any>>!
    var upcomingMatchesArray: [UpcomingMatch]!
    var latestResultArray: [UpcomingMatch]!
    var teamsArray: [Team]!
    var playersArray: [Player]!
    var expectation: XCTestExpectation!

    override func setUp() {
        expectation = expectation(description: "Remote Movies expectation call")
        upcomingMatchesArray = []
        latestResultArray = []
        teamsArray = []
        playersArray = []
    }
    
    func onLeaguesCompleteWillPass(array: Array<Dictionary<String,Any>>){
        leaguesArray = array
        XCTAssertGreaterThan(leaguesArray.count, 0)
        expectation.fulfill()
    }
    
    func onLeaguesCompleteWillFail(array: Array<Dictionary<String,Any>>){
        leaguesArray = array
        XCTAssertNil(leaguesArray)
        expectation.fulfill()
    }
    
    func onUpcomingMatchesCompleteWillPass(array: Array<UpcomingMatch>){
        upcomingMatchesArray = array
        XCTAssertGreaterThan(upcomingMatchesArray.count, 0)
        expectation.fulfill()
    }
    
    func onUpcomingMatchesCompleteWillFail(array: Array<UpcomingMatch>){
        upcomingMatchesArray = array
        XCTAssertNil(upcomingMatchesArray)
        expectation.fulfill()
    }
    
    
    func onLatestResultsCompleteWillPass(array: Array<UpcomingMatch>){
        latestResultArray = array
        XCTAssertGreaterThan(latestResultArray.count, 0)
        expectation.fulfill()
    }
    
    func onLatestResultsCompleteWillFail(array: Array<UpcomingMatch>){
        latestResultArray = array
        XCTAssertNil(latestResultArray)
        expectation.fulfill()
    }
    
    func onRemoteTeamsCompleteWillPass(array: Array<Team>){
        teamsArray = array
        XCTAssertGreaterThan(teamsArray.count, 0)
        expectation.fulfill()
    }
    
    func onRemoteTeamsCompleteWillFail(array: Array<Team>){
        teamsArray = array
        XCTAssertNil(teamsArray)
        expectation.fulfill()
    }
    
    func onRemoteTennisPlayersCompleteWillPass(array: Array<Player>){
        playersArray = array
        XCTAssertGreaterThan(playersArray.count, 0)
        expectation.fulfill()
    }
    
    func onRemoteTennisPlayersCompleteWillFail(array: Array<Player>){
        playersArray = array
        XCTAssertNil(playersArray)
        expectation.fulfill()
    }
    
    
    func testGetRemoteLeaguesWillPass(){
        networkService = MockSportsNetworkService(shouldReturnError: false)
        networkService.getRemoteLeagues(sportsType: "", onComplete: onLeaguesCompleteWillPass){
            
        }
        waitForExpectations(timeout: 10)
    }
    
    func testGetRemoteLeaguesWillFail(){
        networkService = MockSportsNetworkService(shouldReturnError: true)
        networkService.getRemoteLeagues(sportsType: "", onComplete: onLeaguesCompleteWillFail){
            
        }
        waitForExpectations(timeout: 10)
    }
   
    
   
    func testGetRemoteUpcomingMatchesWillPass(){
        networkService = MockSportsNetworkService(shouldReturnError: false)
        networkService.getRemoteUpcomingMatches(type: "", leagueId: 0, onComplete: onUpcomingMatchesCompleteWillPass){
            
        }
        waitForExpectations(timeout: 10)
    }

    func testGetRemoteUpcomingMatchesWillFail(){
        networkService = MockSportsNetworkService(shouldReturnError: true)
        networkService.getRemoteUpcomingMatches(type: "",leagueId: 0, onComplete: onUpcomingMatchesCompleteWillFail){
            
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testGetLatestResultsWillPass(){
        networkService = MockSportsNetworkService(shouldReturnError: false)
        networkService.getRemoteLatestMatches(type: "", leagueId: 0, onComplete: onLatestResultsCompleteWillPass){
            
        }
        waitForExpectations(timeout: 10)
    }

    func testGetLatestResultsWillFail(){
        networkService = MockSportsNetworkService(shouldReturnError: true)
        networkService.getRemoteLatestMatches(type: "",leagueId: 0, onComplete: onLatestResultsCompleteWillFail){
            
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testGetRemoteTeamsWillPass(){
        networkService = MockSportsNetworkService(shouldReturnError: false)
        networkService.getRemoteTeams(type: "", leagueId: 0, onComplete: onRemoteTeamsCompleteWillPass){
            
        }
        waitForExpectations(timeout: 10)
    }

    func testGetRemoteTeamsWillFail(){
        networkService = MockSportsNetworkService(shouldReturnError: true)
        networkService.getRemoteTeams(type: "",leagueId: 0, onComplete: onRemoteTeamsCompleteWillFail){
            
        }
        waitForExpectations(timeout: 10)
    }
    
    
    func testGetRemoteTennisPlayersWillPass(){
        networkService = MockSportsNetworkService(shouldReturnError: false)
        networkService.getRemoteTennnisPlayers(leagueId: 0, onComplete: onRemoteTennisPlayersCompleteWillPass){
            
        }
        waitForExpectations(timeout: 10)
    }

    func testGetRemoteTennisPlayersWillFail(){
        networkService = MockSportsNetworkService(shouldReturnError: true)
        networkService.getRemoteTennnisPlayers(leagueId: 0, onComplete: onRemoteTennisPlayersCompleteWillFail){
            
        }
        waitForExpectations(timeout: 10)
    }
    
}
