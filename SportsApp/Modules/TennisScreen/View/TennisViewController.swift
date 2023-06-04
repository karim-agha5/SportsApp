//
//  TennisViewController.swift
//  SportsApp
//
//  Created by Karim on 20/05/2023.
//

import UIKit

class TennisViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,AnyTennisScreen {

    private var tennisPresenter: AnyTennisPresenter = TennisPresenter()
    private var leaguesArray = [League]()
    
    @IBOutlet weak var tennisTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tennisPresenter.attachView(tennisScreen: self)
        getRemoteLeagues()
        tennisTableView.register(UINib(nibName: "TeamTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tennisTableView.dataSource = self
        tennisTableView.delegate = self
    }
    
    private func getRemoteLeagues(){
        tennisPresenter.getRemoteTennisLeagues(onComplete: storeLeaguesAsDictionaryLocally){
            DispatchQueue.main.async {
                self.tennisTableView.reloadData()
            }
        }
    }
    
    func storeLeaguesAsDictionaryLocally(remoteLeaguesList: Array<Dictionary<String,Any>>){
            for i in remoteLeaguesList {
                self.storeLeaguesLocallyInArray(leaguesDictionary: i)
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
        print(">>>>>>>>>>>>>>>>> tennis league id = \(league.league_key) <<<<<<<<<<<<<<<<<<")
        leaguesArray.append(league)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaguesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? TeamTableViewCell
        
        if leaguesArray.count > 0{
            cell?.setupCell(withTeamName: leaguesArray[indexPath.item].title ?? "Unknown", andTeamImageUrl: leaguesArray[indexPath.item].image ?? "")
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leagueDetailsViewController = storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsViewController") as! LeagueDetailsViewController
        leagueDetailsViewController.leagueId = leaguesArray[indexPath.item].league_key ?? -1
        leagueDetailsViewController.type = Constants.TENNIS
        navigationController?.pushViewController(leagueDetailsViewController, animated: true)
    }

}
