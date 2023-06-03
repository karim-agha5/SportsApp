//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Karim on 25/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,AnyLeagueDetailsScreen {
    
    var type: String = Constants.FOOTBALL
    
    let imageString: String = "SportImagePlaceholder"
    
    var leagueId: Int = -1
    
    var upcomingMatchesArray = [UpcomingMatch]()
    
    var liveMatchesArray = [UpcomingMatch]()
    
    var teamsArray = [Team]()
    
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
               
        
        switch type{
            case Constants.FOOTBALL: loadFootballInfo(leagueId: leagueId)
            default: loadBasketballInfo(leagueId: leagueId)
        }
        
        
    }
    
    private func loadFootballInfo(leagueId: Int){
        getRemoteFootballUpcomingMatches(leagueId: leagueId)
        getRemoteFootballLiveMatches(leagueId: leagueId)
        getRemoteFootballTeams(leagueId: leagueId)
    }
    
    private func loadBasketballInfo(leagueId: Int){
        getRemoteBasketballUpcomingMatches(leagueId: leagueId)
        getRemoteBasketballLiveMatches(leagueId: leagueId)
        getRemoteBasketballTeams(leagueId: leagueId)
    }
    
    func refreshUpcomingMatchesCollectionViews(){
        DispatchQueue.main.async {
            self.upcomingMatchesCollectionview.reloadData()
        }
    }
    
    func refreshTeamsCollectionViews(){
        DispatchQueue.main.async {
            self.teamsCollectionview.reloadData()
        }
    }
    
    func refreshTableView(){
        DispatchQueue.main.async {
            self.currentGamescTableview.reloadData()
        }
    }
   /*
    private func getRemoteFootballTeams(leagueId: Int){
        let service = SportsNetworkService()
        service.getRemoteFootballTeams(leagueId: leagueId, onComplete: storeTeamsInArrayLocally,updateUI: refreshTeamsCollectionViews)
    }
    */
    
    private func getRemoteFootballTeams(leagueId: Int){
        let service = SportsNetworkService()
        service.getRemoteTeams(type: Constants.FOOTBALL, leagueId: leagueId, onComplete: storeTeamsInArrayLocally,updateUI: refreshTeamsCollectionViews)
    }
    
    private func getRemoteBasketballTeams(leagueId: Int){
        leagueDetailsPresenter.getRemoteBasketballTeams(type: Constants.BASKETBALL,leagueId: leagueId)
    }
    
    func storeTeamsInArrayLocally(teams: Array<Team>){
        for team in teams{
            teamsArray.append(team)
        }
    }
    
    func storeBasketballTeamsInArrayLocally(teams: Array<Team>){
        for team in teams{
            teamsArray.append(team)
        }
    }
    /*
    private func getRemoteFootballLiveMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteFootballLiveMatches(leagueId: leagueId, onComplete: storeFootballLiveMatchesInArrayLocally,updateUI: refreshTableView)
    }*/
    
    
    private func getRemoteFootballLiveMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteLatestMatches(type: Constants.FOOTBALL,leagueId: leagueId)
    }

    private func getRemoteBasketballLiveMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteLatestMatches(type: Constants.BASKETBALL, leagueId: leagueId)
    }
    
    func storeFootballLiveMatchesInArrayLocally(liveMatches: Array<UpcomingMatch>){
        for livematch in liveMatches{
            liveMatchesArray.append(livematch)
        }
    }
    
    func storeBasketballLiveMatchesInArrayLocally(liveMatches: Array<UpcomingMatch>){
        for livematch in liveMatches{
            liveMatchesArray.append(livematch)
        }
    }
    
    private func getRemoteFootballUpcomingMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteFootballUpcomingMatches(leagueId: leagueId, onComplete: storeUpcomingFootballMatchesInArrayLocally,updateUI: refreshUpcomingMatchesCollectionViews)
    }
    
    private func getRemoteBasketballUpcomingMatches(leagueId: Int){
        leagueDetailsPresenter.getRemoteBasketballUpcomingMatches(leagueId: leagueId)
    }
    
    func storeUpcomingFootballMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>) {
        for upcomingMatch in upcomingMatches {
            upcomingMatchesArray.append(upcomingMatch)
        }
    }
    
    func storeUpcomingBasketballMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>) {
        for upcomingMatch in upcomingMatches {
            upcomingMatchesArray.append(upcomingMatch)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return liveMatchesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLeagueDetailsTableViewCell",for: indexPath) as? CustomLeagueDetailsTableViewCell
    
        if liveMatchesArray.count > 0 {
            
            cell?.setupCell(firstLogo: liveMatchesArray[indexPath.row].home_team_logo, secondLogo: liveMatchesArray[indexPath.row].away_team_logo, firstName: liveMatchesArray[indexPath.row].event_home_team, secondName: liveMatchesArray[indexPath.row].event_away_team, score: liveMatchesArray[indexPath.row].event_final_result)
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upcomingMatchesCollectionview) {
            return upcomingMatchesArray.count
        }
        else{
            return teamsArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if(collectionView == upcomingMatchesCollectionview){
            
            var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomLeagueDetailsCollectionViewCell", for: indexPath) as? CustomLeagueDetailsCollectionViewCell
            
            switch type {
                case Constants.FOOTBALL:
                    cell = getFootballCustomCollectionViewCell(cell: cell, indexPath: indexPath)
                
                case Constants.BASKETBALL:
                    cell = getBasketballCustomCollectionViewCell(cell: cell, indexPath: indexPath)
                case Constants.CRICKET:
                    cell = getCricketCustomCollectionViewCell(cell: cell, indexPath: indexPath)
                default:
                    cell = getFootballCustomCollectionViewCell(cell: cell, indexPath: indexPath)
            }
            
            
            return cell ?? CustomLeagueDetailsCollectionViewCell()
            
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTeamCollectionViewCell", for: indexPath) as? CustomTeamCollectionViewCell
            
            switch type{
                case Constants.FOOTBALL:
                if teamsArray.count > 0 {cell?.setupCell(teamLogo: teamsArray[indexPath.row].team_logo)}
                default:
                if teamsArray.count > 0{cell?.setupCell(teamLogo: teamsArray[indexPath.row].team_logo)}
            }
            
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
            let width = self.upcomingMatchesCollectionview.bounds.width * 0.30
            let height = self.upcomingMatchesCollectionview.bounds.height * 0.5
            return CGSize(width: width, height: height)
        }
    }
    
    
    private func getFootballCustomCollectionViewCell(cell: CustomLeagueDetailsCollectionViewCell?,indexPath: IndexPath) -> CustomLeagueDetailsCollectionViewCell?{
           
            cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.row].home_team_logo, secondLogo: upcomingMatchesArray[indexPath.row].away_team_logo, firstName: upcomingMatchesArray[indexPath.row].event_home_team, secondName: upcomingMatchesArray[indexPath.row].event_away_team, date: upcomingMatchesArray[indexPath.row].event_date, score: "N/A - N/A", time: upcomingMatchesArray[indexPath.row].event_time)
        
        return cell
    }
    
    private func getBasketballCustomCollectionViewCell(cell: CustomLeagueDetailsCollectionViewCell?,indexPath: IndexPath) -> CustomLeagueDetailsCollectionViewCell?{
       
        cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.row].event_home_team_logo, secondLogo: upcomingMatchesArray[indexPath.row].event_away_team_logo, firstName: upcomingMatchesArray[indexPath.row].event_home_team, secondName: upcomingMatchesArray[indexPath.row].event_away_team, date: upcomingMatchesArray[indexPath.row].event_date, score: "N/A - N/A", time: upcomingMatchesArray[indexPath.row].event_time)
        
        return cell
    }
    
    private func getCricketCustomCollectionViewCell(cell: CustomLeagueDetailsCollectionViewCell?,indexPath: IndexPath) -> CustomLeagueDetailsCollectionViewCell?{
       
        cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.row].event_home_team_logo, secondLogo: upcomingMatchesArray[indexPath.row].event_away_team_logo, firstName: upcomingMatchesArray[indexPath.row].event_home_team, secondName: upcomingMatchesArray[indexPath.row].event_away_team, date: upcomingMatchesArray[indexPath.row].event_date, score: "N/A - N/A", time: upcomingMatchesArray[indexPath.row].event_time)
        
        return cell
    }
    
}
