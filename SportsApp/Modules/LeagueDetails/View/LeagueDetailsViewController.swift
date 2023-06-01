//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Karim on 25/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AnyLeagueDetailsScreen {
    
    
    
    let imageString: String = "SportImagePlaceholder"
    
    var leagueId: Int = -1
    
    var upcomingMatchesArray = [UpcomingMatch]()
    
    var liveMatchesArray = [UpcomingMatch]()
    
    var teamsArray = [UpcomingMatch]()
    
    private let leagueDetailsPresenter: AnyLeagueDetailsPresenter = LeagueDetailsPresenter()
    
    @IBOutlet weak var upcomingMatchesCollectionview: UICollectionView!
    
    @IBOutlet weak var currentGamescTableview: UITableView!
    
    @IBOutlet weak var teamsCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        leagueDetailsPresenter.attachView(leagueDetailsScreen: self)
        
        upcomingMatchesCollectionview.register(UINib(nibName: "CustomLeagueDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomLeagueDetailsCollectionViewCell")
        
        currentGamescTableview.register(UINib(nibName: "CustomLeagueDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomLeagueDetailsTableViewCell")
        
        teamsCollectionview.register(UINib(nibName: "CustomTeamCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomTeamCollectionViewCell")
        
        upcomingMatchesCollectionview.delegate = self
        upcomingMatchesCollectionview.dataSource = self
        
        currentGamescTableview.delegate = self
        currentGamescTableview.dataSource = self
        
        teamsCollectionview.delegate = self
        teamsCollectionview.dataSource = self
        
        getRemoteUpcomingMatches(leagueId: leagueId)
        
        getRemoteLiveMatches(leagueId: 332)
        
        getRemoteTeams(leagueId: leagueId)
        
    }
    
    private func getRemoteTeams(leagueId: Int){
        let service = SportsNetworkService()
        service.getRemoteTeams(leagueId: leagueId, onComplete: storeTeamsInArrayLocally){
            DispatchQueue.main.async {
                self.teamsCollectionview.reloadData()
            }
        }
    }
    
    func storeTeamsInArrayLocally(teams: Array<UpcomingMatch>){
        for team in teams{
            teamsArray.append(team)
        }
    }
    
    private func getRemoteLiveMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteLiveMatches(leagueId: leagueId, onComplete: storeLiveMatchesInArrayLocally){
            DispatchQueue.main.async {
                self.currentGamescTableview.reloadData()
            }
        }
    }
    
    func storeLiveMatchesInArrayLocally(liveMatches: Array<UpcomingMatch>){
        for livematch in liveMatches{
            liveMatchesArray.append(livematch)
        }
    }
    
    private func getRemoteUpcomingMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteUpcomingMatches(leagueId: leagueId, onComplete: storeUpcomingMatchesInArrayLocally){
            DispatchQueue.main.async {
                self.upcomingMatchesCollectionview.reloadData()
            }
        }
    }
    
    func storeUpcomingMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>) {
        for upcomingMatch in upcomingMatches {
            upcomingMatchesArray.append(upcomingMatch)
        }
    }
    
    private func initArray(){
        var upcomingMatch = UpcomingMatch()
        for _ in 1...20{
            upcomingMatch.event_date = "2023-05-29"
            upcomingMatch.event_time = "9:00"
            upcomingMatch.event_home_team = "Real Madrid"
            upcomingMatch.event_away_team = "Barcelona"
            upcomingMatch.event_home_team_logo = ""
            upcomingMatch.event_away_team_logo = ""
            upcomingMatchesArray.append(upcomingMatch)
            upcomingMatch = UpcomingMatch()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveMatchesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLeagueDetailsTableViewCell",for: indexPath) as? CustomLeagueDetailsTableViewCell
        
        cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.item].home_team_logo, secondLogo: upcomingMatchesArray[indexPath.item].away_team_logo, firstName: upcomingMatchesArray[indexPath.item].event_home_team, secondName: upcomingMatchesArray[indexPath.item].event_away_team, score: upcomingMatchesArray[indexPath.item].event_final_result)
        
        return cell ?? UITableViewCell()
       // return UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMatchesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == upcomingMatchesCollectionview){
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomLeagueDetailsCollectionViewCell", for: indexPath) as? CustomLeagueDetailsCollectionViewCell
           
            cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.row].home_team_logo, secondLogo: upcomingMatchesArray[indexPath.row].away_team_logo, firstName: upcomingMatchesArray[indexPath.row].event_home_team, secondName: upcomingMatchesArray[indexPath.row].event_away_team, date: upcomingMatchesArray[indexPath.row].event_date, score: "N/A - N/A", time: upcomingMatchesArray[indexPath.row].event_time)
            
            return cell ?? CustomLeagueDetailsCollectionViewCell()
            
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTeamCollectionViewCell", for: indexPath) as? CustomTeamCollectionViewCell
            
            cell?.setupCell(teamLogo: teamsArray[indexPath.row].home_team_logo)
            
            return cell ?? CustomTeamCollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == upcomingMatchesCollectionview){
            let width = self.upcomingMatchesCollectionview.bounds.width * 0.95
            let height = self.upcomingMatchesCollectionview.bounds.width * 0.5
            return CGSize(width: width, height: height)
        }
        else{
            let width = self.upcomingMatchesCollectionview.bounds.width * 0.95
            let height = self.upcomingMatchesCollectionview.bounds.height * 0.5
            return CGSize(width: width, height: height)
        }
    }
    
    
}

