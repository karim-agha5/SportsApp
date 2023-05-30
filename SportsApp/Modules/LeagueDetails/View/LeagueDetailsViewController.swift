//
//  LeagueDetailsViewController.swift
//  SportsApp
//
//  Created by Karim on 25/05/2023.
//

import UIKit

class LeagueDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    let imageString: String = "SportImagePlaceholder"
    
    var upcomingMatchesArray = [UpcomingMatch]()
    
    @IBOutlet weak var upcomingMatchesCollectionview: UICollectionView!
    
    @IBOutlet weak var currentGamescTableview: UITableView!
    
    @IBOutlet weak var teamsCollectionview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initArray()
        upcomingMatchesCollectionview.register(UINib(nibName: "CustomLeagueDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomLeagueDetailsCollectionViewCell")
        
        currentGamescTableview.register(UINib(nibName: "CustomLeagueDetailsCollectionViewCell", bundle: nil), forCellReuseIdentifier: "CustomLeagueDetailsCollectionViewCell")
        
        teamsCollectionview.register(UINib(nibName: "CustomLeagueDetailsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomLeagueDetailsCollectionViewCell")
        
        upcomingMatchesCollectionview.delegate = self
        upcomingMatchesCollectionview.dataSource = self
        
        currentGamescTableview.delegate = self
        currentGamescTableview.dataSource = self
        
        teamsCollectionview.delegate = self
        teamsCollectionview.dataSource = self
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
        // TODO Change later
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      /*  let cell = tableView.dequeueReusableCell(withIdentifier: "CustomLeagueCell",for: indexPath) as? CustomCollectionViewLeagueCell
        
        cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.item].event_home_team_logo, secondLogo: upcomingMatchesArray[indexPath.item].event_away_team_logo, firstName: upcomingMatchesArray[indexPath.item].event_home_team, secondName: upcomingMatchesArray[indexPath.item].event_away_team, date: upcomingMatchesArray[indexPath.item].event_date, score: "1-1", time: upcomingMatchesArray[indexPath.item].event_time)
        
        return cell ?? UITableViewCell()*/
        return UITableViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingMatchesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomLeagueDetailsCollectionViewCell", for: indexPath) as? CustomLeagueDetailsCollectionViewCell
        
        cell?.setupCell(firstLogo: upcomingMatchesArray[indexPath.item].event_home_team_logo, secondLogo: upcomingMatchesArray[indexPath.item].event_away_team_logo, firstName: upcomingMatchesArray[indexPath.item].event_home_team, secondName: upcomingMatchesArray[indexPath.item].event_away_team, date: upcomingMatchesArray[indexPath.item].event_date, score: "1-1", time: upcomingMatchesArray[indexPath.item].event_time)
            
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if(collectionView == upcomingMatchesCollectionview){
            let width = self.upcomingMatchesCollectionview.bounds.width * 0.95
            let height = self.upcomingMatchesCollectionview.bounds.width * 0.5
            return CGSize(width: width, height: height)
        }
        else{
            // TODO CHANGE LATER
            return CGSize(width: 400, height: 300)
        }
    }
    
    
}

