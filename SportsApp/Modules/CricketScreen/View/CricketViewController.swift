//
//  CricketViewController.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit

class CricketViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,AnyCricketScreen{

    private var leaguesArray = [League]()
    private var cricketPresenter: AnyCricketPresenter = CricketPresenter()

    @IBOutlet weak var cricketTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cricketPresenter.attachView(cricketScreen: self)
        getRemoteLeagues()
        cricketTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        cricketTableView.dataSource = self
        cricketTableView.delegate = self
    }
    
    private func getRemoteLeagues(){
        cricketPresenter.getRemoteCricketLeagues(onComplete: storeLeaguesAsDictionaryLocally){
            DispatchQueue.main.async {
                self.cricketTableView.reloadData()
            }
        }
    }
    
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>){
        for i in remoteLeaguesList {
            storeLeaguesLocallyInArray(leaguesDictionary: i)
        }
    }
    
    private func storeLeaguesLocallyInArray(leaguesDictionary: Dictionary<String,Any>){
        let leagueName: String = leaguesDictionary["league_name"] as! String
        let league = League()
    
        league.title = leagueName
        league.image = "SportImagePlaceholder"
        
        leaguesArray.append(league)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguesArray.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        if leaguesArray.count > 0{
         
            cell?.setupCell(withTeamName: self.leaguesArray[indexPath.item].title ?? "Unknown", andTeamImage: UIImage(named: self.leaguesArray[indexPath.item].image ?? "")!)
            
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }

}
