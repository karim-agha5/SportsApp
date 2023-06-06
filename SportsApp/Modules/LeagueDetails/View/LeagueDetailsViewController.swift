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
    
    var latestResultsArray = [UpcomingMatch]()
    
    var teamsArray = [Team]()
    
    var playersArray = [Player]()
    
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
            case Constants.BASKETBALL: loadBasketballInfo(leagueId: leagueId)
            case Constants.CRICKET: loadCricketInfo(leagueId: leagueId)
            default: loadTennisInfo(leagueId: leagueId)
        }
        
        print(">>>>>>>>>>>> league id = \(leagueId) <<<<<<<<<<<<<<<<<<<<")
    }
    
    private func loadFootballInfo(leagueId: Int){
        getRemoteUpcomingMatches(type: Constants.FOOTBALL, leagueId: leagueId)
        getRemoteLatestResults(type: Constants.FOOTBALL, leagueId: leagueId)
        getRemoteTeams(type: Constants.FOOTBALL, leagueId: leagueId)
    }
    
    private func loadBasketballInfo(leagueId: Int){
        getRemoteUpcomingMatches(type: Constants.BASKETBALL, leagueId: leagueId)
        getRemoteLatestResults(type: Constants.BASKETBALL, leagueId: leagueId)
        getRemoteTeams(type: Constants.BASKETBALL, leagueId: leagueId)
    }
    
    
    private func loadCricketInfo(leagueId: Int){
        getRemoteUpcomingMatches(type: Constants.CRICKET, leagueId: leagueId)
        getRemoteLatestResults(type: Constants.CRICKET, leagueId: leagueId)
        getRemoteTeams(type: Constants.CRICKET, leagueId: leagueId)
    }
    
    private func loadTennisInfo(leagueId: Int){
        getRemoteUpcomingMatches(type: Constants.TENNIS, leagueId: leagueId)
        getRemoteLatestResults(type: Constants.TENNIS, leagueId: leagueId)
        getRemotePlayers(leagueId: leagueId)
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
    
    private func getRemoteTeams(type: String,leagueId: Int){
        leagueDetailsPresenter.getRemoteTeams(type: type, leagueId: leagueId)
    }
    
    private func getRemotePlayers(leagueId: Int){
        leagueDetailsPresenter.getRemoteTennisPlayers(leagueId: leagueId)
    }
    
    func storeTeamsInArrayLocally(teams: Array<Team>){
        for team in teams{
            teamsArray.append(team)
        }
    }
    
    func storeTennisPlayersInArrayLocally(players: Array<Player>) {
        for player in players {
            playersArray.append(player)
        }
    }
    
    private func getRemoteLatestResults(type: String,leagueId: Int){
        leagueDetailsPresenter.getRemoteLatestResults(type: type, leagueId: leagueId)
    }
    
    func storeLatestResultsInArrayLocally(latestResults: Array<UpcomingMatch>) {
        for latestResult in latestResults {
            latestResultsArray.append(latestResult)
        }
    }
    
    
    private func getRemoteUpcomingMatches(type: String,leagueId: Int){
        leagueDetailsPresenter.getRemoteUpcomingMatches(type: type, leagueId: leagueId)
    }
    
    func storeUpcomingMatchesInArrayLocally(upcomingMatches: Array<UpcomingMatch>) {
        for upcomingMatch in upcomingMatches {
            upcomingMatchesArray.append(upcomingMatch)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return latestResultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLeagueDetailsTableViewCell",for: indexPath) as? CustomLeagueDetailsTableViewCell
    
        if latestResultsArray.count > 0 {
            
            switch type {
                
            case Constants.FOOTBALL:
                
                cell?.setupCell(firstLogo: latestResultsArray[indexPath.row].home_team_logo, secondLogo: latestResultsArray[indexPath.row].away_team_logo, firstName: latestResultsArray[indexPath.row].event_home_team, secondName: latestResultsArray[indexPath.row].event_away_team, score: latestResultsArray[indexPath.row].event_final_result)
             
                
            case Constants.BASKETBALL:
                
                cell?.setupCell(firstLogo: latestResultsArray[indexPath.row].event_home_team_logo, secondLogo: latestResultsArray[indexPath.row].event_away_team_logo, firstName: latestResultsArray[indexPath.row].event_home_team, secondName: latestResultsArray[indexPath.row].event_away_team, score: latestResultsArray[indexPath.row].event_final_result)
                
                
            case Constants.CRICKET:
                
                var score = latestResultsArray[indexPath.row].event_home_final_result ?? "N/A"
                score += " - "
                score += latestResultsArray[indexPath.row].event_away_final_result ?? "N/A"
                
                cell?.setupCell(firstLogo: latestResultsArray[indexPath.row].event_home_team_logo, secondLogo: latestResultsArray[indexPath.row].event_away_team_logo, firstName: latestResultsArray[indexPath.row].event_home_team, secondName: latestResultsArray[indexPath.row].event_away_team, score: score)
                
            default:
                
                cell?.setupCell(firstLogo: latestResultsArray[indexPath.row].home_team_logo, secondLogo: latestResultsArray[indexPath.row].away_team_logo, firstName: latestResultsArray[indexPath.row].event_home_team, secondName: latestResultsArray[indexPath.row].event_away_team, score: latestResultsArray[indexPath.row].event_final_result)
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
        navigationController?.pushViewController(teamDetailsViewController, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == upcomingMatchesCollectionview) {
            return upcomingMatchesArray.count
        }
        else{
            if type == Constants.TENNIS{
                return playersArray.count
            }
            else{
                return teamsArray.count
            }
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
                    cell = getTennisCustomCollectionViewCell(cell: cell, indexPath: indexPath)
            }
            
            
            return cell ?? CustomLeagueDetailsCollectionViewCell()
            
        }
        else{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomTeamCollectionViewCell", for: indexPath) as? CustomTeamCollectionViewCell
            
            switch type{
                
            case Constants.TENNIS:
                
                if playersArray.count > 0 {
                    cell?.setupCell(teamLogo: playersArray[indexPath.row].player_logo)
                }
                
            default:
                
                if teamsArray.count > 0 {
                    cell?.setupCell(teamLogo: teamsArray[indexPath.row].team_logo)
                }
                
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == teamsCollectionview {
            if type != Constants.TENNIS {
                let teamDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
                teamDetailsViewController.teamId = "\(teamsArray[indexPath.row].team_key ?? -1)"
                teamDetailsViewController.leagueId = "\(self.leagueId)"
                teamDetailsViewController.sportType = self.type
                teamDetailsViewController.teamName = teamsArray[indexPath.row].team_name
                teamDetailsViewController.teamLogo = teamsArray[indexPath.row].team_logo
                teamDetailsViewController.playersArray = teamsArray[indexPath.row].players ?? []
                navigationController?.pushViewController(teamDetailsViewController, animated: true)
                
            }
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
    
    private func getTennisCustomCollectionViewCell(cell: CustomLeagueDetailsCollectionViewCell?,indexPath: IndexPath) -> CustomLeagueDetailsCollectionViewCell?{
       
        cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.row].event_first_player_logo, secondLogo: upcomingMatchesArray[indexPath.row].event_second_player_logo, firstName: upcomingMatchesArray[indexPath.row].event_first_player, secondName: upcomingMatchesArray[indexPath.row].event_second_player, date: upcomingMatchesArray[indexPath.row].event_date, score: "N/A - N/A", time: upcomingMatchesArray[indexPath.row].event_time)
        
        return cell
    }
    
}
